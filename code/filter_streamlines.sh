#!/bin/zsh
# filter brainstem CSD streamlines using DSI Studio


app_dir=/Applications/dsi_studio.app/Contents/MacOS/
data_dir=/Users/KRS228/data/maastricht_dwi/

ds_dir=${data_dir}preprocessed/dsi_studio/

filt_tract_dir=${ds_dir}/filtered_streamlines/by_tract/
mkdir -p $filt_tract_dir

for sub in S01 S02 S03 S05 S06 S07 S08 S09 S10 S11; do
  sub_ds_file=${ds_dir}/${sub}.src.gz.odf.gqi.1.25.fib.gz
  
  csd_dir=${data_dir}/csd_wholebrain/${sub}/recon/
  csd_trk=${csd_dir}/${sub}_csd_streamline.trk
  
  echo "csd .trk file: ${csd_trk}"
  #for roi in L_IC R_IC L_ICc R_ICc L_ICd R_ICd L_ICx R_ICx; do
  for roi in L_IC R_IC; do
    roi_file=${ds_dir}regions/${sub}_${roi}.nii.gz
    #out_file=${ds_dir}filtered_streamlines/${sub}_${roi}_filtered.trk.gz
    out_file=${ds_dir}filtered_streamlines/${sub}_${roi}_filtered.txt
    
    echo "filtering streamlines with ${roi_file}"
    ${app_dir}/dsi_studio --action=ana \
      --source=$sub_ds_file \
      --tract=$csd_trk \
      --roi=$roi_file \
      --output=$out_file
    
#    for wm_roi in brachium_IC commissure_IC LL_IC; do
#      echo $wm_roi
#      wm_file=${ds_dir}regions/${sub}_${wm_roi}.nii.gz
#      out_file=${filt_tract_dir}/${sub}_${roi}_${wm_roi}.nii.gz
#
#      echo "white matter file = $wm_file"
#      echo "filtering ${roi} streamlines through ${wm_roi}"
#      
#      ${app_dir}/dsi_studio --action=ana \
#        --source=$sub_ds_file \
#        --tract=$csd_trk \
#        --roi=$roi_file \
#        --roi2=$wm_file \
#        --output=$out_file
#    done
  done
done
