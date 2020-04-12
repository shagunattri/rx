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
echo "[+] Subdomains of $1 are harvested with assetfinder"

echo " "

echo "[+] Harvesting Subdomains with OWASP Amass..."
amass enum -d $url >> $url/recon/assets.txt
sort -u $url/recon/assets.txt >> $url/recon/subdomains.txt
rm $url/recon/assets.txt
echo "[+] Subdomains of $1 are harvested with OWASP Amass"

sleep 1

echo "[+] Results are available at $url/recon/sundomains.txt"

echo " "

echo "To look at Results: "

echo "cat $url/recon/subdomains.txt"

echo " "

