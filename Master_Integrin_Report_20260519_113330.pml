set fetch_path, C:/Users/Tinne/OneDrive - Aarhus universitet/Uni - Obsidian/6. Bachelor's project/PDB PyMol/CIF_files
bg_color black
set dash_color, yellow
set angle_color, yellow
set dash_gap, 0.4
set dash_width, 3.0

set suspend_undo, 1

fetch 9T3Y, ref_9T3Y
remove ref_9T3Y and not state 1
select ref_9T3Y_propeller, ref_9T3Y and chain A and resi 1-126+322-600
show cartoon, ref_9T3Y
color gray30, ref_9T3Y
color forest, ref_9T3Y_propeller
disable ref_9T3Y

fetch 7USM, ref_7USM
remove ref_7USM and not state 1
show cartoon, ref_7USM
color gray30, ref_7USM
color green, ref_7USM and chain A and resi 599-751
color cyan, ref_7USM and chain A and resi 761-906
angle ref_7USM_angle, ref_7USM and chain A and resi 906 and name CA, ref_7USM and chain A and resi 751 and name CA, ref_7USM and chain A and resi 599 and name CA
disable ref_7USM
disable ref_7USM_angle


# === ITAM Prop Alignments ===
fetch 7USL, 7USL_Prop
remove 7USL_Prop and not state 1
show cartoon, 7USL_Prop
super 7USL_Prop, ref_9T3Y_propeller
color cyan, 7USL_Prop
group Grp_ITAM_Prop, 7USL_Prop
fetch 7USM, 7USM_Prop
remove 7USM_Prop and not state 1
show cartoon, 7USM_Prop
super 7USM_Prop, ref_9T3Y_propeller
color cyan, 7USM_Prop
group Grp_ITAM_Prop, 7USM_Prop
fetch 9RM9, 9RM9_Prop
remove 9RM9_Prop and not state 1
show cartoon, 9RM9_Prop
super 9RM9_Prop, ref_9T3Y_propeller
color cyan, 9RM9_Prop
group Grp_ITAM_Prop, 9RM9_Prop
fetch 9T5V, 9T5V_Prop
remove 9T5V_Prop and not state 1
show cartoon, 9T5V_Prop
super 9T5V_Prop, ref_9T3Y_propeller
color cyan, 9T5V_Prop
group Grp_ITAM_Prop, 9T5V_Prop
fetch 9T5W, 9T5W_Prop
remove 9T5W_Prop and not state 1
show cartoon, 9T5W_Prop
super 9T5W_Prop, ref_9T3Y_propeller
color cyan, 9T5W_Prop
group Grp_ITAM_Prop, 9T5W_Prop
fetch 9T5Z, 9T5Z_Prop
remove 9T5Z_Prop and not state 1
show cartoon, 9T5Z_Prop
super 9T5Z_Prop, ref_9T3Y_propeller
color cyan, 9T5Z_Prop
group Grp_ITAM_Prop, 9T5Z_Prop
fetch 7P2D, 7P2D_Prop
remove 7P2D_Prop and not state 1
show cartoon, 7P2D_Prop
super 7P2D_Prop, ref_9T3Y_propeller
color cyan, 7P2D_Prop
group Grp_ITAM_Prop, 7P2D_Prop
disable Grp_ITAM_Prop

# === ITAM Angle Alignments ===
fetch 7USL, 7USL_Angle
remove 7USL_Angle and not state 1
show cartoon, 7USL_Angle
create 7USL_Angle_thigh, ref_7USM and chain A
create 7USL_Angle_calf, ref_7USM and chain A
show cartoon, 7USL_Angle_thigh
show cartoon, 7USL_Angle_calf
align 7USL_Angle_thigh and resi 599-751, 7USL_Angle
align 7USL_Angle_calf and resi 761-906, 7USL_Angle
angle 7USL_Angle_angle, 7USL_Angle_calf and resi 906 and name CA, 7USL_Angle_thigh and resi 751 and name CA, 7USL_Angle_thigh and resi 599 and name CA
remove 7USL_Angle_thigh and not resi 599-751
remove 7USL_Angle_calf and not resi 761-906
color gray70, 7USL_Angle
color palegreen, 7USL_Angle_thigh
color aquamarine, 7USL_Angle_calf
group Sub_7USL_Angle, 7USL_Angle 7USL_Angle_thigh 7USL_Angle_calf 7USL_Angle_angle
group Grp_ITAM_Angle, Sub_7USL_Angle
disable Grp_ITAM_Angle

# === ITAX Prop Alignments ===
fetch 3K6S, 3K6S_Prop
remove 3K6S_Prop and not state 1
show cartoon, 3K6S_Prop
super 3K6S_Prop, ref_9T3Y_propeller
color cyan, 3K6S_Prop
group Grp_ITAX_Prop, 3K6S_Prop
fetch 3K71, 3K71_Prop
remove 3K71_Prop and not state 1
show cartoon, 3K71_Prop
super 3K71_Prop, ref_9T3Y_propeller
color cyan, 3K71_Prop
group Grp_ITAX_Prop, 3K71_Prop
fetch 3K72, 3K72_Prop
remove 3K72_Prop and not state 1
show cartoon, 3K72_Prop
super 3K72_Prop, ref_9T3Y_propeller
color cyan, 3K72_Prop
group Grp_ITAX_Prop, 3K72_Prop
fetch 5ES4, 5ES4_Prop
remove 5ES4_Prop and not state 1
show cartoon, 5ES4_Prop
super 5ES4_Prop, ref_9T3Y_propeller
color cyan, 5ES4_Prop
group Grp_ITAX_Prop, 5ES4_Prop
fetch 4NEH, 4NEH_Prop
remove 4NEH_Prop and not state 1
show cartoon, 4NEH_Prop
super 4NEH_Prop, ref_9T3Y_propeller
color cyan, 4NEH_Prop
group Grp_ITAX_Prop, 4NEH_Prop
fetch 4NEN, 4NEN_Prop
remove 4NEN_Prop and not state 1
show cartoon, 4NEN_Prop
super 4NEN_Prop, ref_9T3Y_propeller
color cyan, 4NEN_Prop
group Grp_ITAX_Prop, 4NEN_Prop
disable Grp_ITAX_Prop

# === ITAX Angle Alignments ===
fetch 3K71, 3K71_Angle
remove 3K71_Angle and not state 1
show cartoon, 3K71_Angle
create 3K71_Angle_thigh, ref_7USM and chain A
create 3K71_Angle_calf, ref_7USM and chain A
show cartoon, 3K71_Angle_thigh
show cartoon, 3K71_Angle_calf
align 3K71_Angle_thigh and resi 599-751, 3K71_Angle
align 3K71_Angle_calf and resi 761-906, 3K71_Angle
angle 3K71_Angle_angle, 3K71_Angle_calf and resi 906 and name CA, 3K71_Angle_thigh and resi 751 and name CA, 3K71_Angle_thigh and resi 599 and name CA
remove 3K71_Angle_thigh and not resi 599-751
remove 3K71_Angle_calf and not resi 761-906
color gray70, 3K71_Angle
color palegreen, 3K71_Angle_thigh
color aquamarine, 3K71_Angle_calf
group Sub_3K71_Angle, 3K71_Angle 3K71_Angle_thigh 3K71_Angle_calf 3K71_Angle_angle
group Grp_ITAX_Angle, Sub_3K71_Angle
fetch 3K72, 3K72_Angle
remove 3K72_Angle and not state 1
show cartoon, 3K72_Angle
create 3K72_Angle_thigh, ref_7USM and chain A
create 3K72_Angle_calf, ref_7USM and chain A
show cartoon, 3K72_Angle_thigh
show cartoon, 3K72_Angle_calf
align 3K72_Angle_thigh and resi 599-751, 3K72_Angle
align 3K72_Angle_calf and resi 761-906, 3K72_Angle
angle 3K72_Angle_angle, 3K72_Angle_calf and resi 906 and name CA, 3K72_Angle_thigh and resi 751 and name CA, 3K72_Angle_thigh and resi 599 and name CA
remove 3K72_Angle_thigh and not resi 599-751
remove 3K72_Angle_calf and not resi 761-906
color gray70, 3K72_Angle
color palegreen, 3K72_Angle_thigh
color aquamarine, 3K72_Angle_calf
group Sub_3K72_Angle, 3K72_Angle 3K72_Angle_thigh 3K72_Angle_calf 3K72_Angle_angle
group Grp_ITAX_Angle, Sub_3K72_Angle
fetch 5ES4, 5ES4_Angle
remove 5ES4_Angle and not state 1
show cartoon, 5ES4_Angle
create 5ES4_Angle_thigh, ref_7USM and chain A
create 5ES4_Angle_calf, ref_7USM and chain A
show cartoon, 5ES4_Angle_thigh
show cartoon, 5ES4_Angle_calf
align 5ES4_Angle_thigh and resi 599-751, 5ES4_Angle
align 5ES4_Angle_calf and resi 761-906, 5ES4_Angle
angle 5ES4_Angle_angle, 5ES4_Angle_calf and resi 906 and name CA, 5ES4_Angle_thigh and resi 751 and name CA, 5ES4_Angle_thigh and resi 599 and name CA
remove 5ES4_Angle_thigh and not resi 599-751
remove 5ES4_Angle_calf and not resi 761-906
color gray70, 5ES4_Angle
color palegreen, 5ES4_Angle_thigh
color aquamarine, 5ES4_Angle_calf
group Sub_5ES4_Angle, 5ES4_Angle 5ES4_Angle_thigh 5ES4_Angle_calf 5ES4_Angle_angle
group Grp_ITAX_Angle, Sub_5ES4_Angle
fetch 4NEH, 4NEH_Angle
remove 4NEH_Angle and not state 1
show cartoon, 4NEH_Angle
create 4NEH_Angle_thigh, ref_7USM and chain A
create 4NEH_Angle_calf, ref_7USM and chain A
show cartoon, 4NEH_Angle_thigh
show cartoon, 4NEH_Angle_calf
align 4NEH_Angle_thigh and resi 599-751, 4NEH_Angle
align 4NEH_Angle_calf and resi 761-906, 4NEH_Angle
angle 4NEH_Angle_angle, 4NEH_Angle_calf and resi 906 and name CA, 4NEH_Angle_thigh and resi 751 and name CA, 4NEH_Angle_thigh and resi 599 and name CA
remove 4NEH_Angle_thigh and not resi 599-751
remove 4NEH_Angle_calf and not resi 761-906
color gray70, 4NEH_Angle
color palegreen, 4NEH_Angle_thigh
color aquamarine, 4NEH_Angle_calf
group Sub_4NEH_Angle, 4NEH_Angle 4NEH_Angle_thigh 4NEH_Angle_calf 4NEH_Angle_angle
group Grp_ITAX_Angle, Sub_4NEH_Angle
fetch 4NEN, 4NEN_Angle
remove 4NEN_Angle and not state 1
show cartoon, 4NEN_Angle
create 4NEN_Angle_thigh, ref_7USM and chain A
create 4NEN_Angle_calf, ref_7USM and chain A
show cartoon, 4NEN_Angle_thigh
show cartoon, 4NEN_Angle_calf
align 4NEN_Angle_thigh and resi 599-751, 4NEN_Angle
align 4NEN_Angle_calf and resi 761-906, 4NEN_Angle
angle 4NEN_Angle_angle, 4NEN_Angle_calf and resi 906 and name CA, 4NEN_Angle_thigh and resi 751 and name CA, 4NEN_Angle_thigh and resi 599 and name CA
remove 4NEN_Angle_thigh and not resi 599-751
remove 4NEN_Angle_calf and not resi 761-906
color gray70, 4NEN_Angle
color palegreen, 4NEN_Angle_thigh
color aquamarine, 4NEN_Angle_calf
group Sub_4NEN_Angle, 4NEN_Angle 4NEN_Angle_thigh 4NEN_Angle_calf 4NEN_Angle_angle
group Grp_ITAX_Angle, Sub_4NEN_Angle
disable Grp_ITAX_Angle

