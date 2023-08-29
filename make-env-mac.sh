#!/bin/sh
#
# Install PyTorch on Mac
#
# Author   : Carl van Heezik
# Revision : 1.0
# Date     : 2023-08-29

# Prerequisites python3, pip3 
if ! command -v python3
then
  # Install commandline tools on Mac
  xcode-select --install
fi

# Prerequisites homebrew
if ! command -v brew
then
  echo "brew not found, install brew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  brew update
  brew upgrade 
fi

# Prerequisites anaconda for using Python environments 
if ! command -v conda
then
  echo "conda not found, install miniconda"
  brew install --cask miniconda
  conda init "$(basename "${SHELL}")"
  conda config --set auto_activate_base false
  conda update -n base -c defaults conda  
fi 

brew install ninja
brew install libsndfile
brew install libiconv

export CONDA_ALWAYS_YES="true"

# Create new conda environment
env_name=fairseq2
conda create -n $env_name python=3.9
# Activate conda environment
conda activate $env_name

# Build tools for building fairseq2
conda install -c conda-forge compilers

# SeamlessM4T requirements (see requirements.txt)
conda install -c conda-forge pre_commit
conda install -c conda-forge datasets
conda install -c pytorch torchaudio 
conda install -c conda-forge pysoundfile
conda install -c conda-forge librosa

# Install jupyter notebook 
conda install -c anaconda jupyter  
conda install -c anaconda ipykernel
conda install -c anaconda ipywidgets 

unset CONDA_ALWAYS_YES