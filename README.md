## 🌐sub3num


```                                                                                 
                                     .--,-``-.                                              
                                    /   /     '.                                     ____   
                           ,---,   / ../        ;                                  ,'  , `. 
                     ,--,,---.'|   \ ``\  .`-    '      ,---,          ,--,     ,-+-,.' _ | 
  .--.--.          ,'_ /||   | :    \___\/   \   :  ,-+-. /  |       ,'_ /|  ,-+-. ;   , || 
 /  /    '    .--. |  | ::   : :         \   :   | ,--.'|'   |  .--. |  | : ,--.'|'   |  || 
|  :  /`./  ,'_ /| :  . |:     |,-.      /  /   / |   |  ,"' |,'_ /| :  . ||   |  ,', |  |, 
|  :  ;_    |  ' | |  . .|   : '  |      \  \   \ |   | /  | ||  ' | |  . .|   | /  | |--'  
 \  \    `. |  | ' |  | ||   |  / :  ___ /   :   ||   | |  | ||  | ' |  | ||   : |  | ,     
  `----.   \:  | : ;  ; |'   : |: | /   /\   /   :|   | |  |/ :  | : ;  ; ||   : |  |/      
 /  /`--'  /'  :  `--'   \   | '/ :/ ,,/  ',-    .|   | |--'  '  :  `--'   \   | |`-'       
'--'.     / :  ,      .-./   :    |\ ''\        ; |   |/      :  ,      .-./   ;/           
  `--'---'   `--`----'   /    \  /  \   \     .'  '---'        `--`----'   '---'            
                         `-'----'    `--`-,,-'                                           
```


Automate your Web Enumeration and save time with sub3num.

Enumeration and automation shellscript to find subdomains and other extra features.

Integrates tools written in Go to automate the process of web application enumeration.


## Features
- Subdomain Enumeration
- Find alive Subdomdomains
- Look for possible Domain takeover 
- Screenshots of domain.
- Nmap Scan for Open Ports



### Prerequisites

- [Go](https://golang.org/) 
- Any *nix system



### Installation
```
$ git clone https://github.com/shagunattri/sub3num.git

$ cd sub3num/

$ ./sub3num <domain>
```

### Usage

```
 ./sub3num <domain>
```


### Screenshots


![sub3num](https://user-images.githubusercontent.com/29366864/80619137-e19f5d80-8a61-11ea-90b3-6f9483b4a326.png)



### Tools utilised

- [Assetfinder](https://github.com/tomnomnom/assetfinder)
- [OWASP Amass](https://github.com/OWASP/Amass)
- [httprobe](https://github.com/tomnomnom/httprobe)
- [Gowitness](https://github.com/sensepost/gowitness)
- [subjack](https://github.com/haccer/subjack)
- [nmap](https://github.com/nmap/nmap)