# === ITAL Prop Alignments ===
fetch 5E6R, 5E6R_Prop
remove 5E6R_Prop and not state 1
show cartoon, 5E6R_Prop
super 5E6R_Prop, ref_9T3Y_propeller
color cyan, 5E6R_Prop
group Grp_ITAL_Prop, 5E6R_Prop
fetch 5E6S, 5E6S_Prop
remove 5E6S_Prop and not state 1
show cartoon, 5E6S_Prop
super 5E6S_Prop, ref_9T3Y_propeller
color cyan, 5E6S_Prop
group Grp_ITAL_Prop, 5E6S_Prop
fetch 5E6U, 5E6U_Prop
remove 5E6U_Prop and not state 1
show cartoon, 5E6U_Prop
super 5E6U_Prop, ref_9T3Y_propeller
color cyan, 5E6U_Prop
group Grp_ITAL_Prop, 5E6U_Prop
disable Grp_ITAL_Prop

# === ITAE Prop Alignments ===
fetch 8ZJF, 8ZJF_Prop
remove 8ZJF_Prop and not state 1
show cartoon, 8ZJF_Prop
super 8ZJF_Prop, ref_9T3Y_propeller
color cyan, 8ZJF_Prop
group Grp_ITAE_Prop, 8ZJF_Prop
fetch 9P97, 9P97_Prop
remove 9P97_Prop and not state 1
show cartoon, 9P97_Prop
super 9P97_Prop, ref_9T3Y_propeller
color cyan, 9P97_Prop
group Grp_ITAE_Prop, 9P97_Prop
fetch 9P98, 9P98_Prop
remove 9P98_Prop and not state 1
show cartoon, 9P98_Prop
super 9P98_Prop, ref_9T3Y_propeller
color cyan, 9P98_Prop
group Grp_ITAE_Prop, 9P98_Prop
fetch 9P99, 9P99_Prop
remove 9P99_Prop and not state 1
show cartoon, 9P99_Prop
super 9P99_Prop, ref_9T3Y_propeller
color cyan, 9P99_Prop
group Grp_ITAE_Prop, 9P99_Prop
disable Grp_ITAE_Prop

# === ITAE Angle Alignments ===
fetch 8ZJF, 8ZJF_Angle
remove 8ZJF_Angle and not state 1
show cartoon, 8ZJF_Angle
create 8ZJF_Angle_thigh, ref_7USM and chain A
create 8ZJF_Angle_calf, ref_7USM and chain A
show cartoon, 8ZJF_Angle_thigh
show cartoon, 8ZJF_Angle_calf
align 8ZJF_Angle_thigh and resi 599-751, 8ZJF_Angle
align 8ZJF_Angle_calf and resi 761-906, 8ZJF_Angle
angle 8ZJF_Angle_angle, 8ZJF_Angle_calf and resi 906 and name CA, 8ZJF_Angle_thigh and resi 751 and name CA, 8ZJF_Angle_thigh and resi 599 and name CA
remove 8ZJF_Angle_thigh and not resi 599-751
remove 8ZJF_Angle_calf and not resi 761-906
color gray70, 8ZJF_Angle
color palegreen, 8ZJF_Angle_thigh
color aquamarine, 8ZJF_Angle_calf
group Sub_8ZJF_Angle, 8ZJF_Angle 8ZJF_Angle_thigh 8ZJF_Angle_calf 8ZJF_Angle_angle
group Grp_ITAE_Angle, Sub_8ZJF_Angle
disable Grp_ITAE_Angle

# === ITA4 Prop Alignments ===
fetch 9P95, 9P95_Prop
remove 9P95_Prop and not state 1
show cartoon, 9P95_Prop
super 9P95_Prop, ref_9T3Y_propeller
color cyan, 9P95_Prop
group Grp_ITA4_Prop, 9P95_Prop
fetch 9P96, 9P96_Prop
remove 9P96_Prop and not state 1
show cartoon, 9P96_Prop
super 9P96_Prop, ref_9T3Y_propeller
color cyan, 9P96_Prop
group Grp_ITA4_Prop, 9P96_Prop
fetch 3V4P, 3V4P_Prop
remove 3V4P_Prop and not state 1
show cartoon, 3V4P_Prop
super 3V4P_Prop, ref_9T3Y_propeller
color cyan, 3V4P_Prop
group Grp_ITA4_Prop, 3V4P_Prop
fetch 3V4V, 3V4V_Prop
remove 3V4V_Prop and not state 1
show cartoon, 3V4V_Prop
super 3V4V_Prop, ref_9T3Y_propeller
color cyan, 3V4V_Prop
group Grp_ITA4_Prop, 3V4V_Prop
fetch 4IRZ, 4IRZ_Prop
remove 4IRZ_Prop and not state 1
show cartoon, 4IRZ_Prop
super 4IRZ_Prop, ref_9T3Y_propeller
color cyan, 4IRZ_Prop
group Grp_ITA4_Prop, 4IRZ_Prop
disable Grp_ITA4_Prop

# === ITA6 Prop Alignments ===
fetch 7CEB, 7CEB_Prop
remove 7CEB_Prop and not state 1
show cartoon, 7CEB_Prop
super 7CEB_Prop, ref_9T3Y_propeller
color cyan, 7CEB_Prop
group Grp_ITA6_Prop, 7CEB_Prop
fetch 7CEC, 7CEC_Prop
remove 7CEC_Prop and not state 1
show cartoon, 7CEC_Prop
super 7CEC_Prop, ref_9T3Y_propeller
color cyan, 7CEC_Prop
group Grp_ITA6_Prop, 7CEC_Prop
disable Grp_ITA6_Prop

