#!/bin/bash
set -euo pipefail

url=$1

#check for tools
if [ ! -x "$(command -v nikto)" ]; then
        echo "[-] nikto required to run script"
        exit 1
    fi
if [ ! -x "$(command -v assetfinder)" ]; then
        echo "[-] assetfinder required to run script"
        exit 1
    fi
if [ ! -x "$(command -v httprobe)" ]; then
        echo "[-] httprobe required to run script"
        exit 1
    fi
if [ ! -x "$(command -v html-tool)" ]; then
        echo "[-] html-tool required to run script"
        exit 1
    fi
if [ ! -x "$(command -v subjack)" ]; then
        echo "[-] subjack required to run script"
        exit 1
fi
if [ ! -x "$(command -v waybackurls)" ]; then
        echo "[-] waybackurls required to run script"
        exit 1
    fi
if [ ! -x "$(command -v gobuster)" ]; then
        echo "[-] gobuster required to run script"
        exit 1
    fi

#mkdir directories
if [ ! -d "$url" ];then
	mkdir -p $url/recon/{assetfinder,httprobe,nikto,gobuster}
fi


echo "[+] Scanning $url web server with nikto..."
nikto -h $url | tee -a $url/recon/nikto/serverscan

echo "[+] Harvesting Subdomains with assetfinder..."
assetfinder --subs-only $url >> $url/recon/assetfinder/domains
cat $url/recon/assetfinder/domains | grep $1 >> $url/recon/assetfinder/Domains
rm $url/recon/assetfinder/domains

echo "[+] Probing for live domains with httprobe..."
cat $url/recon/assetfinder/Domains | sort -u | httprobe -s -p https:443 -c 50 | sed 's/https\?:\/\///' | tr -d ':443' |tee -a  $url/recon/httprobe/hosts

echo "[+] Details of subdomains and data about(http_code + size + url)"
cat $url/recon/assetfinder/Domains | parallel -j50 -q curl -w 'Status:%{http_code}\t  Size:%{size_download}\t %{url_effective}\n' -o /dev/null -sk | tee -a $url/recon/Domain_http_code

echo "[+] Looking at src tags,attributes using html-tool..."
find . -type f | html-tool attribs src | tee -a $url/recon/html-attribs

echo "[+] Checking for possible subdomain takeover..."
if [ ! -f "$url/recon/potential_takeovers" ];then
    touch $url/recon/potential_takeovers
fi
subjack -w $url/recon/assetfinder/Domains -t 100 -timeout 30 -ssl -c ~/go/src/github.com/haccer/subjack/fingerprints.json -v 3 -o $url/recon/potential_takeovers

echo "[+] Total word count of files"
find . -type f | wc 

echo "[+] Looking up waybackurls for $url"
echo $url | waybackurls | head | tee -a $url/recon/waybackurls

echo "[+] Directory Bruteforcing using gobuster..."
gobuster dir  -e -u $1 -w wordlists/directory-list-2.3-small.txt --wildcard | tee -a $url/recon/gobuster/dirbust