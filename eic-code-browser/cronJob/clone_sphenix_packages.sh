#!/bin/sh
code_top_area=/home/lxrsource/sphenix/source/master
[[ ! -d ${code_top_area} ]] && echo "Error: directory for code installation does not exist" && exit 1
cd ${code_top_area}
array=('acts' 'acts-fatras' 'analysis' 'analysis_tpc_prototype' 'coresoftware' 'g4exampledetector' 'GenFit' 'JETSCAPE' 'KFParticle' 'online_distribution' 'OnlMon' 'prototype' 'pythia6' 'rcdaq' 'RDBC' 'tutorials' 'macros')
for i in "${array[@]}"
do
    echo "running git clone https://github.com/sPHENIX-Collaboration/${i}.git" 
    git clone https://github.com/sPHENIX-Collaboration/${i}.git
done