# === ITA2B Prop Alignments ===
fetch 7LA4, 7LA4_Prop
remove 7LA4_Prop and not state 1
show cartoon, 7LA4_Prop
super 7LA4_Prop, ref_9T3Y_propeller
color cyan, 7LA4_Prop
group Grp_ITA2B_Prop, 7LA4_Prop
fetch 8GCD, 8GCD_Prop
remove 8GCD_Prop and not state 1
show cartoon, 8GCD_Prop
super 8GCD_Prop, ref_9T3Y_propeller
color cyan, 8GCD_Prop
group Grp_ITA2B_Prop, 8GCD_Prop
fetch 9AXL, 9AXL_Prop
remove 9AXL_Prop and not state 1
show cartoon, 9AXL_Prop
super 9AXL_Prop, ref_9T3Y_propeller
color cyan, 9AXL_Prop
group Grp_ITA2B_Prop, 9AXL_Prop
fetch 9E8A, 9E8A_Prop
remove 9E8A_Prop and not state 1
show cartoon, 9E8A_Prop
super 9E8A_Prop, ref_9T3Y_propeller
color cyan, 9E8A_Prop
group Grp_ITA2B_Prop, 9E8A_Prop
fetch 9E8C, 9E8C_Prop
remove 9E8C_Prop and not state 1
show cartoon, 9E8C_Prop
super 9E8C_Prop, ref_9T3Y_propeller
color cyan, 9E8C_Prop
group Grp_ITA2B_Prop, 9E8C_Prop
fetch 8GCE, 8GCE_Prop
remove 8GCE_Prop and not state 1
show cartoon, 8GCE_Prop
super 8GCE_Prop, ref_9T3Y_propeller
color cyan, 8GCE_Prop
group Grp_ITA2B_Prop, 8GCE_Prop
fetch 8T2U, 8T2U_Prop
remove 8T2U_Prop and not state 1
show cartoon, 8T2U_Prop
super 8T2U_Prop, ref_9T3Y_propeller
color cyan, 8T2U_Prop
group Grp_ITA2B_Prop, 8T2U_Prop
fetch 8T2V, 8T2V_Prop
remove 8T2V_Prop and not state 1
show cartoon, 8T2V_Prop
super 8T2V_Prop, ref_9T3Y_propeller
color cyan, 8T2V_Prop
group Grp_ITA2B_Prop, 8T2V_Prop
fetch 9DAO, 9DAO_Prop
remove 9DAO_Prop and not state 1
show cartoon, 9DAO_Prop
super 9DAO_Prop, ref_9T3Y_propeller
color cyan, 9DAO_Prop
group Grp_ITA2B_Prop, 9DAO_Prop
fetch 9DAX, 9DAX_Prop
remove 9DAX_Prop and not state 1
show cartoon, 9DAX_Prop
super 9DAX_Prop, ref_9T3Y_propeller
color cyan, 9DAX_Prop
group Grp_ITA2B_Prop, 9DAX_Prop
fetch 9DEQ, 9DEQ_Prop
remove 9DEQ_Prop and not state 1
show cartoon, 9DEQ_Prop
super 9DEQ_Prop, ref_9T3Y_propeller
color cyan, 9DEQ_Prop
group Grp_ITA2B_Prop, 9DEQ_Prop
fetch 9DER, 9DER_Prop
remove 9DER_Prop and not state 1
show cartoon, 9DER_Prop
super 9DER_Prop, ref_9T3Y_propeller
color cyan, 9DER_Prop
group Grp_ITA2B_Prop, 9DER_Prop
fetch 6V4P, 6V4P_Prop
remove 6V4P_Prop and not state 1
show cartoon, 6V4P_Prop
super 6V4P_Prop, ref_9T3Y_propeller
color cyan, 6V4P_Prop
group Grp_ITA2B_Prop, 6V4P_Prop
fetch 3FCS, 3FCS_Prop
remove 3FCS_Prop and not state 1
show cartoon, 3FCS_Prop
super 3FCS_Prop, ref_9T3Y_propeller
color cyan, 3FCS_Prop
group Grp_ITA2B_Prop, 3FCS_Prop
fetch 4CAK, 4CAK_Prop
remove 4CAK_Prop and not state 1
show cartoon, 4CAK_Prop
super 4CAK_Prop, ref_9T3Y_propeller
color cyan, 4CAK_Prop
group Grp_ITA2B_Prop, 4CAK_Prop
fetch 9E8B, 9E8B_Prop
remove 9E8B_Prop and not state 1
show cartoon, 9E8B_Prop
super 9E8B_Prop, ref_9T3Y_propeller
color cyan, 9E8B_Prop
group Grp_ITA2B_Prop, 9E8B_Prop
fetch 3FCU, 3FCU_Prop
remove 3FCU_Prop and not state 1
show cartoon, 3FCU_Prop
super 3FCU_Prop, ref_9T3Y_propeller
color cyan, 3FCU_Prop
group Grp_ITA2B_Prop, 3FCU_Prop
fetch 3NID, 3NID_Prop
remove 3NID_Prop and not state 1
show cartoon, 3NID_Prop
super 3NID_Prop, ref_9T3Y_propeller
color cyan, 3NID_Prop
group Grp_ITA2B_Prop, 3NID_Prop
fetch 3NIF, 3NIF_Prop
remove 3NIF_Prop and not state 1
show cartoon, 3NIF_Prop
super 3NIF_Prop, ref_9T3Y_propeller
color cyan, 3NIF_Prop
group Grp_ITA2B_Prop, 3NIF_Prop
fetch 3NIG, 3NIG_Prop
remove 3NIG_Prop and not state 1
show cartoon, 3NIG_Prop
super 3NIG_Prop, ref_9T3Y_propeller
color cyan, 3NIG_Prop
group Grp_ITA2B_Prop, 3NIG_Prop
fetch 3T3M, 3T3M_Prop
remove 3T3M_Prop and not state 1
show cartoon, 3T3M_Prop
super 3T3M_Prop, ref_9T3Y_propeller
color cyan, 3T3M_Prop
group Grp_ITA2B_Prop, 3T3M_Prop
fetch 3T3P, 3T3P_Prop
remove 3T3P_Prop and not state 1
show cartoon, 3T3P_Prop
super 3T3P_Prop, ref_9T3Y_propeller
color cyan, 3T3P_Prop
group Grp_ITA2B_Prop, 3T3P_Prop
fetch 3ZDX, 3ZDX_Prop
remove 3ZDX_Prop and not state 1
show cartoon, 3ZDX_Prop
super 3ZDX_Prop, ref_9T3Y_propeller
color cyan, 3ZDX_Prop
group Grp_ITA2B_Prop, 3ZDX_Prop
fetch 3ZDY, 3ZDY_Prop
remove 3ZDY_Prop and not state 1
show cartoon, 3ZDY_Prop
super 3ZDY_Prop, ref_9T3Y_propeller
color cyan, 3ZDY_Prop
group Grp_ITA2B_Prop, 3ZDY_Prop
fetch 3ZDZ, 3ZDZ_Prop
remove 3ZDZ_Prop and not state 1
show cartoon, 3ZDZ_Prop
super 3ZDZ_Prop, ref_9T3Y_propeller
color cyan, 3ZDZ_Prop
group Grp_ITA2B_Prop, 3ZDZ_Prop
fetch 3ZE0, 3ZE0_Prop
remove 3ZE0_Prop and not state 1
show cartoon, 3ZE0_Prop
super 3ZE0_Prop, ref_9T3Y_propeller
color cyan, 3ZE0_Prop
group Grp_ITA2B_Prop, 3ZE0_Prop
fetch 3ZE1, 3ZE1_Prop
remove 3ZE1_Prop and not state 1
show cartoon, 3ZE1_Prop
super 3ZE1_Prop, ref_9T3Y_propeller
color cyan, 3ZE1_Prop
group Grp_ITA2B_Prop, 3ZE1_Prop
fetch 3ZE2, 3ZE2_Prop
remove 3ZE2_Prop and not state 1
show cartoon, 3ZE2_Prop
super 3ZE2_Prop, ref_9T3Y_propeller
color cyan, 3ZE2_Prop
group Grp_ITA2B_Prop, 3ZE2_Prop
fetch 7L8P, 7L8P_Prop
remove 7L8P_Prop and not state 1
show cartoon, 7L8P_Prop
super 7L8P_Prop, ref_9T3Y_propeller
color cyan, 7L8P_Prop
group Grp_ITA2B_Prop, 7L8P_Prop
fetch 7TCT, 7TCT_Prop
remove 7TCT_Prop and not state 1
show cartoon, 7TCT_Prop
super 7TCT_Prop, ref_9T3Y_propeller
color cyan, 7TCT_Prop
group Grp_ITA2B_Prop, 7TCT_Prop
fetch 7TPD, 7TPD_Prop
remove 7TPD_Prop and not state 1
show cartoon, 7TPD_Prop
super 7TPD_Prop, ref_9T3Y_propeller
color cyan, 7TPD_Prop
group Grp_ITA2B_Prop, 7TPD_Prop
fetch 7UCY, 7UCY_Prop
remove 7UCY_Prop and not state 1
show cartoon, 7UCY_Prop
super 7UCY_Prop, ref_9T3Y_propeller
color cyan, 7UCY_Prop
group Grp_ITA2B_Prop, 7UCY_Prop
fetch 7UDG, 7UDG_Prop
remove 7UDG_Prop and not state 1
show cartoon, 7UDG_Prop
super 7UDG_Prop, ref_9T3Y_propeller
color cyan, 7UDG_Prop
group Grp_ITA2B_Prop, 7UDG_Prop
fetch 7UDH, 7UDH_Prop
remove 7UDH_Prop and not state 1
show cartoon, 7UDH_Prop
super 7UDH_Prop, ref_9T3Y_propeller
color cyan, 7UDH_Prop
group Grp_ITA2B_Prop, 7UDH_Prop
fetch 7UE0, 7UE0_Prop
remove 7UE0_Prop and not state 1
show cartoon, 7UE0_Prop
super 7UE0_Prop, ref_9T3Y_propeller
color cyan, 7UE0_Prop
group Grp_ITA2B_Prop, 7UE0_Prop
fetch 7UFH, 7UFH_Prop
remove 7UFH_Prop and not state 1
show cartoon, 7UFH_Prop
super 7UFH_Prop, ref_9T3Y_propeller
color cyan, 7UFH_Prop
group Grp_ITA2B_Prop, 7UFH_Prop
fetch 7UH8, 7UH8_Prop
remove 7UH8_Prop and not state 1
show cartoon, 7UH8_Prop
super 7UH8_Prop, ref_9T3Y_propeller
color cyan, 7UH8_Prop
group Grp_ITA2B_Prop, 7UH8_Prop
fetch 7UJK, 7UJK_Prop
remove 7UJK_Prop and not state 1
show cartoon, 7UJK_Prop
super 7UJK_Prop, ref_9T3Y_propeller
color cyan, 7UJK_Prop
group Grp_ITA2B_Prop, 7UJK_Prop
fetch 7UK9, 7UK9_Prop
remove 7UK9_Prop and not state 1
show cartoon, 7UK9_Prop
super 7UK9_Prop, ref_9T3Y_propeller
color cyan, 7UK9_Prop
group Grp_ITA2B_Prop, 7UK9_Prop
fetch 7UKO, 7UKO_Prop
remove 7UKO_Prop and not state 1
show cartoon, 7UKO_Prop
super 7UKO_Prop, ref_9T3Y_propeller
color cyan, 7UKO_Prop
group Grp_ITA2B_Prop, 7UKO_Prop
fetch 7UKP, 7UKP_Prop
remove 7UKP_Prop and not state 1
show cartoon, 7UKP_Prop
super 7UKP_Prop, ref_9T3Y_propeller
color cyan, 7UKP_Prop
group Grp_ITA2B_Prop, 7UKP_Prop
fetch 7UKT, 7UKT_Prop
remove 7UKT_Prop and not state 1
show cartoon, 7UKT_Prop
super 7UKT_Prop, ref_9T3Y_propeller
color cyan, 7UKT_Prop
group Grp_ITA2B_Prop, 7UKT_Prop
fetch 4Z7N, 4Z7N_Prop
remove 4Z7N_Prop and not state 1
show cartoon, 4Z7N_Prop
super 4Z7N_Prop, ref_9T3Y_propeller
color cyan, 4Z7N_Prop
group Grp_ITA2B_Prop, 4Z7N_Prop
fetch 4Z7O, 4Z7O_Prop
remove 4Z7O_Prop and not state 1
show cartoon, 4Z7O_Prop
super 4Z7O_Prop, ref_9T3Y_propeller
color cyan, 4Z7O_Prop
group Grp_ITA2B_Prop, 4Z7O_Prop
fetch 7U60, 7U60_Prop
remove 7U60_Prop and not state 1
show cartoon, 7U60_Prop
super 7U60_Prop, ref_9T3Y_propeller
color cyan, 7U60_Prop
group Grp_ITA2B_Prop, 7U60_Prop
fetch 4Z7Q, 4Z7Q_Prop
remove 4Z7Q_Prop and not state 1
show cartoon, 4Z7Q_Prop
super 4Z7Q_Prop, ref_9T3Y_propeller
color cyan, 4Z7Q_Prop
group Grp_ITA2B_Prop, 4Z7Q_Prop
fetch 5HDB, 5HDB_Prop
remove 5HDB_Prop and not state 1
show cartoon, 5HDB_Prop
super 5HDB_Prop, ref_9T3Y_propeller
color cyan, 5HDB_Prop
group Grp_ITA2B_Prop, 5HDB_Prop
fetch 7THO, 7THO_Prop
remove 7THO_Prop and not state 1
show cartoon, 7THO_Prop
super 7THO_Prop, ref_9T3Y_propeller
color cyan, 7THO_Prop
group Grp_ITA2B_Prop, 7THO_Prop
fetch 7TMZ, 7TMZ_Prop
remove 7TMZ_Prop and not state 1
show cartoon, 7TMZ_Prop
super 7TMZ_Prop, ref_9T3Y_propeller
color cyan, 7TMZ_Prop
group Grp_ITA2B_Prop, 7TMZ_Prop
fetch 7U9F, 7U9F_Prop
remove 7U9F_Prop and not state 1
show cartoon, 7U9F_Prop
super 7U9F_Prop, ref_9T3Y_propeller
color cyan, 7U9F_Prop
group Grp_ITA2B_Prop, 7U9F_Prop
fetch 7U9V, 7U9V_Prop
remove 7U9V_Prop and not state 1
show cartoon, 7U9V_Prop
super 7U9V_Prop, ref_9T3Y_propeller
color cyan, 7U9V_Prop
group Grp_ITA2B_Prop, 7U9V_Prop
fetch 7UBR, 7UBR_Prop
remove 7UBR_Prop and not state 1
show cartoon, 7UBR_Prop
super 7UBR_Prop, ref_9T3Y_propeller
color cyan, 7UBR_Prop
group Grp_ITA2B_Prop, 7UBR_Prop
fetch 7UJE, 7UJE_Prop
remove 7UJE_Prop and not state 1
show cartoon, 7UJE_Prop
super 7UJE_Prop, ref_9T3Y_propeller
color cyan, 7UJE_Prop
group Grp_ITA2B_Prop, 7UJE_Prop
fetch 7TD8, 7TD8_Prop
remove 7TD8_Prop and not state 1
show cartoon, 7TD8_Prop
super 7TD8_Prop, ref_9T3Y_propeller
color cyan, 7TD8_Prop
group Grp_ITA2B_Prop, 7TD8_Prop
fetch 2VC2, 2VC2_Prop
remove 2VC2_Prop and not state 1
show cartoon, 2VC2_Prop
super 2VC2_Prop, ref_9T3Y_propeller
color cyan, 2VC2_Prop
group Grp_ITA2B_Prop, 2VC2_Prop
fetch 2VDK, 2VDK_Prop
remove 2VDK_Prop and not state 1
show cartoon, 2VDK_Prop
super 2VDK_Prop, ref_9T3Y_propeller
color cyan, 2VDK_Prop
group Grp_ITA2B_Prop, 2VDK_Prop
fetch 2VDL, 2VDL_Prop
remove 2VDL_Prop and not state 1
show cartoon, 2VDL_Prop
super 2VDL_Prop, ref_9T3Y_propeller
color cyan, 2VDL_Prop
group Grp_ITA2B_Prop, 2VDL_Prop
fetch 2VDM, 2VDM_Prop
remove 2VDM_Prop and not state 1
show cartoon, 2VDM_Prop
super 2VDM_Prop, ref_9T3Y_propeller
color cyan, 2VDM_Prop
group Grp_ITA2B_Prop, 2VDM_Prop
fetch 2VDN, 2VDN_Prop
remove 2VDN_Prop and not state 1
show cartoon, 2VDN_Prop
super 2VDN_Prop, ref_9T3Y_propeller
color cyan, 2VDN_Prop
group Grp_ITA2B_Prop, 2VDN_Prop
fetch 2VDO, 2VDO_Prop
remove 2VDO_Prop and not state 1
show cartoon, 2VDO_Prop
super 2VDO_Prop, ref_9T3Y_propeller
color cyan, 2VDO_Prop
group Grp_ITA2B_Prop, 2VDO_Prop
fetch 2VDP, 2VDP_Prop
remove 2VDP_Prop and not state 1
show cartoon, 2VDP_Prop
super 2VDP_Prop, ref_9T3Y_propeller
color cyan, 2VDP_Prop
group Grp_ITA2B_Prop, 2VDP_Prop
fetch 2VDQ, 2VDQ_Prop
remove 2VDQ_Prop and not state 1
show cartoon, 2VDQ_Prop
super 2VDQ_Prop, ref_9T3Y_propeller
color cyan, 2VDQ_Prop
group Grp_ITA2B_Prop, 2VDQ_Prop
fetch 2VDR, 2VDR_Prop
remove 2VDR_Prop and not state 1
show cartoon, 2VDR_Prop
super 2VDR_Prop, ref_9T3Y_propeller
color cyan, 2VDR_Prop
group Grp_ITA2B_Prop, 2VDR_Prop
fetch 1TYE, 1TYE_Prop
remove 1TYE_Prop and not state 1
show cartoon, 1TYE_Prop
super 1TYE_Prop, ref_9T3Y_propeller
color cyan, 1TYE_Prop
group Grp_ITA2B_Prop, 1TYE_Prop
disable Grp_ITA2B_Prop

