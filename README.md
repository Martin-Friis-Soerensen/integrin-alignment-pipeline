# Integrin Structural Alignment Pipeline

## Overview
This repository contains an automated computational pipeline for the conformational analysis and structural alignment of integrin alpha subunits. The script queries sequences via the UniProt API, retrieves structural homologs from the RCSB PDB, and executes native PyMOL geometric alignments. 

The pipeline generates comprehensive structural alignment metrics exported as Excel reports and dynamically writes PyMOL visualization scripts (`.pml`) for immediate structural review.

This project was developed for a bachelor's report in Molecular Biology at Aarhus University.

## Dependencies and Prerequisites
Execution requires a local installation of Python (3.x) and PyMOL. 

1. Ensure your Python environment has access to the PyMOL executable (e.g., via a conda environment).
2. Install the required Python libraries. A `requirements.txt` file is provided.

```bash
pip install -r requirements.txt
```

**Required Libraries:**
- `requests`
- `pandas`
- `openpyxl`
- `biopython`    

## Installation
**Option 1: Using Git (Recommended)**

Clone the repository to your local machine using the terminal:
```Bash
git clone https://github.com/Martin-Friis-Soerensen/integrin-alignment-pipeline.git
cd integrin-alignment-pipeline
```

**Option 2: Direct Download**

If you do not have Git installed:
1. Click the green Code button at the top right of this repository page.
2. Select Download ZIP.
3. Extract the downloaded ZIP file to your preferred directory.
4. Open a terminal or command prompt and navigate into the extracted folder using the cd command.

## Usage
Execute the script from the terminal:
```Bash
python alignment_pipeline.py
```
The script features an interactive command-line interface.

### Execution Modes
- **[1] Headless Mode:** Executes sequence fetching and alignment algorithms in the background, generating only the Excel data report.
- **[2] Visual Mode:** Executes the mathematical alignments and subsequently generates and launches a targeted PyMOL `.pml` script to visualize the superimposed structures.

### Input Parameters
The pipeline accepts multiple input formats:
- **UniProt IDs:** Fetch reference sequences directly (e.g., `P11215`).
- **FASTA File:** Process a batch of locally stored sequences.
- **Raw Sequences:** Direct terminal input.
- **Existing CSV:** Bypass the RCSB API search and run structural alignments on a pre-defined list of PDB IDs.
- **Default Batch:** Automatically processes a pre-defined list of 18 integrin alpha subunits.

### Alignment Protocols
Users can select specific alignment methodologies:
1. **Propeller Align:** Strict structural alignment to the integrin beta-propeller domain.
2. **Angle Align:** Calculates the thigh-calf extension angles to assess conformational states.
3. **Whole Align:** Standard whole-structure RMSD superposition.
4. **Smart Align:** A hybrid sequence-based and geometry-based homology alignment algorithm.

## Output
The pipeline automatically generates required subdirectories within the working directory.
- `/CSV_files`: Stores structural metadata (PubMed IDs, EMDB Maps, Release Dates) retrieved from the RCSB GraphQL API.
- `/CIF_files`: Caches coordinate files downloaded by PyMOL.
- `/Alignment_Results`: Stores raw RMSD and atom-count metrics in JSON format.
- `/Excel_Reports`: Consolidates the JSON data into a structured `.xlsx` report.
- `/PyMOL_Scripts`: Stores the generated `.pml` sessions.

<img width="1909" height="873" alt="PyMOL_output_prop" src="https://github.com/user-attachments/assets/65756345-981f-4fee-b5ca-76b8a41c4678" />
<img width="1914" height="878" alt="PyMOL_output_angle" src="https://github.com/user-attachments/assets/6b51ba9a-43ce-4c15-bc9c-c20a39a382f5" />


## Future Development
The current iteration of this pipeline is optimized specifically for integrin structural analysis utilizing predefined reference coordinates (e.g., PDB 9T3Y, 7USM). Future updates will generalize the alignment algorithm to accept any standard user-defined input sequence and automate the corresponding PyMOL structural overlays across varied protein families.

## License
This project is licensed under the GNU General Public License v3.0 (GPLv3). See the `LICENSE` file for details.

**Author:** Martin Friis Sørensen

**Institution:** Department of Molecular Biology and Genetics, Aarhus University
