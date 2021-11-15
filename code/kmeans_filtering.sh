#!/bin/zsh
# filter streamlines for each k-means cluster
# according to anatomically defined IC subdivisions
# KRS 2021.09.22

app_dir=/Applications/dsi_studio.app/Contents/MacOS/
data_dir=/Users/KRS228/data/maastricht_dwi/
ds_dir=${data_dir}preprocessed/dsi_studio/

for sub in S01 S02 S03 S05 S06 S07 S08 S09 S10 S11; do
  sub_ds_file=${ds_dir}/${sub}.src.gz.odf.gqi.1.25.fib.gz
  for roi in L_IC R_IC; do
    for kx in 2 3 4 5; do
      kmeans_dir=${ds_dir}/kmeans/${sub}_${roi}_kmeans-${kx}
      
      for cluster_file in $(ls $kmeans_dir/*.trk.gz); do
        cluster_basename=$(basename $cluster_file .trk.gz)
        echo $cluster_basename

        for subdiv in c d x; do
          roi_file=${ds_dir}regions/${sub}_${roi}${subdiv}.nii.gz

          out_dir=${kmeans_dir}/${roi}${subdiv}/
          mkdir -p $out_dir

          output_file=${out_dir}/${sub}_${roi}${subdiv}_kmeans-${kx}_${cluster_basename}.txt

          ${app_dir}/dsi_studio --action=ana \
            --source=$sub_ds_file \
            --tract=$cluster_file \
            --roi=$roi_file \
            --output=$output_file
        done
      done
    done
  done
done