# === ITAV Prop Alignments ===
fetch 8XEI, 8XEI_Prop
remove 8XEI_Prop and not state 1
show cartoon, 8XEI_Prop
super 8XEI_Prop, ref_9T3Y_propeller
color cyan, 8XEI_Prop
group Grp_ITAV_Prop, 8XEI_Prop
fetch 8XEK, 8XEK_Prop
remove 8XEK_Prop and not state 1
show cartoon, 8XEK_Prop
super 8XEK_Prop, ref_9T3Y_propeller
color cyan, 8XEK_Prop
group Grp_ITAV_Prop, 8XEK_Prop
fetch 8XEL, 8XEL_Prop
remove 8XEL_Prop and not state 1
show cartoon, 8XEL_Prop
super 8XEL_Prop, ref_9T3Y_propeller
color cyan, 8XEL_Prop
group Grp_ITAV_Prop, 8XEL_Prop
fetch 8XEN, 8XEN_Prop
remove 8XEN_Prop and not state 1
show cartoon, 8XEN_Prop
super 8XEN_Prop, ref_9T3Y_propeller
color cyan, 8XEN_Prop
group Grp_ITAV_Prop, 8XEN_Prop
fetch 8XER, 8XER_Prop
remove 8XER_Prop and not state 1
show cartoon, 8XER_Prop
super 8XER_Prop, ref_9T3Y_propeller
color cyan, 8XER_Prop
group Grp_ITAV_Prop, 8XER_Prop
fetch 8XEZ, 8XEZ_Prop
remove 8XEZ_Prop and not state 1
show cartoon, 8XEZ_Prop
super 8XEZ_Prop, ref_9T3Y_propeller
color cyan, 8XEZ_Prop
group Grp_ITAV_Prop, 8XEZ_Prop
fetch 8XF6, 8XF6_Prop
remove 8XF6_Prop and not state 1
show cartoon, 8XF6_Prop
super 8XF6_Prop, ref_9T3Y_propeller
color cyan, 8XF6_Prop
group Grp_ITAV_Prop, 8XF6_Prop
fetch 8XFG, 8XFG_Prop
remove 8XFG_Prop and not state 1
show cartoon, 8XFG_Prop
super 8XFG_Prop, ref_9T3Y_propeller
color cyan, 8XFG_Prop
group Grp_ITAV_Prop, 8XFG_Prop
fetch 8XFO, 8XFO_Prop
remove 8XFO_Prop and not state 1
show cartoon, 8XFO_Prop
super 8XFO_Prop, ref_9T3Y_propeller
color cyan, 8XFO_Prop
group Grp_ITAV_Prop, 8XFO_Prop
fetch 8ZDF, 8ZDF_Prop
remove 8ZDF_Prop and not state 1
show cartoon, 8ZDF_Prop
super 8ZDF_Prop, ref_9T3Y_propeller
color cyan, 8ZDF_Prop
group Grp_ITAV_Prop, 8ZDF_Prop
fetch 8ZDG, 8ZDG_Prop
remove 8ZDG_Prop and not state 1
show cartoon, 8ZDG_Prop
super 8ZDG_Prop, ref_9T3Y_propeller
color cyan, 8ZDG_Prop
group Grp_ITAV_Prop, 8ZDG_Prop
fetch 6UJA, 6UJA_Prop
remove 6UJA_Prop and not state 1
show cartoon, 6UJA_Prop
super 6UJA_Prop, ref_9T3Y_propeller
color cyan, 6UJA_Prop
group Grp_ITAV_Prop, 6UJA_Prop
fetch 6UJB, 6UJB_Prop
remove 6UJB_Prop and not state 1
show cartoon, 6UJB_Prop
super 6UJB_Prop, ref_9T3Y_propeller
color cyan, 6UJB_Prop
group Grp_ITAV_Prop, 6UJB_Prop
fetch 6UJC, 6UJC_Prop
remove 6UJC_Prop and not state 1
show cartoon, 6UJC_Prop
super 6UJC_Prop, ref_9T3Y_propeller
color cyan, 6UJC_Prop
group Grp_ITAV_Prop, 6UJC_Prop
fetch 3IJE, 3IJE_Prop
remove 3IJE_Prop and not state 1
show cartoon, 3IJE_Prop
super 3IJE_Prop, ref_9T3Y_propeller
color cyan, 3IJE_Prop
group Grp_ITAV_Prop, 3IJE_Prop
fetch 6MSL, 6MSL_Prop
remove 6MSL_Prop and not state 1
show cartoon, 6MSL_Prop
super 6MSL_Prop, ref_9T3Y_propeller
color cyan, 6MSL_Prop
group Grp_ITAV_Prop, 6MSL_Prop
fetch 6MSU, 6MSU_Prop
remove 6MSU_Prop and not state 1
show cartoon, 6MSU_Prop
super 6MSU_Prop, ref_9T3Y_propeller
color cyan, 6MSU_Prop
group Grp_ITAV_Prop, 6MSU_Prop
fetch 6DJP, 6DJP_Prop
remove 6DJP_Prop and not state 1
show cartoon, 6DJP_Prop
super 6DJP_Prop, ref_9T3Y_propeller
color cyan, 6DJP_Prop
group Grp_ITAV_Prop, 6DJP_Prop
fetch 4O02, 4O02_Prop
remove 4O02_Prop and not state 1
show cartoon, 4O02_Prop
super 4O02_Prop, ref_9T3Y_propeller
color cyan, 4O02_Prop
group Grp_ITAV_Prop, 4O02_Prop
fetch 8VS6, 8VS6_Prop
remove 8VS6_Prop and not state 1
show cartoon, 8VS6_Prop
super 8VS6_Prop, ref_9T3Y_propeller
color cyan, 8VS6_Prop
group Grp_ITAV_Prop, 8VS6_Prop
fetch 4G1E, 4G1E_Prop
remove 4G1E_Prop and not state 1
show cartoon, 4G1E_Prop
super 4G1E_Prop, ref_9T3Y_propeller
color cyan, 4G1E_Prop
group Grp_ITAV_Prop, 4G1E_Prop
fetch 4G1M, 4G1M_Prop
remove 4G1M_Prop and not state 1
show cartoon, 4G1M_Prop
super 4G1M_Prop, ref_9T3Y_propeller
color cyan, 4G1M_Prop
group Grp_ITAV_Prop, 4G1M_Prop
fetch 4MMX, 4MMX_Prop
remove 4MMX_Prop and not state 1
show cartoon, 4MMX_Prop
super 4MMX_Prop, ref_9T3Y_propeller
color cyan, 4MMX_Prop
group Grp_ITAV_Prop, 4MMX_Prop
fetch 4MMY, 4MMY_Prop
remove 4MMY_Prop and not state 1
show cartoon, 4MMY_Prop
super 4MMY_Prop, ref_9T3Y_propeller
color cyan, 4MMY_Prop
group Grp_ITAV_Prop, 4MMY_Prop
fetch 4MMZ, 4MMZ_Prop
remove 4MMZ_Prop and not state 1
show cartoon, 4MMZ_Prop
super 4MMZ_Prop, ref_9T3Y_propeller
color cyan, 4MMZ_Prop
group Grp_ITAV_Prop, 4MMZ_Prop
fetch 9IUJ, 9IUJ_Prop
remove 9IUJ_Prop and not state 1
show cartoon, 9IUJ_Prop
super 9IUJ_Prop, ref_9T3Y_propeller
color cyan, 9IUJ_Prop
group Grp_ITAV_Prop, 9IUJ_Prop
fetch 9JEI, 9JEI_Prop
remove 9JEI_Prop and not state 1
show cartoon, 9JEI_Prop
super 9JEI_Prop, ref_9T3Y_propeller
color cyan, 9JEI_Prop
group Grp_ITAV_Prop, 9JEI_Prop
fetch 9LT3, 9LT3_Prop
remove 9LT3_Prop and not state 1
show cartoon, 9LT3_Prop
super 9LT3_Prop, ref_9T3Y_propeller
color cyan, 9LT3_Prop
group Grp_ITAV_Prop, 9LT3_Prop
fetch 1JV2, 1JV2_Prop
remove 1JV2_Prop and not state 1
show cartoon, 1JV2_Prop
super 1JV2_Prop, ref_9T3Y_propeller
color cyan, 1JV2_Prop
group Grp_ITAV_Prop, 1JV2_Prop
fetch 1L5G, 1L5G_Prop
remove 1L5G_Prop and not state 1
show cartoon, 1L5G_Prop
super 1L5G_Prop, ref_9T3Y_propeller
color cyan, 1L5G_Prop
group Grp_ITAV_Prop, 1L5G_Prop
fetch 1M1X, 1M1X_Prop
remove 1M1X_Prop and not state 1
show cartoon, 1M1X_Prop
super 1M1X_Prop, ref_9T3Y_propeller
color cyan, 1M1X_Prop
group Grp_ITAV_Prop, 1M1X_Prop
fetch 1U8C, 1U8C_Prop
remove 1U8C_Prop and not state 1
show cartoon, 1U8C_Prop
super 1U8C_Prop, ref_9T3Y_propeller
color cyan, 1U8C_Prop
group Grp_ITAV_Prop, 1U8C_Prop
fetch 6AVQ, 6AVQ_Prop
remove 6AVQ_Prop and not state 1
show cartoon, 6AVQ_Prop
super 6AVQ_Prop, ref_9T3Y_propeller
color cyan, 6AVQ_Prop
group Grp_ITAV_Prop, 6AVQ_Prop
fetch 6AVR, 6AVR_Prop
remove 6AVR_Prop and not state 1
show cartoon, 6AVR_Prop
super 6AVR_Prop, ref_9T3Y_propeller
color cyan, 6AVR_Prop
group Grp_ITAV_Prop, 6AVR_Prop
fetch 6AVU, 6AVU_Prop
remove 6AVU_Prop and not state 1
show cartoon, 6AVU_Prop
super 6AVU_Prop, ref_9T3Y_propeller
color cyan, 6AVU_Prop
group Grp_ITAV_Prop, 6AVU_Prop
fetch 6MK0, 6MK0_Prop
remove 6MK0_Prop and not state 1
show cartoon, 6MK0_Prop
super 6MK0_Prop, ref_9T3Y_propeller
color cyan, 6MK0_Prop
group Grp_ITAV_Prop, 6MK0_Prop
fetch 6NAJ, 6NAJ_Prop
remove 6NAJ_Prop and not state 1
show cartoon, 6NAJ_Prop
super 6NAJ_Prop, ref_9T3Y_propeller
color cyan, 6NAJ_Prop
group Grp_ITAV_Prop, 6NAJ_Prop
fetch 7Y1T, 7Y1T_Prop
remove 7Y1T_Prop and not state 1
show cartoon, 7Y1T_Prop
super 7Y1T_Prop, ref_9T3Y_propeller
color cyan, 7Y1T_Prop
group Grp_ITAV_Prop, 7Y1T_Prop
fetch 4UM8, 4UM8_Prop
remove 4UM8_Prop and not state 1
show cartoon, 4UM8_Prop
super 4UM8_Prop, ref_9T3Y_propeller
color cyan, 4UM8_Prop
group Grp_ITAV_Prop, 4UM8_Prop
fetch 4UM9, 4UM9_Prop
remove 4UM9_Prop and not state 1
show cartoon, 4UM9_Prop
super 4UM9_Prop, ref_9T3Y_propeller
color cyan, 4UM9_Prop
group Grp_ITAV_Prop, 4UM9_Prop
fetch 8W30, 8W30_Prop
remove 8W30_Prop and not state 1
show cartoon, 8W30_Prop
super 8W30_Prop, ref_9T3Y_propeller
color cyan, 8W30_Prop
group Grp_ITAV_Prop, 8W30_Prop
fetch 9CZ7, 9CZ7_Prop
remove 9CZ7_Prop and not state 1
show cartoon, 9CZ7_Prop
super 9CZ7_Prop, ref_9T3Y_propeller
color cyan, 9CZ7_Prop
group Grp_ITAV_Prop, 9CZ7_Prop
fetch 9CZA, 9CZA_Prop
remove 9CZA_Prop and not state 1
show cartoon, 9CZA_Prop
super 9CZA_Prop, ref_9T3Y_propeller
color cyan, 9CZA_Prop
group Grp_ITAV_Prop, 9CZA_Prop
fetch 9CZD, 9CZD_Prop
remove 9CZD_Prop and not state 1
show cartoon, 9CZD_Prop
super 9CZD_Prop, ref_9T3Y_propeller
color cyan, 9CZD_Prop
group Grp_ITAV_Prop, 9CZD_Prop
fetch 9CZF, 9CZF_Prop
remove 9CZF_Prop and not state 1
show cartoon, 9CZF_Prop
super 9CZF_Prop, ref_9T3Y_propeller
color cyan, 9CZF_Prop
group Grp_ITAV_Prop, 9CZF_Prop
fetch 8IJ5, 8IJ5_Prop
remove 8IJ5_Prop and not state 1
show cartoon, 8IJ5_Prop
super 8IJ5_Prop, ref_9T3Y_propeller
color cyan, 8IJ5_Prop
group Grp_ITAV_Prop, 8IJ5_Prop
fetch 8VSD, 8VSD_Prop
remove 8VSD_Prop and not state 1
show cartoon, 8VSD_Prop
super 8VSD_Prop, ref_9T3Y_propeller
color cyan, 8VSD_Prop
group Grp_ITAV_Prop, 8VSD_Prop
fetch 5FFG, 5FFG_Prop
remove 5FFG_Prop and not state 1
show cartoon, 5FFG_Prop
super 5FFG_Prop, ref_9T3Y_propeller
color cyan, 5FFG_Prop
group Grp_ITAV_Prop, 5FFG_Prop
fetch 5FFO, 5FFO_Prop
remove 5FFO_Prop and not state 1
show cartoon, 5FFO_Prop
super 5FFO_Prop, ref_9T3Y_propeller
color cyan, 5FFO_Prop
group Grp_ITAV_Prop, 5FFO_Prop
fetch 5NER, 5NER_Prop
remove 5NER_Prop and not state 1
show cartoon, 5NER_Prop
super 5NER_Prop, ref_9T3Y_propeller
color cyan, 5NER_Prop
group Grp_ITAV_Prop, 5NER_Prop
fetch 5NET, 5NET_Prop
remove 5NET_Prop and not state 1
show cartoon, 5NET_Prop
super 5NET_Prop, ref_9T3Y_propeller
color cyan, 5NET_Prop
group Grp_ITAV_Prop, 5NET_Prop
fetch 6OM1, 6OM1_Prop
remove 6OM1_Prop and not state 1
show cartoon, 6OM1_Prop
super 6OM1_Prop, ref_9T3Y_propeller
color cyan, 6OM1_Prop
group Grp_ITAV_Prop, 6OM1_Prop
fetch 6OM2, 6OM2_Prop
remove 6OM2_Prop and not state 1
show cartoon, 6OM2_Prop
super 6OM2_Prop, ref_9T3Y_propeller
color cyan, 6OM2_Prop
group Grp_ITAV_Prop, 6OM2_Prop
fetch 9XMM, 9XMM_Prop
remove 9XMM_Prop and not state 1
show cartoon, 9XMM_Prop
super 9XMM_Prop, ref_9T3Y_propeller
color cyan, 9XMM_Prop
group Grp_ITAV_Prop, 9XMM_Prop
fetch 5NEM, 5NEM_Prop
remove 5NEM_Prop and not state 1
show cartoon, 5NEM_Prop
super 5NEM_Prop, ref_9T3Y_propeller
color cyan, 5NEM_Prop
group Grp_ITAV_Prop, 5NEM_Prop
fetch 5NEU, 5NEU_Prop
remove 5NEU_Prop and not state 1
show cartoon, 5NEU_Prop
super 5NEU_Prop, ref_9T3Y_propeller
color cyan, 5NEU_Prop
group Grp_ITAV_Prop, 5NEU_Prop
fetch 8TCF, 8TCF_Prop
remove 8TCF_Prop and not state 1
show cartoon, 8TCF_Prop
super 8TCF_Prop, ref_9T3Y_propeller
color cyan, 8TCF_Prop
group Grp_ITAV_Prop, 8TCF_Prop
fetch 9IND, 9IND_Prop
remove 9IND_Prop and not state 1
show cartoon, 9IND_Prop
super 9IND_Prop, ref_9T3Y_propeller
color cyan, 9IND_Prop
group Grp_ITAV_Prop, 9IND_Prop
fetch 8TCG, 8TCG_Prop
remove 8TCG_Prop and not state 1
show cartoon, 8TCG_Prop
super 8TCG_Prop, ref_9T3Y_propeller
color cyan, 8TCG_Prop
group Grp_ITAV_Prop, 8TCG_Prop
disable Grp_ITAV_Prop

