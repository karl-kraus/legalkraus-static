rm -rf ./data
wget https://github.com/karl-kraus/legalkraus-data/archive/refs/heads/main.zip
unzip main
mv ./legalkraus-data-main/data .
rm main.zip
rm -rf ./legalkraus-data-main
./shellscripts/dl_imprint.sh
./process_data.sh
