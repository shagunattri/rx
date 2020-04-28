#!/bin/bash

url=$1


if [ ! -d "$url" ];then
	mkdir $url
fi
if [ ! -d "$url/recon" ];then
	mkdir $url/recon
fi



echo "[+] Harvesting Subdomains with assetfinder..."
assetfinder $url >> $url/recon/subs.txt
cat $url/recon/subs.txt | grep $1 >> $url/recon/final.txt
rm $url/recon/subs.txt