# === ITAV Angle Alignments ===
fetch 8XEK, 8XEK_Angle
remove 8XEK_Angle and not state 1
show cartoon, 8XEK_Angle
create 8XEK_Angle_thigh, ref_7USM and chain A
create 8XEK_Angle_calf, ref_7USM and chain A
show cartoon, 8XEK_Angle_thigh
show cartoon, 8XEK_Angle_calf
align 8XEK_Angle_thigh and resi 599-751, 8XEK_Angle
align 8XEK_Angle_calf and resi 761-906, 8XEK_Angle
angle 8XEK_Angle_angle, 8XEK_Angle_calf and resi 906 and name CA, 8XEK_Angle_thigh and resi 751 and name CA, 8XEK_Angle_thigh and resi 599 and name CA
remove 8XEK_Angle_thigh and not resi 599-751
remove 8XEK_Angle_calf and not resi 761-906
color gray70, 8XEK_Angle
color palegreen, 8XEK_Angle_thigh
color aquamarine, 8XEK_Angle_calf
group Sub_8XEK_Angle, 8XEK_Angle 8XEK_Angle_thigh 8XEK_Angle_calf 8XEK_Angle_angle
group Grp_ITAV_Angle, Sub_8XEK_Angle
fetch 8XEL, 8XEL_Angle
remove 8XEL_Angle and not state 1
show cartoon, 8XEL_Angle
create 8XEL_Angle_thigh, ref_7USM and chain A
create 8XEL_Angle_calf, ref_7USM and chain A
show cartoon, 8XEL_Angle_thigh
show cartoon, 8XEL_Angle_calf
align 8XEL_Angle_thigh and resi 599-751, 8XEL_Angle
align 8XEL_Angle_calf and resi 761-906, 8XEL_Angle
angle 8XEL_Angle_angle, 8XEL_Angle_calf and resi 906 and name CA, 8XEL_Angle_thigh and resi 751 and name CA, 8XEL_Angle_thigh and resi 599 and name CA
remove 8XEL_Angle_thigh and not resi 599-751
remove 8XEL_Angle_calf and not resi 761-906
color gray70, 8XEL_Angle
color palegreen, 8XEL_Angle_thigh
color aquamarine, 8XEL_Angle_calf
group Sub_8XEL_Angle, 8XEL_Angle 8XEL_Angle_thigh 8XEL_Angle_calf 8XEL_Angle_angle
group Grp_ITAV_Angle, Sub_8XEL_Angle
fetch 6UJA, 6UJA_Angle
remove 6UJA_Angle and not state 1
show cartoon, 6UJA_Angle
create 6UJA_Angle_thigh, ref_7USM and chain A
create 6UJA_Angle_calf, ref_7USM and chain A
show cartoon, 6UJA_Angle_thigh
show cartoon, 6UJA_Angle_calf
align 6UJA_Angle_thigh and resi 599-751, 6UJA_Angle
align 6UJA_Angle_calf and resi 761-906, 6UJA_Angle
angle 6UJA_Angle_angle, 6UJA_Angle_calf and resi 906 and name CA, 6UJA_Angle_thigh and resi 751 and name CA, 6UJA_Angle_thigh and resi 599 and name CA
remove 6UJA_Angle_thigh and not resi 599-751
remove 6UJA_Angle_calf and not resi 761-906
color gray70, 6UJA_Angle
color palegreen, 6UJA_Angle_thigh
color aquamarine, 6UJA_Angle_calf
group Sub_6UJA_Angle, 6UJA_Angle 6UJA_Angle_thigh 6UJA_Angle_calf 6UJA_Angle_angle
group Grp_ITAV_Angle, Sub_6UJA_Angle
fetch 6UJB, 6UJB_Angle
remove 6UJB_Angle and not state 1
show cartoon, 6UJB_Angle
create 6UJB_Angle_thigh, ref_7USM and chain A
create 6UJB_Angle_calf, ref_7USM and chain A
show cartoon, 6UJB_Angle_thigh
show cartoon, 6UJB_Angle_calf
align 6UJB_Angle_thigh and resi 599-751, 6UJB_Angle
align 6UJB_Angle_calf and resi 761-906, 6UJB_Angle
angle 6UJB_Angle_angle, 6UJB_Angle_calf and resi 906 and name CA, 6UJB_Angle_thigh and resi 751 and name CA, 6UJB_Angle_thigh and resi 599 and name CA
remove 6UJB_Angle_thigh and not resi 599-751
remove 6UJB_Angle_calf and not resi 761-906
color gray70, 6UJB_Angle
color palegreen, 6UJB_Angle_thigh
color aquamarine, 6UJB_Angle_calf
group Sub_6UJB_Angle, 6UJB_Angle 6UJB_Angle_thigh 6UJB_Angle_calf 6UJB_Angle_angle
group Grp_ITAV_Angle, Sub_6UJB_Angle
fetch 6UJC, 6UJC_Angle
remove 6UJC_Angle and not state 1
show cartoon, 6UJC_Angle
create 6UJC_Angle_thigh, ref_7USM and chain A
create 6UJC_Angle_calf, ref_7USM and chain A
show cartoon, 6UJC_Angle_thigh
show cartoon, 6UJC_Angle_calf
align 6UJC_Angle_thigh and resi 599-751, 6UJC_Angle
align 6UJC_Angle_calf and resi 761-906, 6UJC_Angle
angle 6UJC_Angle_angle, 6UJC_Angle_calf and resi 906 and name CA, 6UJC_Angle_thigh and resi 751 and name CA, 6UJC_Angle_thigh and resi 599 and name CA
remove 6UJC_Angle_thigh and not resi 599-751
remove 6UJC_Angle_calf and not resi 761-906
color gray70, 6UJC_Angle
color palegreen, 6UJC_Angle_thigh
color aquamarine, 6UJC_Angle_calf
group Sub_6UJC_Angle, 6UJC_Angle 6UJC_Angle_thigh 6UJC_Angle_calf 6UJC_Angle_angle
group Grp_ITAV_Angle, Sub_6UJC_Angle
fetch 7Y1T, 7Y1T_Angle
remove 7Y1T_Angle and not state 1
show cartoon, 7Y1T_Angle
create 7Y1T_Angle_thigh, ref_7USM and chain A
create 7Y1T_Angle_calf, ref_7USM and chain A
show cartoon, 7Y1T_Angle_thigh
show cartoon, 7Y1T_Angle_calf
align 7Y1T_Angle_thigh and resi 599-751, 7Y1T_Angle
align 7Y1T_Angle_calf and resi 761-906, 7Y1T_Angle
angle 7Y1T_Angle_angle, 7Y1T_Angle_calf and resi 906 and name CA, 7Y1T_Angle_thigh and resi 751 and name CA, 7Y1T_Angle_thigh and resi 599 and name CA
remove 7Y1T_Angle_thigh and not resi 599-751
remove 7Y1T_Angle_calf and not resi 761-906
color gray70, 7Y1T_Angle
color palegreen, 7Y1T_Angle_thigh
color aquamarine, 7Y1T_Angle_calf
group Sub_7Y1T_Angle, 7Y1T_Angle 7Y1T_Angle_thigh 7Y1T_Angle_calf 7Y1T_Angle_angle
group Grp_ITAV_Angle, Sub_7Y1T_Angle
fetch 4UM8, 4UM8_Angle
remove 4UM8_Angle and not state 1
show cartoon, 4UM8_Angle
create 4UM8_Angle_thigh, ref_7USM and chain A
create 4UM8_Angle_calf, ref_7USM and chain A
show cartoon, 4UM8_Angle_thigh
show cartoon, 4UM8_Angle_calf
align 4UM8_Angle_thigh and resi 599-751, 4UM8_Angle
align 4UM8_Angle_calf and resi 761-906, 4UM8_Angle
angle 4UM8_Angle_angle, 4UM8_Angle_calf and resi 906 and name CA, 4UM8_Angle_thigh and resi 751 and name CA, 4UM8_Angle_thigh and resi 599 and name CA
remove 4UM8_Angle_thigh and not resi 599-751
remove 4UM8_Angle_calf and not resi 761-906
color gray70, 4UM8_Angle
color palegreen, 4UM8_Angle_thigh
color aquamarine, 4UM8_Angle_calf
group Sub_4UM8_Angle, 4UM8_Angle 4UM8_Angle_thigh 4UM8_Angle_calf 4UM8_Angle_angle
group Grp_ITAV_Angle, Sub_4UM8_Angle
fetch 9CZ7, 9CZ7_Angle
remove 9CZ7_Angle and not state 1
show cartoon, 9CZ7_Angle
create 9CZ7_Angle_thigh, ref_7USM and chain A
create 9CZ7_Angle_calf, ref_7USM and chain A
show cartoon, 9CZ7_Angle_thigh
show cartoon, 9CZ7_Angle_calf
align 9CZ7_Angle_thigh and resi 599-751, 9CZ7_Angle
align 9CZ7_Angle_calf and resi 761-906, 9CZ7_Angle
angle 9CZ7_Angle_angle, 9CZ7_Angle_calf and resi 906 and name CA, 9CZ7_Angle_thigh and resi 751 and name CA, 9CZ7_Angle_thigh and resi 599 and name CA
remove 9CZ7_Angle_thigh and not resi 599-751
remove 9CZ7_Angle_calf and not resi 761-906
color gray70, 9CZ7_Angle
color palegreen, 9CZ7_Angle_thigh
color aquamarine, 9CZ7_Angle_calf
group Sub_9CZ7_Angle, 9CZ7_Angle 9CZ7_Angle_thigh 9CZ7_Angle_calf 9CZ7_Angle_angle
group Grp_ITAV_Angle, Sub_9CZ7_Angle
fetch 9CZA, 9CZA_Angle
remove 9CZA_Angle and not state 1
show cartoon, 9CZA_Angle
create 9CZA_Angle_thigh, ref_7USM and chain A
create 9CZA_Angle_calf, ref_7USM and chain A
show cartoon, 9CZA_Angle_thigh
show cartoon, 9CZA_Angle_calf
align 9CZA_Angle_thigh and resi 599-751, 9CZA_Angle
align 9CZA_Angle_calf and resi 761-906, 9CZA_Angle
angle 9CZA_Angle_angle, 9CZA_Angle_calf and resi 906 and name CA, 9CZA_Angle_thigh and resi 751 and name CA, 9CZA_Angle_thigh and resi 599 and name CA
remove 9CZA_Angle_thigh and not resi 599-751
remove 9CZA_Angle_calf and not resi 761-906
color gray70, 9CZA_Angle
color palegreen, 9CZA_Angle_thigh
color aquamarine, 9CZA_Angle_calf
group Sub_9CZA_Angle, 9CZA_Angle 9CZA_Angle_thigh 9CZA_Angle_calf 9CZA_Angle_angle
group Grp_ITAV_Angle, Sub_9CZA_Angle
fetch 9CZD, 9CZD_Angle
remove 9CZD_Angle and not state 1
show cartoon, 9CZD_Angle
create 9CZD_Angle_thigh, ref_7USM and chain A
create 9CZD_Angle_calf, ref_7USM and chain A
show cartoon, 9CZD_Angle_thigh
show cartoon, 9CZD_Angle_calf
align 9CZD_Angle_thigh and resi 599-751, 9CZD_Angle
align 9CZD_Angle_calf and resi 761-906, 9CZD_Angle
angle 9CZD_Angle_angle, 9CZD_Angle_calf and resi 906 and name CA, 9CZD_Angle_thigh and resi 751 and name CA, 9CZD_Angle_thigh and resi 599 and name CA
remove 9CZD_Angle_thigh and not resi 599-751
remove 9CZD_Angle_calf and not resi 761-906
color gray70, 9CZD_Angle
color palegreen, 9CZD_Angle_thigh
color aquamarine, 9CZD_Angle_calf
group Sub_9CZD_Angle, 9CZD_Angle 9CZD_Angle_thigh 9CZD_Angle_calf 9CZD_Angle_angle
group Grp_ITAV_Angle, Sub_9CZD_Angle
fetch 9CZF, 9CZF_Angle
remove 9CZF_Angle and not state 1
show cartoon, 9CZF_Angle
create 9CZF_Angle_thigh, ref_7USM and chain A
create 9CZF_Angle_calf, ref_7USM and chain A
show cartoon, 9CZF_Angle_thigh
show cartoon, 9CZF_Angle_calf
align 9CZF_Angle_thigh and resi 599-751, 9CZF_Angle
align 9CZF_Angle_calf and resi 761-906, 9CZF_Angle
angle 9CZF_Angle_angle, 9CZF_Angle_calf and resi 906 and name CA, 9CZF_Angle_thigh and resi 751 and name CA, 9CZF_Angle_thigh and resi 599 and name CA
remove 9CZF_Angle_thigh and not resi 599-751
remove 9CZF_Angle_calf and not resi 761-906
color gray70, 9CZF_Angle
color palegreen, 9CZF_Angle_thigh
color aquamarine, 9CZF_Angle_calf
group Sub_9CZF_Angle, 9CZF_Angle 9CZF_Angle_thigh 9CZF_Angle_calf 9CZF_Angle_angle
group Grp_ITAV_Angle, Sub_9CZF_Angle
fetch 8VSD, 8VSD_Angle
remove 8VSD_Angle and not state 1
show cartoon, 8VSD_Angle
create 8VSD_Angle_thigh, ref_7USM and chain A
create 8VSD_Angle_calf, ref_7USM and chain A
show cartoon, 8VSD_Angle_thigh
show cartoon, 8VSD_Angle_calf
align 8VSD_Angle_thigh and resi 599-751, 8VSD_Angle
align 8VSD_Angle_calf and resi 761-906, 8VSD_Angle
angle 8VSD_Angle_angle, 8VSD_Angle_calf and resi 906 and name CA, 8VSD_Angle_thigh and resi 751 and name CA, 8VSD_Angle_thigh and resi 599 and name CA
remove 8VSD_Angle_thigh and not resi 599-751
remove 8VSD_Angle_calf and not resi 761-906
color gray70, 8VSD_Angle
color palegreen, 8VSD_Angle_thigh
color aquamarine, 8VSD_Angle_calf
group Sub_8VSD_Angle, 8VSD_Angle 8VSD_Angle_thigh 8VSD_Angle_calf 8VSD_Angle_angle
group Grp_ITAV_Angle, Sub_8VSD_Angle
fetch 6OM2, 6OM2_Angle
remove 6OM2_Angle and not state 1
show cartoon, 6OM2_Angle
create 6OM2_Angle_thigh, ref_7USM and chain A
create 6OM2_Angle_calf, ref_7USM and chain A
show cartoon, 6OM2_Angle_thigh
show cartoon, 6OM2_Angle_calf
align 6OM2_Angle_thigh and resi 599-751, 6OM2_Angle
align 6OM2_Angle_calf and resi 761-906, 6OM2_Angle
angle 6OM2_Angle_angle, 6OM2_Angle_calf and resi 906 and name CA, 6OM2_Angle_thigh and resi 751 and name CA, 6OM2_Angle_thigh and resi 599 and name CA
remove 6OM2_Angle_thigh and not resi 599-751
remove 6OM2_Angle_calf and not resi 761-906
color gray70, 6OM2_Angle
color palegreen, 6OM2_Angle_thigh
color aquamarine, 6OM2_Angle_calf
group Sub_6OM2_Angle, 6OM2_Angle 6OM2_Angle_thigh 6OM2_Angle_calf 6OM2_Angle_angle
group Grp_ITAV_Angle, Sub_6OM2_Angle
disable Grp_ITAV_Angle

