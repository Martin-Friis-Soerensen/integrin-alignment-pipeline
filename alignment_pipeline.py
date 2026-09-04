"""
Integrin Structural Alignment Pipeline
Copyright (c) 2026 Martin Friis Sørensen

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.

Author: Martin Friis Sørensen
Email: mfs@mbg.au.dk
Date: May 19, 2026

Description: 
Automated pipeline for the conformational analysis and structural alignment of integrin alpha subunits. Fetches sequences via UniProt, queries RCSB PDB, and executes native PyMOL geometric alignments to generate structured Excel reports and dynamically written PyMOL visualization scripts (.pml).
"""

import os
import requests
import pandas as pd
import sys
import re
import json
import csv
import subprocess
from datetime import datetime

# =========================================================
# INITIALIZE HEADLESS PYMOL & IMPORTS
# =========================================================
try:
    import pymol
    pymol.pymol_argv = ['pymol', '-qc']
    pymol.finish_launching()
    from pymol import cmd
except ImportError:
    print("\nERROR: PyMOL is not installed or not accessible in this environment.")
    print("Please ensure you activate your PyMOL environment (e.g., 'conda activate pymol').")
    sys.exit()

try:
    from Bio import Align
except ImportError:
    print("\nERROR: Biopython is not installed.")
    print("Please run: pip install biopython")
    sys.exit()

# =========================================================
# GLOBAL DIRECTORY SETUP
# =========================================================
BASE_DIR = os.getcwd()

FOLDERS = {
    "csv": os.path.join(BASE_DIR, "CSV_files"),
    "cif": os.path.join(BASE_DIR, "CIF_files"),
    "res": os.path.join(BASE_DIR, "Alignment_Results"),
    "excel": os.path.join(BASE_DIR, "Excel_Reports"),
    "pml": os.path.join(BASE_DIR, "PyMOL_Scripts") # New folder for .pml files
}

for folder in FOLDERS.values():
    os.makedirs(folder, exist_ok=True)

# =========================================================
# HELPER FUNCTIONS
# =========================================================
def parse_fasta_file(filepath):
    sequences = {}
    with open(filepath, 'r') as f:
        name = "Unknown"
        seq = []
        for line in f:
            line = line.strip()
            if line.startswith(">"):
                if seq: sequences[name] = "".join(seq)
                name = line[1:].split()[0]
                name = re.sub(r'[\\/*?:"<>|]', "", name)
                seq = []
            else:
                seq.append(line)
        if seq: sequences[name] = "".join(seq)
    return sequences

def read_pdb_csv(csv_filename):
    csv_path = os.path.join(FOLDERS["csv"], csv_filename) 
    if not os.path.exists(csv_path): return []
    pdb_ids = []
    with open(csv_path, mode='r', encoding='utf-8-sig') as file: 
        reader = csv.reader(file, delimiter=';')
        pdb_col_idx = -1
        for row in reader:
            clean_row = [col.strip() for col in row]
            if 'PDB ID' in clean_row:
                pdb_col_idx = clean_row.index('PDB ID')
                break 
        if pdb_col_idx == -1: return []
        for row in reader:
            if len(row) > pdb_col_idx:
                pdb = row[pdb_col_idx].strip()
                if len(pdb) == 4 and pdb not in pdb_ids:
                    pdb_ids.append(pdb)
    return pdb_ids

def export_json(filename, metadata, results):
    out_path = os.path.join(FOLDERS["res"], filename)
    with open(out_path, 'w', encoding='utf-8') as f:
        json.dump({"metadata": metadata, "results": results}, f, indent=4)
    print(f"   -> Saved JSON data to: {filename}")

def get_fasta_seq(selection):
    raw_fasta = cmd.get_fastastr(selection)
    if not raw_fasta: return ""
    return "".join([line for line in raw_fasta.split('\n') if not line.startswith('>')])

