# DarkerNZBget
[![Discord](https://img.shields.io/badge/Chat-Discord-738bd7.svg?style=for-the-badge)](https://discord.gg/fKcCXwb)<br>
Custom CSS to apply to NZBget.

For anyone who doesn't use NGINX, but uses Linux, the script [install.sh](https://github.com/ydkmlt84/DarkerNZBget/blob/develop/install.sh) is now included. Using Linux, download the script using `wget`, IE: `wget https://github.com/ydkmlt84/DarkerNZBget/blob/develop/install.sh`, give it execute permissions with `chmod +x install.sh`, and then run the script and follow any prompts/instructions.

Here's the usage that gets displayed when the script is executed with no options:

```shell
[tronyx@suladan ~]# sudo ./install.sh
~*DarkerNZBGet Theme Installer*~

Usage: install.sh [OPTION]...

-i VALUE    Install type:
            -i local
            -i docker

-c VALUE    Docker container name
            -c nzbget

-h          Display usage

Specfify the Nzbget installation type with the -i option:
Local install: sudo ./install.sh -i local
Docker container: sudo ./install.sh -i docker
If you specify Docker, you must provide the Nzbget container name.
Provide the Docker container name with the -c option:
Container called nzbget: sudo ./install.sh -i docker -c nzbget
```

If you're currently using the NGINX sub_filter this will need to be removed.

More scripts for different OSes hopefully coming soon.

<b> Screenshots</b>
</br>
<img src="https://i.imgur.com/rxXM2Wy.png"></img>
<br>
<img src="https://i.imgur.com/c4qNczJ.png"></img>
<br>
