# Build fairseq2 on Mac M2 / Intel 
Check the build scripts first.

There are two scripts.
- make-env-mac.sh 
Creates a conda environment for building fairseq2
- build-fairseq2.sh 
Run this inside the conda environment

Be patient, this takes some time. 

# Build fairseq2 on Mac
```
./make-env-mac.sh
conda activate fairseq2 
./build-fairseq2.sh 
```
# Check if fairseq2 is installed 
```
pip3 list | grep fairseq2
```
