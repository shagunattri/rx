#!/bin/bash

url=$1


if [ ! -d "$url" ];then
	mkdir $url
fi
if [ ! -d "$url/recon" ];then
	mkdir $url/recon
fi



echo "[+] Harvesting Subdomains with assetfinder..."
assetfinder $url >> $url/recon/assetfinder.txt
cat $url/recon/assetfinder.txt | grep $1 >> $url/recon/assetfinder-final.txt
rm $url/recon/assetfinder.txt

echo "[+] Harvesting Subdomains with OWASP Amass..."
amass enum -d $url >> $url/recon/amass.txt
sort -u $url/recon/amass.txt >> $url/recon/amass-final.txt
rm $url/recon/amass.txt


echo "[+] Probing for alive domains and sorting the final result..."
cat $url/recon/assetfinder-final.txt | sort -u | httprobe -s -p https:443 | sed 's/https\?:\/\///' | tr -d ':443' >> $url/recon/httprobe-alivedomains.txt
cat $url/recon/amass-final.txt | sort -u | httprobe -s -p https:443 | sed 's/https\?:\/\///' | tr -d ':443' >> $url/recon/httprobe-alivedomains.txt
