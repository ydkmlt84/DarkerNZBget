# DarkerNZBget
[![Discord](https://img.shields.io/badge/Chat-Discord-738bd7.svg?style=for-the-badge)](https://discord.gg/fKcCXwb)<br>
Custom dark theme for the NZBget application.

For anyone who doesn't necessarily use Nginx, but uses Linux, a new [install.sh](https://github.com/ydkmlt84/DarkerNZBget/blob/develop/install.sh) script is now included.  The script works with both a local install of NZBget and with a Docker container. Using Linux (SSH, console, etc.), download the script using `wget`, IE: `wget https://raw.githubusercontent.com/ydkmlt84/DarkerNZBget/develop/install.sh`, give it execute permissions with `chmod +x install.sh`, and then execute the script and follow any prompts/instructions.

## Examples
Here's the usage that gets displayed when the script is executed with no options:

```
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

### NZBget Docker Container Install
Here's an example run of the script with an NZBget Docker Container install:

```
[tronyx@suladan ~]$ sudo ./install.sh -i docker -c nzbget
[sudo] password for tronyx:
Which icon color do you want? ([w]hite or [b]lack): b
Provided Docker container name is valid, continuing...
Downloading and extracting the Darker Nzbget theme CSS archive...
 _____           _             _   _  ____________            _
|  _  \         | |           | \ | ||___  /| ___ \          | |
| | | |__ _ _ __| | _____ _ __|  \| |   / / | |_/ / __ _  ___| |_
| | | / _` | '__| |/ / _ \ '__| . ` |  / /  | ___ \/ _` |/ _ \ __|
| |/ / (_| | |  |   <  __/ |  | |\  |./ /___| |_/ / (_| |  __/ |_
|___/ \__,_|_|  |_|\_\___|_|  \_| \_/\_____/\____/ \__, |\___|\__|
                                                    __/ |
                                                   |___/
Backing up the original style.css and icons.png files...
Installing the custom CSS and icons files...
Tidying some things up...
Validating that the DarkerNZBget theme was installed...
The DarkerNZBget theme has been successfully installed!
Please refresh your browser window/tab to see the new theme.
NOTE: You will need to run this script every time you recreate the container!
```

### Local NZBget Install
Here's an example run of the script with a local NZBget install:

```
tronyx@autobot:~$ sudo ./install.sh -i local
[sudo] password for tronyx:
Which icon color do you want? ([w]hite or [b]lack): b
Gathering some information and setting some variables...
Making sure unzip and wget are installed...
Downloading and extracting the Darker Nzbget theme CSS archive...
 _____           _             _   _  ____________            _
|  _  \         | |           | \ | ||___  /| ___ \          | |
| | | |__ _ _ __| | _____ _ __|  \| |   / / | |_/ / __ _  ___| |_
| | | / _` | '__| |/ / _ \ '__| . ` |  / /  | ___ \/ _` |/ _ \ __|
| |/ / (_| | |  |   <  __/ |  | |\  |./ /___| |_/ / (_| |  __/ |_
|___/ \__,_|_|  |_|\_\___|_|  \_| \_/\_____/\____/ \__, |\___|\__|
                                                    __/ |
                                                   |___/
Backing up the original style.css and icons.png files...
Installing the custom CSS and icons files...
Tidying some things up...
Validating that the DarkerNZBget theme was installed...
The DarkerNZBget theme has been successfully installed!
Please refresh your browser window/tab to see the new theme.
```

## Notes
### Nginx Subfilter
If you're currently using the Nginx sub_filter parameter to use this theme it will need to be removed.

### Icon Colors
There is a 99.999% chance that we will NOT be including any other icon colors, but you can create your own `icons.png` file and make them whatever color(s) you want.

### Other
More scripts for different OSes hopefully coming soon.


## Screenshots
</br>
<img src="https://i.imgur.com/BCcVIZN.png"></img>
<br>
<img src="https://i.imgur.com/eIURD9y.png"></img>
<br>
<img src="https://i.imgur.com/ODiEDDw.png"></img>
