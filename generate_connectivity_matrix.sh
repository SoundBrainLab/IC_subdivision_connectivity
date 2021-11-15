#!/bin/zsh
# run connectivity analysis using DSI Studio
# STILL IN PROGRESS 2021.09.13
# not combining across ROIs; no streamlines (xfm issue?)

app_dir=/Applications/dsi_studio.app/Contents/MacOS/
data_dir=/Users/KRS228/data/maastricht_dwi/

ds_dir=${data_dir}preprocessed/dsi_studio/

conn_dir=${ds_dir}/filtered_streamlines/connectivity/
mkdir -p $conn_dir

for sub in S01 S02 S03 S05 S06 S07 S08 S09 S10 S11; do
  sub_ds_file=${ds_dir}/${sub}.src.gz.odf.gqi.1.25.fib.gz
  
  csd_dir=${data_dir}/csd_wholebrain/${sub}/recon/
  csd_trk=${csd_dir}/${sub}_csd_streamline.trk
  
  echo "csd .trk file: ${csd_trk}"
  
  ${app_dir}/dsi_studio --action=ana \
    --source=$sub_ds_file \
    --tract=$csd_trk \
    --connectivity=atlas \
    --regions=${ds_dir}regions/${sub}_brachium_IC.nii.gz,${ds_dir}regions/${sub}_commissure_IC.nii.gz,${ds_dir}regions/${sub}_LL_IC.nii.gz,${ds_dir}regions/${sub}_L_ICc.nii.gz,${ds_dir}regions/${sub}_L_ICd.nii.gz,${ds_dir}regions/${sub}_L_ICx.nii.gz,${ds_dir}regions/${sub}_R_ICc.nii.gz,${ds_dir}regions/${sub}_R_ICd.nii.gz,${ds_dir}regions/${sub}_R_ICx.nii.gz \
    --connectivity_type=pass \
    --connectivity_threshold=0 \
    --t1t2=T1w
done
