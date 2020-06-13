## 🌐sub3num





<p align="center">
  <a href="https://github.com/shagunattri/pwgen/pulls">
    <img src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg?longCache=true" alt="Pull Requests">
  </a>
  <a href="LICENSE">
    <img src="https://img.shields.io/badge/License-MIT-lightgrey.svg?longCache=true" alt="MIT License">
  </a>
</p>

<p align="center">
  <a href="https://twitter.com/sp3ppr" target="_blank">
    <img src="https://img.shields.io/twitter/follow/sp3ppr.svg?logo=twitter">
  </a>
</p>

<div align="center">
  <sub>Created by
  <a href="https://twitter.com/sp3ppr">sp3ppr</a> and
  <a href="https://github.com/shagunattri/pwGen/graphs/contributors">contributors</a>
</div>

<br>

****

Automate your Web Enumeration & reconnaissance and save time with sub3num.
Enumeration and automation shellscript to find subdomains and other extra features.
Integrates tools written in Go to automate the process of web application enumeration.

## Features

- Install essential reconnaissance tools and dependencies
- Subdomain Enumeration
- Find alive Subdomdomains
- Look for possible Domain takeover 
- Directory busting with gobuster
- Look a t unique HTML attribs using HTML-tool
- Scan web server using nikto
- Find archieve of URIs using waybackurls
- ...and many more :)


### Installation

To get started, check out the installation instructions in the [documentation](install/setup.md).

### Usage

```console
 ./sub3num <domain>
```


### Screenshots


![sub3num](https://user-images.githubusercontent.com/29366864/80619137-e19f5d80-8a61-11ea-90b3-6f9483b4a326.png)



### Tools utilised

- [Assetfinder](https://github.com/tomnomnom/assetfinder)
- [httprobe](https://github.com/tomnomnom/httprobe)
- [subjack](https://github.com/haccer/subjack)
- [html-tool](https://github.com/tomnomnom/hacks/tree/master/html-tool)
- [subjack](https://github.com/haccer/subjack)
- [waybackurls](https://github.com/tomnomnom/waybackurls)
- [nikto](https://github.com/sullo/nikto)
- [gobuster](https://github.com/OJ/gobuster)



**Note**: You need to install the dependencies before installing the tools.

Most of the tools are added to the PATH, you can access them from everywhere in the file system.


***Tested on Manjaro-Arch Linux***

## Contribution 

Feel free to add more tools so that the Bug Bounty community can benefit from them.
When contributing to this repository, please first discuss the change you wish to make via issue,before making a change.


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
