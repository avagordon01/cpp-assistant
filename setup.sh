#!/usr/bin/env bash

set -euxo pipefail

#download reference documents
curl https://github.com/PeterFeicht/cppreference-doc/releases/download/v20220730/html-book-20220730.tar.xz | tar -xJ

#download privateGPT
git clone https://github.com/imartinez/privateGPT

#download python dependencies
pushd privateGPT
pip install -r requirements.txt

#download gpt4all model
mkdir -p models
pushd models
curl -O https://gpt4all.io/models/ggml-gpt4all-j-v1.3-groovy.bin
popd

#download nltk-data
sudo pacman -S nltk-data
#or
#python -m nltk.downloader all
#sudo mv nltk_data /usr/local/share/nltk_data

#setup privateGPT parameters
cp example.env .env
rm -rf source_documents
export SOURCE_DIRECTORY=../reference/en

#ingest/process documents (takes a few minutes on 8 core 2.3GHz i7-11800H)
python ingest.py
