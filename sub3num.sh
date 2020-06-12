#!/bin/bash
set -euo pipefail

url=$1

if [ ! -x "$(command -v assetfinder)" ]; then
        echo "[-] assetfinder required to run script"
        exit 1
    fi
if [ ! -x "$(command -v meg)" ]; then
        echo "[-] meg required to run script"
        exit 1
    fi
if [ ! -x "$(command -v waybackurls)" ]; then
        echo "[-] waybackurls required to run script"
        exit 1
    fi
if [ ! -x "$(command -v httprobe)" ]; then
        echo "[-] httprobe required to run script"
        exit 1
    fi
if [ ! -x "$(command -v nmap)" ]; then
        echo "[-] nmap required to run script"
        exit 1
    fi
if [ ! -x "$(command -v gowitness)" ]; then
        echo "[-] gowitness required to run script"
        exit 1
fi
if [ ! -x "$(command -v subjack)" ]; then
        echo "[-] subjack required to run script"
        exit 1
fi
if [ ! -x "$(command -v html-tool)" ]; then
        echo "[-] html-tool required to run script"
        exit 1
    fi
if [ ! -d "$url" ];then
	mkdir -p $url/recon/{assetfinder,httprobe,nmap,gowitness,meg}
fi



echo "[+] Harvesting Subdomains with assetfinder..."
assetfinder --subs-only $url >> $url/recon/assetfinder/domains
cat $url/recon/assetfinder/domains | grep $1 >> $url/recon/assetfinder/Domains
rm $url/recon/assetfinder/domains

echo "[+] Probing for live domains with httprobe..."
cat $url/recon/assetfinder/Domains | sort -u | httprobe -s -p https:443 -c 50 | sed 's/https\?:\/\///' | tr -d ':443' |tee -a  $url/recon/httprobe/hosts

echo "[+] Details of subdomains and data about(http_code + size + url)"
cat $url/recon/assetfinder/Domains | parallel -j50 -q curl -w 'Status:%{http_code}\t  Size:%{size_download}\t %{url_effective}\n' -o /dev/null -sk | tee -a $url/recon/Domain_http_code + size + url

# echo "[+] Looking for paths using meg..."
# cd $url/recon/httprobe/hosts | meg -v -d 1000 -c 50 /

echo "[+] Types of files..."
find . -type f 

echo "[+] Looking at src tags,attributes using html-tool..."
find . -type f | html-tool attribs src | tee -a $url/recon/html-attribs

echo "[+] GREPing 200 Status from requests..."
grep -Hlnri '200' | grep -v ^index | xargs -n1 ls -la | tee -a $url/recon/grep200 # list out 200 OK status

echo "[+] Total word count of files"
find . -type f | wc # word count

echo "[+] Runnig gowitness against all compiled domains..."
gowitness file -s $url/recon/httprobe/hosts -d $url/recon/gowitness

echo "[+] Checking for possible subdomain takeover..."
if [ ! -f "$url/recon/potential_takeovers" ];then
    touch $url/recon/potential_takeovers
fi
subjack -w $url/recon/assetfinder/Domains -t 100 -timeout 30 -ssl -c ~/go/src/github.com/haccer/subjack/fingerprints.json -v 3 -o $url/recon/potential_takeovers

echo "[+] Looking up waybackurls for $1"
echo $1 | waybackurls | head | tee -a $url/recon/waybackurls

#shoutout to tomnomnom
echo "[+] Looking at GitHub repo's commit history dump"
{ find .git/objects/pack/ -name "*.idx"|while read i;do git show-index < "$i"|awk '{print $2}';done;find .git/objects/ -type f|grep -v '/pack/'|awk -F'/' '{print $(NF-1)$NF}'; }|while read o;do git cat-file -p $o;done | tee -a $url/recon/ghdump

echo "[+] Scanning for open ports..."
nmap -iL $url/recon/assetfinder/Domains -T5 -oA $url/recon/nmap/nmap-scan