def print_progress_bar(iteration, total, prefix='', suffix='', decimals=1, length=40, fill='█', printEnd="\r"):
    """
    Call in a loop to create a terminal progress bar
    @params:
        iteration   - Required  : current iteration (Int)
        total       - Required  : total iterations (Int)
        prefix      - Optional  : prefix string (Str)
        suffix      - Optional  : suffix string (Str)
        decimals    - Optional  : positive number of decimals in percent complete (Int)
        length      - Optional  : character length of bar (Int)
        fill        - Optional  : bar fill character (Str)
    """
    percent = ("{0:." + str(decimals) + "f}").format(100 * (iteration / float(total)))
    filledLength = int(length * iteration // total)
    bar = fill * filledLength + '-' * (length - filledLength)
    print(f'\r{prefix} |{bar}| {percent}% {suffix}', end=printEnd)
    if iteration == total: 
        print()

# =========================================================
# API FUNCTIONS (UniProt & RCSB)
# =========================================================
def fetch_uniprot_sequence(uniprot_id):
    url = f"https://rest.uniprot.org/uniprotkb/{uniprot_id}.fasta"
    try:
        response = requests.get(url)
        response.raise_for_status() 
        lines = response.text.split('\n')
        return "".join([line for line in lines if not line.startswith('>')]).strip()
    except requests.exceptions.RequestException as e:
        print(f"Error fetching UniProt for {uniprot_id}: {e}")
        return None

def search_pdb_homologs(sequence, identity_cutoff=0.85):
    print(f"-> Searching RCSB PDB for >= {identity_cutoff*100}% identity...")
    url = "https://search.rcsb.org/rcsbsearch/v2/query"
    query_payload = {
        "query": {
            "type": "terminal", "service": "sequence",
            "parameters": {"evalue_cutoff": 0.001, "identity_cutoff": identity_cutoff, "target": "pdb_protein_sequence", "value": sequence}
        },
        "request_options": {"return_all_hits": True},
        "return_type": "entry"
    }
    try:
        response = requests.post(url, json=query_payload)
        if response.status_code == 204: return []
        response.raise_for_status()
        data = response.json()
        return [item["identifier"] for item in data.get("result_set", [])]
    except Exception as e:
        print(f"   -> Error querying PDB: {e}")
        return []

def generate_pdb_csv(pdb_ids, output_filename):
    if not pdb_ids: return print(f"   -> Skipping CSV generation (0 matches).")
    print(f"-> Fetching metadata for {len(pdb_ids)} structures...")
    
    graphql_query = """
    query GetStructures($ids: [String!]!) {
      entries(entry_ids: $ids) {
        rcsb_id
        struct { title }
        rcsb_accession_info { initial_release_date }
        rcsb_primary_citation { pdbx_database_id_PubMed }
        rcsb_entry_container_identifiers { emdb_ids }
      }
    }
    """
    try:
        response = requests.post("https://data.rcsb.org/graphql", json={"query": graphql_query, "variables": {"ids": pdb_ids}})
        response.raise_for_status()
        data = response.json()
        
        parsed_data = []
        for entry in data.get('data', {}).get('entries', []):
            pdb_id = entry.get('rcsb_id', '')
            title = (entry.get('struct') or {}).get('title', '')
            date = (entry.get('rcsb_accession_info') or {}).get('initial_release_date', '').split('T')[0]
            pmid = (entry.get('rcsb_primary_citation') or {}).get('pdbx_database_id_PubMed', '')
            
            containers = entry.get('rcsb_entry_container_identifiers') or {}
            emdb_ids = containers.get('emdb_ids')
            emdb_str = ", ".join(emdb_ids) if emdb_ids else ''
            
            parsed_data.append({
                "Entry ID": pdb_id, 
                "PubMed ID": pmid, 
                "Release Date": date, 
                "EMDB MAP": emdb_str, 
                "PDB ID": pdb_id, 
                "Structure Title": title
            })
            
        df = pd.DataFrame(parsed_data, columns=["Entry ID", "PubMed ID", "Release Date", "EMDB MAP", "PDB ID", "Structure Title"])
        df.to_csv(os.path.join(FOLDERS["csv"], output_filename), sep=';', index=False, encoding='utf-8-sig')
    except Exception as e:
        print(f"   -> Error querying RCSB Data API: {e}")

# =========================================================
# PYMOL ALIGNMENT ALGORITHMS
# =========================================================
def align_propeller(csv_filename, seq_cutoff=0.85, ref_pdb="9T3Y", ref_chain="A", prop_resi="1-126+322-600"):
    cmd.reinitialize() 
    cmd.set("fetch_path", FOLDERS["cif"]) 
    pdb_ids = read_pdb_csv(csv_filename)
    if not pdb_ids: return
    if ref_pdb in pdb_ids: pdb_ids.remove(ref_pdb)

    safe_ref = f"ref_{ref_pdb}"
    cmd.fetch(ref_pdb, name=safe_ref)
    ref_sel = f"{safe_ref}_propeller"
    cmd.select(ref_sel, f"{safe_ref} and chain {ref_chain} and resi {prop_resi}")

    results = []
    cmd.set("suspend_updates", 1) 

    total_pdbs = len(pdb_ids)
    print(f"      Aligning {total_pdbs} structures to propeller...")
    
    print_progress_bar(0, total_pdbs, prefix='      Progress:', suffix='Complete', length=40)
    
    for i, tgt in enumerate(pdb_ids):
        safe_tgt = f"obj_{tgt}"
        cmd.fetch(tgt, name=safe_tgt)
        try:
            res = cmd.super(safe_tgt, ref_sel, quiet=1)
            rmsd, atoms = round(res[0], 3), int(res[1])
            
            if atoms < 200:
                results.append({"Structure_ID": tgt, "Propeller Ref": ref_pdb, "Propeller RMSD (Å)": "N/A", "Propeller Atoms": "N/A", "Propeller Status": f"Excluded (Only {atoms} atoms aligned)"})
            elif rmsd > 2.0:
                results.append({"Structure_ID": tgt, "Propeller Ref": ref_pdb, "Propeller RMSD (Å)": "N/A", "Propeller Atoms": "N/A", "Propeller Status": f"Excluded (High RMSD: {rmsd} Å - Missing Propeller)"})
            else:
                results.append({"Structure_ID": tgt, "Propeller Ref": ref_pdb, "Propeller RMSD (Å)": rmsd, "Propeller Atoms": atoms, "Propeller Status": "Successful"})
        except:
            results.append({"Structure_ID": tgt, "Propeller Ref": ref_pdb, "Propeller RMSD (Å)": "N/A", "Propeller Atoms": "N/A", "Propeller Status": "Excluded (Math Error / No Match)"})
        cmd.delete(safe_tgt)

        print_progress_bar(i + 1, total_pdbs, prefix='      Progress:', suffix=f'({tgt})    ', length=40)

    cmd.set("suspend_updates", 0) 
    cutoff_str = int(seq_cutoff * 100)
    export_json(f"{csv_filename.replace('.csv', '')}_{cutoff_str}_Propeller.json", {"Reference": ref_pdb, "Domain": "Beta-Propeller"}, results)

def angle_align(csv_filename, seq_cutoff=0.85, ref_pdb="7USM", ref_chain="A", MAX_RMSD=4):
    MIN_ATOMS = 150    

    cmd.reinitialize() 
    cmd.set("fetch_path", FOLDERS["cif"])
    pdb_ids = read_pdb_csv(csv_filename)
    if not pdb_ids: return
    if ref_pdb in pdb_ids: pdb_ids.remove(ref_pdb)

    results = []
    cmd.set("suspend_updates", 1)

    cmd.feedback("disable", "all", "actions")
    cmd.feedback("disable", "all", "results")
    cmd.feedback("disable", "all", "warnings")
    cmd.feedback("disable", "all", "output")

    safe_ref = f"ref_{ref_pdb}"
    cmd.fetch(ref_pdb, name=safe_ref)
    cmd.remove(f"{safe_ref} and not state 1")
    ref_p1 = f"{safe_ref} and chain {ref_chain} and resi 906 and name CA"
    ref_vertex = f"{safe_ref} and chain {ref_chain} and resi 751 and name CA"
    ref_p2 = f"{safe_ref} and chain {ref_chain} and resi 599 and name CA"
    
    try:
        ref_angle = cmd.get_angle(ref_p1, ref_vertex, ref_p2)
        results.append({"Structure_ID": ref_pdb, "Angle Ref": ref_pdb, "Thigh-Calf Angle (°)": round(ref_angle, 2), "Angle Status": "Baseline Reference"})
    except:
        pass

    total_pdbs = len(pdb_ids)
    print(f"      Measuring angles for {total_pdbs} structures...")
    
    print_progress_bar(0, total_pdbs, prefix='      Progress:', suffix='Complete', length=40)

    for i, tgt in enumerate(pdb_ids):
        safe_tgt = f"obj_{tgt}"
        cmd.fetch(tgt, name=safe_tgt)
        try:
            atom_count = cmd.count_atoms(f"{safe_tgt} and polymer.protein")
            if atom_count == 0:
                results.append({"Structure_ID": tgt, "Angle Ref": ref_pdb, "Thigh-Calf Angle (°)": "N/A", "Angle Status": "Excluded (Fetch Failed / Empty Structure)"})
                cmd.delete(safe_tgt)
                continue
        except:
            results.append({"Structure_ID": tgt, "Angle Ref": ref_pdb, "Thigh-Calf Angle (°)": "N/A", "Angle Status": "Excluded (Fetch Failed)"})
            if safe_tgt in cmd.get_names(): cmd.delete(safe_tgt)
            continue
        cmd.remove(f"{safe_tgt} and not state 1")
        
        best_c, best_atoms = None, 0
        for c in cmd.get_chains(f"{safe_tgt} and polymer.protein"):
            try:
                res = cmd.align(f"{safe_tgt} and chain {c}", f"{safe_ref} and chain {ref_chain}", transform=0, quiet=1)
                if res[1] > best_atoms: best_atoms, best_c = res[1], c
            except: pass
            
        if not best_c:
            results.append({"Structure_ID": tgt, "Angle Ref": ref_pdb, "Thigh-Calf Angle (°)": "N/A", "Angle Status": "Excluded (No matching chain)"})
            cmd.delete(safe_tgt)
            continue
            
        tgt_alpha = f"{safe_tgt} and chain {best_c}"
        tgt_thigh, tgt_calf = f"{safe_tgt}_thigh", f"{safe_tgt}_calf"
        cmd.create(tgt_thigh, f"{safe_ref} and chain {ref_chain}")
        cmd.create(tgt_calf, f"{safe_ref} and chain {ref_chain}")
        
        try:
            t_res = cmd.align(f"{tgt_thigh} and resi 599-751", tgt_alpha, quiet=1)
            c_res = cmd.align(f"{tgt_calf} and resi 761-906", tgt_alpha, quiet=1)
            thigh_rmsd, thigh_atoms = t_res[:2]
            calf_rmsd, calf_atoms = c_res[:2]
            
            if thigh_atoms < MIN_ATOMS or calf_atoms < MIN_ATOMS:
                results.append({"Structure_ID": tgt, "Angle Ref": ref_pdb, "Thigh-Calf Angle (°)": "N/A", "Angle Status": f"Excluded (Low Atom Match)"})
            elif thigh_rmsd > MAX_RMSD or calf_rmsd > MAX_RMSD:
                results.append({"Structure_ID": tgt, "Angle Ref": ref_pdb, "Thigh-Calf Angle (°)": "N/A", "Angle Status": f"Excluded (High RMSD)"})
            else:
                p1 = f"{tgt_calf} and resi 906 and name CA"
                p_vertex = f"{tgt_thigh} and resi 751 and name CA"
                p2 = f"{tgt_thigh} and resi 599 and name CA"
                angle = cmd.get_angle(p1, p_vertex, p2)
                results.append({"Structure_ID": tgt, "Angle Ref": ref_pdb, "Thigh-Calf Angle (°)": round(angle, 2), "Angle Status": "Successful"})
        except:
            results.append({"Structure_ID": tgt, "Angle Ref": ref_pdb, "Thigh-Calf Angle (°)": "N/A", "Angle Status": "Excluded (Math Error)"})
            
        cmd.delete(tgt_thigh); cmd.delete(tgt_calf); cmd.delete(safe_tgt)

        print_progress_bar(i + 1, total_pdbs, prefix='      Progress:', suffix=f'({tgt})    ', length=40)

    cmd.feedback("enable", "all", "actions")
    cmd.feedback("enable", "all", "results")
    cmd.feedback("enable", "all", "warnings")
    cmd.feedback("enable", "all", "output")
    cmd.set("suspend_updates", 0)
    
    cutoff_str = int(seq_cutoff * 100)
    export_json(f"{csv_filename.replace('.csv', '')}_{cutoff_str}_Angles.json", {"Reference": ref_pdb}, results)

def align_integrin(csv_filename, seq_cutoff=0.85, ref_pdb="9T3Y", ref_chain="A"):
    cmd.reinitialize() 
    cmd.set("fetch_path", FOLDERS["cif"]) 

    pdb_ids = read_pdb_csv(csv_filename)
    if not pdb_ids: return
    if ref_pdb in pdb_ids: pdb_ids.remove(ref_pdb)

    safe_ref = f"ref_{ref_pdb}"
    cmd.fetch(ref_pdb, name=safe_ref)
    
    results = []
    cmd.set("suspend_updates", 1) 

    total_pdbs = len(pdb_ids)
    print(f"      Aligning {total_pdbs} structures...")
    
    print_progress_bar(0, total_pdbs, prefix='      Progress:', suffix='Complete', length=40)
    
    for i, tgt in enumerate(pdb_ids):
        safe_tgt = f"obj_{tgt}"
        cmd.fetch(tgt, name=safe_tgt)
        try:
            res = cmd.super(safe_tgt, safe_ref, quiet=1)
            rmsd, atoms = round(res[0], 3), int(res[1])
            results.append({"Structure_ID": tgt, "Whole Ref": ref_pdb, "Whole RMSD (Å)": rmsd, "Whole Atoms": atoms, "Whole Status": "Successful"})
        except:
            results.append({"Structure_ID": tgt, "Whole Ref": ref_pdb, "Whole RMSD (Å)": "N/A", "Whole Atoms": "N/A", "Whole Status": "Excluded (Math Error)"})
            
        cmd.delete(safe_tgt)

        print_progress_bar(i + 1, total_pdbs, prefix='      Progress:', suffix=f'({tgt})    ', length=40)

    cmd.set("suspend_updates", 0) 
    cutoff_str = int(seq_cutoff * 100)
    export_json(f"{csv_filename.replace('.csv', '')}_{cutoff_str}_Whole.json", {"Reference": ref_pdb, "Domain": "Whole Structure"}, results)

def smart_align(csv_filename, seq_cutoff=0.85, ref_pdb="9T3Y", ref_chain="A", prop_resi="1-126+322-600"):
    cmd.reinitialize() 
    cmd.set("fetch_path", FOLDERS["cif"])

    pdb_ids = read_pdb_csv(csv_filename)
    if not pdb_ids: return 
    if ref_pdb in pdb_ids: pdb_ids.remove(ref_pdb)

    safe_ref = f"ref_{ref_pdb}"
    cmd.fetch(ref_pdb, name=safe_ref)
    ref_sel_name = f"{safe_ref}_propeller"
    cmd.select(ref_sel_name, f"{safe_ref} and chain {ref_chain} and resi {prop_resi}")
    
    ref_a_seq = get_fasta_seq(f"{safe_ref} and chain {ref_chain} and polymer.protein")
    ref_b_seq = get_fasta_seq(f"{safe_ref} and not chain {ref_chain} and polymer.protein")
    
    aligner = Align.PairwiseAligner()
    aligner.mode = 'local' 

    results = []
    cmd.set("suspend_updates", 1)
    cmd.feedback("disable", "all", "actions") 
    cmd.feedback("disable", "all", "results")

    total_pdbs = len(pdb_ids)
    print(f"      Aligning {total_pdbs} structures...")
    
    print_progress_bar(0, total_pdbs, prefix='      Progress:', suffix='Complete', length=40)

    for i, tgt in enumerate(pdb_ids):
        safe_tgt = f"obj_{tgt}"
        cmd.fetch(tgt, name=safe_tgt)
        try:
            atom_count = cmd.count_atoms(f"{safe_tgt} and polymer.protein")
            if atom_count == 0:
                results.append({"Structure_ID": tgt, "Smart Ref": ref_pdb, "Smart RMSD (Å)": "N/A", "Smart Atoms": "N/A", "Smart Method": "N/A", "Smart Status": "Excluded (Fetch Failed / Empty Structure)"})
                cmd.delete(safe_tgt)
                continue
        except:
            results.append({"Structure_ID": tgt, "Smart Ref": ref_pdb, "Smart RMSD (Å)": "N/A", "Smart Atoms": "N/A", "Smart Method": "N/A", "Smart Status": "Excluded (Fetch Failed)"})
            if safe_tgt in cmd.get_names(): cmd.delete(safe_tgt)
            continue
        cmd.remove(f"{safe_tgt} and not state 1")
        
        alpha_cands, beta_cands = [], []
        
        for c in cmd.get_chains(f"{safe_tgt} and polymer.protein"):
            t_seq = get_fasta_seq(f"{safe_tgt} and chain {c} and polymer.protein")
            if len(t_seq) < 50: continue 
            
            a_score = aligner.align(ref_a_seq, t_seq)[0].score
            b_score = aligner.align(ref_b_seq, t_seq)[0].score
            
            if a_score > 100 and a_score > b_score:
                alpha_cands.append((c, (a_score / len(t_seq)) * 100, len(t_seq)))
            elif b_score > 100 and b_score > a_score:
                beta_cands.append((c, (b_score / len(t_seq)) * 100, len(t_seq)))

        best_a_data = sorted(alpha_cands, key=lambda x: x[1], reverse=True)[0] if alpha_cands else None
        best_b_data = sorted(beta_cands, key=lambda x: x[1], reverse=True)[0] if beta_cands else None

        best_a = best_a_data[0] if best_a_data else None
        a_id_pct = best_a_data[1] if best_a_data else 0
        a_len = best_a_data[2] if best_a_data else 0
        best_b = best_b_data[0] if best_b_data else None

        core_chains = [c for c in [best_a, best_b] if c]

        if not core_chains or (best_a and a_len < 100 and not best_b):
            results.append({"Structure_ID": tgt, "Smart Ref": ref_pdb, "Smart RMSD (Å)": "N/A", "Smart Atoms": "N/A", "Smart Method": "N/A", "Smart Status": "Excluded (Fragment)"})
            cmd.delete(safe_tgt)
            continue

        core_sel = f"{safe_tgt} and chain {'+'.join(core_chains)}"
        alpha_sel = f"{safe_tgt} and chain {best_a}" if best_a else core_sel
        
        try: w_rmsd, w_atoms = cmd.super(core_sel, safe_ref, quiet=1)[:2]
        except: w_rmsd, w_atoms = 99.9, 0
        
        try: p_rmsd, p_atoms = cmd.super(alpha_sel, ref_sel_name, quiet=1)[:2]
        except: p_rmsd, p_atoms = 99.9, 0
        
        try: s_rmsd, s_atoms = cmd.align(core_sel, safe_ref, quiet=1)[:2]
        except: s_rmsd, s_atoms = 99.9, 0

        max_atoms = max(int(w_atoms), int(p_atoms), int(s_atoms))

        if max_atoms < 180: 
            method, final_rmsd, final_atoms = f"Sequence ({a_id_pct:.1f}% ID)", s_rmsd, int(s_atoms)
        elif p_rmsd < 2.0 and w_rmsd > 3.0:
            method, final_rmsd, final_atoms = f"Geometry: Propeller ({a_id_pct:.1f}% ID)", p_rmsd, int(p_atoms)
        elif w_rmsd < 4.5:
            method, final_rmsd, final_atoms = f"Geometry: Whole ({a_id_pct:.1f}% ID)", w_rmsd, int(w_atoms)
        else:
            method, final_rmsd, final_atoms = f"Sequence ({a_id_pct:.1f}% ID)", s_rmsd, int(s_atoms)

        results.append({"Structure_ID": tgt, "Smart Ref": ref_pdb, "Smart RMSD (Å)": round(final_rmsd, 3), "Smart Atoms": final_atoms, "Smart Method": method, "Smart Status": "Successful"})
        cmd.delete(safe_tgt)

        print_progress_bar(i + 1, total_pdbs, prefix='      Progress:', suffix=f'({tgt})    ', length=40)

    cmd.feedback("enable", "all", "actions")
    cmd.feedback("enable", "all", "results")
    cmd.set("suspend_updates", 0)
    
    cutoff_str = int(seq_cutoff * 100)
    export_json(f"{csv_filename.replace('.csv', '')}_{cutoff_str}_Smart.json", {"Reference": ref_pdb}, results)

# =========================================================
# CENTRAL PIPELINE FUNCTIONS
# =========================================================
def execute_pymol_alignments(csv_filename, functions_to_run, seq_cutoff=0.85, force_redo=False, ref_pdb="9T3Y", prop_resi="1-126+322-600", MAX_RMSD=4):
    print(f"-> Checking PyMOL protocols for {csv_filename}...")
    base_name = csv_filename.replace('.csv', '')
    cutoff_str = int(seq_cutoff * 100)
    
    func_suffix_map = {
        "align_propeller": f"_{cutoff_str}_Propeller.json",
        "angle_align": f"_{cutoff_str}_Angles.json",
        "align_integrin": f"_{cutoff_str}_Whole.json",  
        "smart_align": f"_{cutoff_str}_Smart.json"      
    }
    
    cmds_to_run = []
    for func in functions_to_run:
        expected_suffix = func_suffix_map.get(func, ".json")
        res_path = os.path.join(FOLDERS["res"], f"{base_name}{expected_suffix}")
        
        if os.path.exists(res_path) and not force_redo:
            print(f"   -> Cached data found for {func}. Skipping execution.")
        else:
            if force_redo and os.path.exists(res_path):
                print(f"   -> Redo requested. Overwriting cached data for {func}.")
            cmds_to_run.append(func)
            
    if not cmds_to_run:
        print("   -> All requested PyMOL protocols already exist. Moving to compilation.")
        return

    print(f"   -> Executing missing PyMOL protocols natively: {', '.join(cmds_to_run)}")
    
    for func in cmds_to_run:
        print(f"      [Running: {func}]")
        if func == "align_propeller":
            align_propeller(csv_filename, seq_cutoff=seq_cutoff, ref_pdb=ref_pdb, prop_resi=prop_resi)
        elif func == "angle_align":
            angle_align(csv_filename, seq_cutoff=seq_cutoff, MAX_RMSD=MAX_RMSD) 
        elif func == "align_integrin":
            align_integrin(csv_filename, seq_cutoff=seq_cutoff, ref_pdb=ref_pdb)
        elif func == "smart_align":
            smart_align(csv_filename, seq_cutoff=seq_cutoff, ref_pdb=ref_pdb, prop_resi=prop_resi)

def compile_results(integrin_dict, base_filename, seq_cutoff, timestamp):
    print(f"\n-> Consolidating JSON results into Excel format...")
    final_filename = f"{base_filename}_{timestamp}.xlsx"
    excel_path = os.path.join(FOLDERS["excel"], final_filename)
    cutoff_str = int(seq_cutoff * 100)
    
    try:
        all_meta_list = []
        all_results_list = []
        individual_sheets = {} 
        
        for name in integrin_dict.keys():
            df_meta = None
            csv_path = os.path.join(FOLDERS["csv"], f"{name}.csv")
            if os.path.exists(csv_path):
                df_meta = pd.read_csv(csv_path, sep=';', encoding='utf-8-sig')
                
                df_meta_master = df_meta.copy()
                df_meta_master.insert(0, 'Integrin_Target', name)
                all_meta_list.append(df_meta_master)
            
            df_combined = None
            ordered_suffixes = [f"_{cutoff_str}_Propeller.json", f"_{cutoff_str}_Angles.json", f"_{cutoff_str}_Whole.json", f"_{cutoff_str}_Smart.json"]
            
            for suffix in ordered_suffixes:
                json_path = os.path.join(FOLDERS["res"], f"{name}{suffix}")
                if os.path.exists(json_path):
                    with open(json_path, 'r') as f:
                        data = json.load(f)
                        df_temp = pd.DataFrame(data["results"])
                        
                        if df_combined is None:
                            df_combined = df_temp
                        else:
                            if 'Structure_ID' in df_combined.columns and 'Structure_ID' in df_temp.columns:
                                df_combined = pd.merge(df_combined, df_temp, on='Structure_ID', how='outer')
            
            if df_combined is not None and not df_combined.empty:
                if 'Propeller RMSD (Å)' in df_combined.columns:
                    df_combined['Propeller RMSD (Å)'] = pd.to_numeric(df_combined['Propeller RMSD (Å)'], errors='coerce')
                
                df_combined['is_ref'] = df_combined.apply(lambda row: any(isinstance(v, str) and "Reference" in v for v in row.values), axis=1)
                
                has_propeller = 'Propeller RMSD (Å)' in df_combined.columns
                df_combined['is_excluded'] = df_combined['Propeller RMSD (Å)'].isna() if has_propeller else False
                
                if has_propeller:
                    df_combined.sort_values(by=['is_ref', 'is_excluded', 'Propeller RMSD (Å)', 'Structure_ID'], ascending=[True, True, True, True], inplace=True)
                else:
                    df_combined.sort_values(by=['is_ref', 'Structure_ID'], ascending=[True, True], inplace=True)
                
                df_combined.drop(columns=['is_ref', 'is_excluded'], inplace=True)
                
                df_combined = df_combined.astype(object)
                df_combined.fillna('N/A', inplace=True)
                
                df_combined_master = df_combined.copy()
                df_combined_master.insert(0, 'Integrin_Target', name)
                all_results_list.append(df_combined_master)

            individual_sheets[name] = {'meta': df_meta, 'results': df_combined}

        with pd.ExcelWriter(excel_path, engine='openpyxl') as writer:
            sheets_created = 0
            
            if all_meta_list:
                master_meta_df = pd.concat(all_meta_list, ignore_index=True)
                master_meta_df.to_excel(writer, sheet_name="00_All_Metadata", index=False)
                sheets_created += 1
                
            if all_results_list:
                master_results_df = pd.concat(all_results_list, ignore_index=True)
                
                is_ref = master_results_df.apply(lambda row: any(isinstance(v, str) and "Reference" in v for v in row.values), axis=1)
                
                ref_duplicates = master_results_df[is_ref].duplicated(subset=['Structure_ID'], keep='first')
                indices_to_drop = ref_duplicates[ref_duplicates].index
                
                master_results_df = master_results_df.drop(indices_to_drop)
                
                master_results_df.to_excel(writer, sheet_name="00_All_Results", index=False)
                sheets_created += 1
            
            for name, sheets in individual_sheets.items():
                if sheets['meta'] is not None and not sheets['meta'].empty:
                    sheets['meta'].to_excel(writer, sheet_name=f"{name}_Metadata"[:31], index=False)
                    sheets_created += 1
                if sheets['results'] is not None and not sheets['results'].empty:
                    sheets['results'].to_excel(writer, sheet_name=f"{name}_Results"[:31], index=False)
                    sheets_created += 1

            if sheets_created == 0:
                pd.DataFrame(["No data found to compile"]).to_excel(writer, sheet_name="Empty_Report", index=False)

        print(f"   -> Excel Report generated successfully: {excel_path}")
    except Exception as e:
        print(f"   -> Unexpected error generating Excel file: {e}")


# =========================================================
# PYMOL .PML SCRIPT GENERATOR (GROUP-BASED VISUALIZATION)
# =========================================================
def build_visual_session(targets_dict, seq_cutoff, functions_to_run, ref_pdb, prop_resi, base_filename, timestamp):
    print("\n-> Building Static PyMOL Grouping Script (.pml)...")
    pml_filename = f"{base_filename}_{timestamp}.pml"
    pml_path = os.path.join(FOLDERS["pml"], pml_filename)
    cutoff_str = int(seq_cutoff * 100)
    
    with open(pml_path, "w", encoding='utf-8') as f:
        f.write(f"set fetch_path, {FOLDERS['cif'].replace(os.sep, '/')}\n")
        f.write("bg_color black\n")
        f.write("set dash_color, yellow\n")
        f.write("set angle_color, yellow\n")
        f.write("set dash_gap, 0.4\n")
        f.write("set dash_width, 3.0\n\n")

        f.write("set suspend_undo, 1\n\n")

        f.write(f"fetch {ref_pdb}, ref_{ref_pdb}\n")
        f.write(f"remove ref_{ref_pdb} and not state 1\n")
        f.write(f"select ref_{ref_pdb}_propeller, ref_{ref_pdb} and chain A and resi {prop_resi}\n")
        f.write(f"show cartoon, ref_{ref_pdb}\n")
        f.write(f"color gray30, ref_{ref_pdb}\n")
        f.write(f"color forest, ref_{ref_pdb}_propeller\n")
        f.write(f"disable ref_{ref_pdb}\n\n")

        if "angle_align" in functions_to_run:
            f.write("fetch 7USM, ref_7USM\n")
            f.write("remove ref_7USM and not state 1\n")
            f.write("show cartoon, ref_7USM\n")
            f.write("color gray30, ref_7USM\n")
            f.write("color green, ref_7USM and chain A and resi 599-751\n")
            f.write("color cyan, ref_7USM and chain A and resi 761-906\n")
            f.write("angle ref_7USM_angle, ref_7USM and chain A and resi 906 and name CA, ref_7USM and chain A and resi 751 and name CA, ref_7USM and chain A and resi 599 and name CA\n")
            f.write("disable ref_7USM\n")
            f.write("disable ref_7USM_angle\n\n")

        func_suffix_map = {
            "align_propeller": (f"_{cutoff_str}_Propeller.json", "Prop", "cyan", f"ref_{ref_pdb}_propeller"),
            "angle_align": (f"_{cutoff_str}_Angles.json", "Angle", "", ""),
            "align_integrin": (f"_{cutoff_str}_Whole.json", "Whole", "orange", f"ref_{ref_pdb}"),
            "smart_align": (f"_{cutoff_str}_Smart.json", "Smart", "purple", f"ref_{ref_pdb}_propeller")
        }

        for name in targets_dict.keys():
            for func in functions_to_run:
                if func not in func_suffix_map: continue
                suffix, short_name, color, ref_sel = func_suffix_map[func]
                
                json_path = os.path.join(FOLDERS["res"], f"{name}{suffix}")
                if not os.path.exists(json_path): continue
                
                successful_pdbs = []
                with open(json_path, 'r') as jf:
                    data = json.load(jf)
                    for res in data.get("results", []):
                        status_key = [k for k in res.keys() if "Status" in k][0]
                        if "Successful" in str(res[status_key]):
                            successful_pdbs.append(res["Structure_ID"])
                
                if not successful_pdbs: continue
                
                master_grp_name = f"Grp_{name}_{short_name}"
                f.write(f"\n# === {name} {short_name} Alignments ===\n")
                
                for tgt in successful_pdbs:
                    obj_name = f"{tgt}_{short_name}"
                    f.write(f"fetch {tgt}, {obj_name}\n")
                    f.write(f"remove {obj_name} and not state 1\n")
                    f.write(f"show cartoon, {obj_name}\n")

                    if func == "angle_align":
                        tgt_thigh = f"{obj_name}_thigh"
                        tgt_calf = f"{obj_name}_calf"
                        ang_name = f"{obj_name}_angle"
                        subgrp_name = f"Sub_{obj_name}"
                        
                        f.write(f"create {tgt_thigh}, ref_7USM and chain A\n")
                        f.write(f"create {tgt_calf}, ref_7USM and chain A\n")
                        f.write(f"show cartoon, {tgt_thigh}\n")
                        f.write(f"show cartoon, {tgt_calf}\n")
                        
                        f.write(f"align {tgt_thigh} and resi 599-751, {obj_name}\n")
                        f.write(f"align {tgt_calf} and resi 761-906, {obj_name}\n")
                        f.write(f"angle {ang_name}, {tgt_calf} and resi 906 and name CA, {tgt_thigh} and resi 751 and name CA, {tgt_thigh} and resi 599 and name CA\n")
                        f.write(f"remove {tgt_thigh} and not resi 599-751\n")
                        f.write(f"remove {tgt_calf} and not resi 761-906\n")
                        
                        f.write(f"color gray70, {obj_name}\n")
                        f.write(f"color palegreen, {tgt_thigh}\n")
                        f.write(f"color aquamarine, {tgt_calf}\n")
                        
                        f.write(f"group {subgrp_name}, {obj_name} {tgt_thigh} {tgt_calf} {ang_name}\n")
                        f.write(f"group {master_grp_name}, {subgrp_name}\n")
                        
                    else:
                        if func == "align_integrin":
                            f.write(f"super {obj_name}, ref_{ref_pdb}\n")
                        else:
                            f.write(f"super {obj_name}, {ref_sel}\n")
                        
                        f.write(f"color {color}, {obj_name}\n")
                        f.write(f"group {master_grp_name}, {obj_name}\n")

                f.write(f"disable {master_grp_name}\n")

        f.write(f"\nenable ref_{ref_pdb}\n")
        f.write(f"zoom ref_{ref_pdb}\n")

    print(f"   -> PyMOL script generated successfully: {pml_path}")
    print("   -> Launching PyMOL GUI. Please interact with the new window!")
    subprocess.Popen(f'pymol -q "{pml_path}"', shell=True)

def run_pipeline(targets, pymol_commands, source_type="uniprot", identity_cutoff=0.85, force_redo=False, ref_pdb="9T3Y", prop_resi="1-126+322-600", is_visual=False, MAX_RMSD=4):
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    
    for name, data in targets.items():
        print(f"\n{'='*50}\nInitiating pipeline for {name}\n{'='*50}")
        
        if source_type == "csv":
            csv_name = data 
            csv_path = os.path.join(FOLDERS["csv"], csv_name)
            
            if not os.path.exists(csv_path):
                print(f"   -> ERROR: Could not find '{csv_name}' in the CSV_files folder.")
                continue
            
            print(f"-> Bypassing PDB search. Utilizing existing file: {csv_name}")
            execute_pymol_alignments(csv_name, pymol_commands, seq_cutoff=identity_cutoff, force_redo=force_redo, ref_pdb=ref_pdb, prop_resi=prop_resi, MAX_RMSD=MAX_RMSD)
            
        else:
            csv_name = f"{name}.csv"
            seq = fetch_uniprot_sequence(data) if source_type == "uniprot" else data 
            
            if not seq:
                print(f"   -> Skipping {name}: No sequence obtained.")
                continue
                
            pdb_ids = search_pdb_homologs(seq, identity_cutoff=identity_cutoff)
            generate_pdb_csv(pdb_ids, csv_name)
            execute_pymol_alignments(csv_name, pymol_commands, seq_cutoff=identity_cutoff, force_redo=force_redo, ref_pdb=ref_pdb, prop_resi=prop_resi)
            
    base_name = "Master_Integrin_Report" if source_type == "uniprot" and len(targets) > 10 else f"Custom_Report_{list(targets.keys())[0]}"
    compile_results(targets, base_name, seq_cutoff=identity_cutoff, timestamp=timestamp)
    print("\nPipeline execution complete.")

    if is_visual:
        build_visual_session(targets, identity_cutoff, pymol_commands, ref_pdb, prop_resi, base_name, timestamp)

# =========================================================
# USER INTERFACE
# =========================================================
if __name__ == "__main__":
    print("\n" + "="*55)
    print("    INTEGRIN STRUCTURAL ALIGNMENT PIPELINE")
    print("="*55)
    
    print("\nChoose Execution Mode:")
    print("  [1] Headless Mode (Fast, generates Excel report only)")
    print("  [2] Visual Mode   (Fast math + Automatically opens PyMOL GUI at the end)")
    mode_choice = input("Choice [1-2]: ").strip()
    is_visual = (mode_choice == "2")

    print("\nHow would you like to input your target(s)?")
    print("  [1] UniProt IDs    (e.g., P11215; P20702)")
    print("  [2] FASTA File     (e.g., my_sequences.fasta)")
    print("  [3] Raw Sequences  (Paste directly into the terminal)")
    print("  [4] Existing CSV   (e.g., ITAM.csv - skips PDB search)")
    print("  [5] Default Batch  (Runs all 18 alpha subunits)")
    
    choice = input("\nEnter your choice [1-5]: ").strip()
    
    targets_dict = {}
    source_type = "uniprot"

    if choice == "1":
        print("\nEnter UniProt IDs separated by semicolons.")
        print("Example: P11215; P20702")
        raw_ids = input("IDs: ").strip().split(";")
        for i in raw_ids:
            if i.strip(): targets_dict[i.strip()] = i.strip()
            
    elif choice == "2":
        print("\nEnter the name of your FASTA file (must be in this folder).")
        print("Example: target_integrins.fasta")
        file_path = input("Filename: ").strip()
        if os.path.exists(file_path):
            targets_dict = parse_fasta_file(file_path)
            source_type = "sequence"
        else:
            print("File not found. Exiting.")
            sys.exit()
            
    elif choice == "3":
        print("\nEnter your sequence(s). For multiple, use the format Name:Sequence and separate with semicolons.")
        print("Example: MutantA:FNLDVD... ; MutantB:VNLDVD...")
        seq_data = input("Sequences: ").strip()
        
        for item in seq_data.split(';'):
            if ':' in item:
                seq_name, seq_chars = item.split(':', 1)
                targets_dict[seq_name.strip()] = seq_chars.strip()
            elif item.strip():
                targets_dict["Custom_Target"] = item.strip()
                
        source_type = "sequence"
        
    elif choice == "4":
        print("\nEnter the name of your CSV file (must be in the CSV_files folder).")
        print("Example: ITAM.csv")
        csv_filename = input("Filename: ").strip()
        base_name = csv_filename.replace('.csv', '')
        targets_dict[base_name] = csv_filename 
        source_type = "csv"
        
    elif choice == "5" or choice == "":
        print("\nLoading Integrin List...")
        targets_dict = {
            "ITAM": "P11215", "ITAX": "P20702", "ITAL": "P20701", "ITAD": "Q13349", "ITAE": "P38570", "ITA4": "P13612",
            "ITA9": "Q13797", "ITA7": "Q13683", "ITA6": "P23229", "ITA3": "P26006", "ITA2B": "P08514", "ITAV": "P06756",
            "ITA5": "P08648", "ITA8": "P53708", "ITA1": "P56199", "ITA2": "P17301", "ITA10": "O75578", "ITA11": "Q9UKX5"
        }
    else:
        print("Invalid choice. Exiting.")
        sys.exit()

    print("\n" + "-"*55)
    print("OPTIONAL PIPELINE PARAMETERS (Press ENTER to use defaults)")
    
    raw_cutoff = input("Sequence Identity Cutoff % (Default: 85): ").strip()
    seq_cutoff = float(raw_cutoff) / 100.0 if raw_cutoff else 0.85

    custom_ref = input("Reference PDB ID for RMSD alignments (Default: 9T3Y): ").strip().upper()
    ref_pdb_id = custom_ref if custom_ref else "9T3Y"

    custom_resi = input("Propeller Residues for Reference (Default: 1-126+322-600): ").strip()
    prop_residues = custom_resi if custom_resi else "1-126+322-600"

    raw_rmsd = input("Max Angle RMSD Threshold (Å) (Default: 4): ").strip()
    custom_max_rmsd = float(raw_rmsd) if raw_rmsd else 4

    print("\n" + "-"*55)
    print("Which PyMOL protocols would you like to execute?")
    print("  [1] Propeller Align : Strict alignment to beta-propeller.")
    print("  [2] Angle Align     : Measures thigh-calf extension angles.")
    print("  [3] Whole Align     : Standard whole-structure RMSD alignment.")
    print("  [4] Smart Align     : Sequence-based homology alignment.")
    
    print("\nEnter numbers separated by semicolons (e.g. 1;2)")
    print("Add ', redo' at the end to force recalculation of existing data (e.g. 1;2, redo)")
    print("Leave BLANK to run the default recommended protocols (1 & 2).")
    raw_func_input = input("\nFunctions: ").strip().lower()
    
    force_redo = "redo" in raw_func_input
    func_input = raw_func_input.replace("redo", "").replace(",", "").strip()
    
    func_map = {"1": "align_propeller", "2": "angle_align", "3": "align_integrin", "4": "smart_align"}
    pymol_cmds = []
    
    if not func_input:
        pymol_cmds = ["align_propeller", "angle_align"]
    else:
        choices = [c.strip() for c in func_input.split(";")]
        for c in choices:
            if c in func_map: pymol_cmds.append(func_map[c])
            
    run_pipeline(targets_dict, pymol_cmds, source_type, seq_cutoff, force_redo, ref_pdb_id, prop_residues, is_visual, custom_max_rmsd)