# === ITA5 Prop Alignments ===
fetch 7NWL, 7NWL_Prop
remove 7NWL_Prop and not state 1
show cartoon, 7NWL_Prop
super 7NWL_Prop, ref_9T3Y_propeller
color cyan, 7NWL_Prop
group Grp_ITA5_Prop, 7NWL_Prop
fetch 7NXD, 7NXD_Prop
remove 7NXD_Prop and not state 1
show cartoon, 7NXD_Prop
super 7NXD_Prop, ref_9T3Y_propeller
color cyan, 7NXD_Prop
group Grp_ITA5_Prop, 7NXD_Prop
fetch 9CKV, 9CKV_Prop
remove 9CKV_Prop and not state 1
show cartoon, 9CKV_Prop
super 9CKV_Prop, ref_9T3Y_propeller
color cyan, 9CKV_Prop
group Grp_ITA5_Prop, 9CKV_Prop
fetch 9DIA, 9DIA_Prop
remove 9DIA_Prop and not state 1
show cartoon, 9DIA_Prop
super 9DIA_Prop, ref_9T3Y_propeller
color cyan, 9DIA_Prop
group Grp_ITA5_Prop, 9DIA_Prop
fetch 9EF2, 9EF2_Prop
remove 9EF2_Prop and not state 1
show cartoon, 9EF2_Prop
super 9EF2_Prop, ref_9T3Y_propeller
color cyan, 9EF2_Prop
group Grp_ITA5_Prop, 9EF2_Prop
fetch 9B9J, 9B9J_Prop
remove 9B9J_Prop and not state 1
show cartoon, 9B9J_Prop
super 9B9J_Prop, ref_9T3Y_propeller
color cyan, 9B9J_Prop
group Grp_ITA5_Prop, 9B9J_Prop
fetch 9B9K, 9B9K_Prop
remove 9B9K_Prop and not state 1
show cartoon, 9B9K_Prop
super 9B9K_Prop, ref_9T3Y_propeller
color cyan, 9B9K_Prop
group Grp_ITA5_Prop, 9B9K_Prop
fetch 8OXZ, 8OXZ_Prop
remove 8OXZ_Prop and not state 1
show cartoon, 8OXZ_Prop
super 8OXZ_Prop, ref_9T3Y_propeller
color cyan, 8OXZ_Prop
group Grp_ITA5_Prop, 8OXZ_Prop
fetch 9NAB, 9NAB_Prop
remove 9NAB_Prop and not state 1
show cartoon, 9NAB_Prop
super 9NAB_Prop, ref_9T3Y_propeller
color cyan, 9NAB_Prop
group Grp_ITA5_Prop, 9NAB_Prop
fetch 3VI3, 3VI3_Prop
remove 3VI3_Prop and not state 1
show cartoon, 3VI3_Prop
super 3VI3_Prop, ref_9T3Y_propeller
color cyan, 3VI3_Prop
group Grp_ITA5_Prop, 3VI3_Prop
fetch 3VI4, 3VI4_Prop
remove 3VI4_Prop and not state 1
show cartoon, 3VI4_Prop
super 3VI4_Prop, ref_9T3Y_propeller
color cyan, 3VI4_Prop
group Grp_ITA5_Prop, 3VI4_Prop
fetch 9P6S, 9P6S_Prop
remove 9P6S_Prop and not state 1
show cartoon, 9P6S_Prop
super 9P6S_Prop, ref_9T3Y_propeller
color cyan, 9P6S_Prop
group Grp_ITA5_Prop, 9P6S_Prop
fetch 4WJK, 4WJK_Prop
remove 4WJK_Prop and not state 1
show cartoon, 4WJK_Prop
super 4WJK_Prop, ref_9T3Y_propeller
color cyan, 4WJK_Prop
group Grp_ITA5_Prop, 4WJK_Prop
fetch 4WK0, 4WK0_Prop
remove 4WK0_Prop and not state 1
show cartoon, 4WK0_Prop
super 4WK0_Prop, ref_9T3Y_propeller
color cyan, 4WK0_Prop
group Grp_ITA5_Prop, 4WK0_Prop
fetch 4WK2, 4WK2_Prop
remove 4WK2_Prop and not state 1
show cartoon, 4WK2_Prop
super 4WK2_Prop, ref_9T3Y_propeller
color cyan, 4WK2_Prop
group Grp_ITA5_Prop, 4WK2_Prop
fetch 4WK4, 4WK4_Prop
remove 4WK4_Prop and not state 1
show cartoon, 4WK4_Prop
super 4WK4_Prop, ref_9T3Y_propeller
color cyan, 4WK4_Prop
group Grp_ITA5_Prop, 4WK4_Prop
disable Grp_ITA5_Prop

enable ref_9T3Y
zoom ref_9T3Y
