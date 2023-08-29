#!/bin/sh
#
# Build fairseq2 on mac
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

pip3 install --upgrade pip 

# Prerequisites homebrew
if ! command -v brew
then
  echo "brew not found, install brew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  brew update
  brew upgrade 
fi

brew install ninja
brew install libsndfile
brew install libiconv

if [ -d "fairseq2" ]; then
  echo "fairseq2 exists OK"
else 
  echo "Get fairseq2 from github"
  git clone --recurse-submodules https://github.com/facebookresearch/fairseq2.git
fi

export CONDA_BUILD_SYSROOT=$(xcrun --show-sdk-path)
pip3 install torch -r fairseq2/fairseq2n/python/requirements-build.txt
cd fairseq2/fairseq2n
cmake -GNinja -B build
cmake --build build
cd python
export FAIRSEQ2N_DEVEL=1 
pip3 install -e .
cd ../..
pip3 install -e .
