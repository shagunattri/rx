#!/bin/bash

url=$1

if [ ! -x "$(command -v assetfinder)" ]; then
        echo "[-] assetfinder required to run script"
        exit 1
    fi

if [ ! -x "$(command -v amass)" ]; then
        echo "[-] amass required to run script"
        exit 1
    fi
if [ ! -x "$(command -v httprobe)" ]; then
        echo "[-] httprobe required to run script"
        exit 1
    fi


if [ ! -d "$url" ];then
	mkdir $url
fi
if [ ! -d "$url/recon" ];then
	mkdir $url/recon
fi
if [ ! -d "$url/recon/scans" ];then
    mkdir $url/recon/scans
fi
if [ ! -d "$url/recon/httprobe" ];then
    mkdir $url/recon/httprobe
fi
if [ ! -d "$url/recon/potential_takeovers" ];then
    mkdir $url/recon/potential_takeovers
fi
if [ ! -f "$url/recon/httprobe/alive.txt" ];then
    touch $url/recon/httprobe/alive.txt
fi


echo "[+] Harvesting Subdomains with assetfinder..."
assetfinder $url >> $url/recon/assets.txt
cat $url/recon/assets.txt | grep $1 >> $url/recon/subdomains.txt
rm $url/recon/assets.txt
echo "[+] Subdomains of $1 are harvested with assetfinder"

echo "[+] Harvesting Subdomains with OWASP Amass..."
amass enum -d $url >> $url/recon/assets.txt
sort -u $url/recon/assets.txt >> $url/recon/subdomains.txt
rm $url/recon/assets.txt
echo "[+] Subdomains of $1 are harvested with OWASP Amass"


echo "[+] Probing for alive domains and sorting the final result "
cat $url/recon/subdomains.txt | sort -u | httprobe -s -p https:443 | sed 's/https\?:\/\///' | tr -d ':443' >> $url/recon/alivedomains.txt


echo "[+] Checking for possible subdomain takeover..."
if [ ! -f "$url/recon/potential_takeovers/potential_takeovers.txt" ];then
    touch $url/recon/potential_takeovers/potential_takeovers.txt
fi
subjack -w $url/recon/final.txt -t 100 -timeout 30 -ssl -c ~/go/src/github.com/haccer/subjack/fingerprints.json -v 3 -o $url/recon/potential_takeovers/potential_takeovers.txt


echo "[+] Scanning for open ports..."
nmap -iL $url/recon/httprobe/alive.txt -T4 -oA $url/recon/scans/scanned.txt



echo "[+] Pulling and compiling js/php/aspx/jsp/json files from wayback output..."
for line in $(cat $url/recon/wayback/wayback_output.txt);do
    ext="${line##*.}"
    if [[ "$ext" == "js" ]]; then
        echo $line >> $url/recon/wayback/extensions/js1.txt
        sort -u $url/recon/wayback/extensions/js1.txt >> $url/recon/wayback/extensions/js.txt
    fi
    if [[ "$ext" == "html" ]];then
        echo $line >> $url/recon/wayback/extensions/jsp1.txt
        sort -u $url/recon/wayback/extensions/jsp1.txt >> $url/recon/wayback/extensions/jsp.txt
    fi
    if [[ "$ext" == "json" ]];then
        echo $line >> $url/recon/wayback/extensions/json1.txt
        sort -u $url/recon/wayback/extensions/json1.txt >> $url/recon/wayback/extensions/json.txt
    fi
    if [[ "$ext" == "php" ]];then
        echo $line >> $url/recon/wayback/extensions/php1.txt
        sort -u $url/recon/wayback/extensions/php1.txt >> $url/recon/wayback/extensions/php.txt
    fi
    if [[ "$ext" == "aspx" ]];then
        echo $line >> $url/recon/wayback/extensions/aspx1.txt
        sort -u $url/recon/wayback/extensions/aspx1.txt >> $url/recon/wayback/extensions/aspx.txt
    fi
done
 
rm $url/recon/wayback/extensions/js1.txt
rm $url/recon/wayback/extensions/jsp1.txt
rm $url/recon/wayback/extensions/json1.txt
rm $url/recon/wayback/extensions/php1.txt
rm $url/recon/wayback/extensions/aspx1.txt




sleep 1

echo "[+] All the subdomains are at $url/recon/sundomains.txt"

echo " "

echo "[+] All the alive subdomains are at $url/recon/alivedomains.txt"

echo " "
echo "To look at Results: "

echo "cat $url/recon/subdomains.txt"
echo "cat $url/recon/alivesubdomains.txt"

echo " "

