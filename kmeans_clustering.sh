#!/bin/zsh
# run k-means clustering  using DSI Studio

app_dir=/Applications/dsi_studio.app/Contents/MacOS/
data_dir=/Users/KRS228/data/maastricht_dwi/

ds_dir=${data_dir}/preprocessed/dsi_studio/
kmeans_dir=${ds_dir}/kmeans/
mkdir -p $kmeans_dir

for sub in S01 S02 S03 S05 S06 S07 S08 S09 S10 S11; do
  sub_ds_file=${ds_dir}/${sub}.src.gz.odf.gqi.1.25.fib.gz
  
  for roi in L_IC R_IC; do
    sub_tract_trk=${ds_dir}filtered_streamlines/${sub}_${roi}_filtered.trk.gz
    
    for k in 1 2 3 4 5 6 7 8 9; do
      out_file=${kmeans_dir}/${sub}_${roi}_kmeans-${k}.txt
      
      ${app_dir}dsi_studio --action=ana \
        --source=${sub_ds_file} \
        --tract=${sub_tract_trk}  \
        --cluster=1,${k},0,${out_file}
    done
  done
done
