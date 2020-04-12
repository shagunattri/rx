#!/bin/bash

url=$1



if [ ! -d "$url" ];then
	mkdir $url
fi

if [ ! -d "$url/recon" ];then
	mkdir $url/recon
fi



echo "[+] Harvesting Subdomains with assetfinder..."

assetfinder $url >> $url/recon/assets.txt

cat $url/recon/assets.txt | grep $1 >> $url/recon/subdomains.txt

rm $url/recon/assets.txt

echo "[+] Subdomains of $1 are harvested "

sleep 3

echo "[+] Results are available at $url/recon/sundomains.txt"

echo " "

echo "To look at Results: "

echo "cat $url/recon/subdomains.txt"




