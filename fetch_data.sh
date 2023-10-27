rm -rf ./data
wget https://github.com/karl-kraus/legalkraus-archiv/archive/refs/heads/main.zip
unzip main
mv ./legalkraus-archiv-main/data .
rm main.zip
rm -rf ./legalkraus-archiv-main
./shellscripts/dl_imprint.sh
