#!/bin/bash
echo "downloading bootstrap"
mkdir -p scss
wget https://github.com/crissdev/bootstrap-scss/archive/refs/tags/v5.3.3.zip -O bootstrap.zip && unzip bootstrap -d scss/bootstrap && rm -rf bootstrap.zip