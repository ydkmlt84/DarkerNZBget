#!/usr/bin/env bash
#
# DarkerNZBGet theme installer
# v1.0.0 - 03/26/2018 - The original
# Tronyx
#
# Determine if user is root and, if not, tell them to use sudo
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or use sudo when executing this script..."
  exit
fi

# Determine which Package Manager to use
echo "Gathering some information and setting some variables..."
declare -A osInfo;
osInfo[/etc/redhat-release]='yum -y -q'
osInfo[/etc/arch-release]=pacman
osInfo[/etc/gentoo-release]=emerge
osInfo[/etc/SuSE-release]=zypp
osInfo[/etc/debian_version]='apt-get -y -qq'

for f in ${!osInfo[@]}
do
  if [[ -f $f ]];then
    packageManager=${osInfo[$f]}
  fi
done

# Determine Nzbget install location and set it as a variable
nzbgetDir=$(locate nzbget |grep conf |head -1 |rev |cut -c12-50 |rev)

# Make sure unzip and wget are installed
echo "Making sure unzip and wget are installed..."
${packageManager} install unzip wget

# Grab the Darker Nzbget theme CSS archive and extract it
echo "Downloading and extracting the Darker Nzbget theme CSS archive..."
wget -q -O /tmp/DarkerNZBget.zip https://github.com/ydkmlt84/DarkerNZBget/archive/develop.zip
unzip -qq -o /tmp/DarkerNZBget.zip -d /tmp/

# Display banner
cat /tmp/DarkerNZBget-develop/Misc/art.txt

# Create backup dir and make a backup of the existing style.css file
echo "Backing up the original style.css file..."
if [ ! -d "${nzbgetDir}webui/backup" ]; then
  mkdir "${nzbgetDir}webui/backup"
  yes |cp -rf "${nzbgetDir}webui/style.css" "${nzbgetDir}webui/backup/style.css.original"
else
  :
fi

# Install the DarkerNZBget CSS
echo "Installing the custom CSS file..."
if [ ! -f "${nzbgetDir}webui/backup/style.css.original" ]; then
  echo "Whoops.. Somehow the stock style.css file didn't get backed up..."
  echo "Let's try that again..."
  yes |cp -rf "${nzbgetDir}webui/style.css" "${nzbgetDir}webui/backup/style.css.original"
  echo "Installing the custom CSS file...again..."
  yes |cp -rf /tmp/DarkerNZBget-develop/nzbget_custom_darkblue.css "${nzbgetDir}webui/style.css"
else
  yes |cp -rf /tmp/DarkerNZBget-develop/nzbget_custom_darkblue.css "${nzbgetDir}webui/style.css"
fi

# Verify the DarkerNZBget CSS has been installed and display corresponding message(s)
if grep -q DarkerNZBGet "${nzbgetDir}webui/style.css"; then
  echo "The DarkerNZBget theme has been successfully installed!"
  echo "Please refresh your browser window/tab to see the new theme."
else
  echo "The DarkerNZBget theme has NOT been installed!"
fi
