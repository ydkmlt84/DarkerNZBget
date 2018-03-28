#!/usr/bin/env bash
#
# DarkerNZBGet theme installer
# v1.1.1 - 03/27/2018 - Added functionality to ensure provided Docker container exists on the Server.
# v1.1.0 - 03/27/2018 - Added functionality to install theme to Docker containers.
# v1.0.0 - 03/26/2018 - The original.
# Tronyx
#
# Determine if user is root and, if not, tell them to use sudo
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script as root or use sudo when executing this script..."
  exit
fi

# Define local install or Docker container options
while getopts "hi:c:" OPTION
  do
  case "$OPTION" in
    h)
      echo "~*DarkerNZBGet Theme Installer*~"
      echo "Specfify the Nzbget installation type with the -i option:"
      echo "Local install: sudo ./DarkerNZBget_Installer.sh -i local"
      echo "Docker container: sudo ./DarkerNZBget_Installer.sh -i docker"
      echo "If you specify Docker, you must provide the Nzbget container name."
      echo "Provide the Docker container name with the -c option:"
      echo "Container called nzbget: sudo ./DarkerNZBget_Installer.sh -i docker -c nzbget"
      ;;
    i)
      installType="$OPTARG"
      ;;
    c)
      dockerContainer="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument."
      exit 1
      ;;
  esac
done

# Determine if provided Docker container name is valid
function validate_container {
  docker ps --format '{{.Names}}' > /tmp/containers_list.txt
  if grep -q "${dockerContainer}" /tmp/containers_list.txt; then
    echo "Provided Docker container name is valid, continuing..."
  else
    echo "Provided Docker container name is NOT valid!"
    exit 1
  fi
}

# Determine which Package Manager to use
function package_manager {
  echo "Gathering some information and setting some variables..."
  declare -A osInfo;
  osInfo[/etc/redhat-release]='yum -y -q'
  osInfo[/etc/arch-release]=pacman
  osInfo[/etc/gentoo-release]=emerge
  osInfo[/etc/SuSE-release]=zypp
  osInfo[/etc/debian_version]='apt-get -y -qq'

  for f in "${!osInfo[@]}"
    do
      if [[ -f $f ]];then
        packageManager=${osInfo[$f]}
      fi
    done
}

# Determine Nzbget install location and set it as a variable
function get_nzb_dir {
  nzbgetDir=$(locate nzbget |grep conf |head -1 |rev |cut -c12-50 |rev)
}

# Determine Docker AppData dir for NZBget container
function get_appdata_dir {
  appDataDir=$(docker inspect "${dockerContainer}" |grep -A5 -i hostconfig |grep config |rev |cut -c11-50 |rev |tr -d '"' |tr -d ' ')
}

# Make sure unzip and wget are installed
function install_packages {
  echo "Making sure unzip and wget are installed..."
  ${packageManager} install unzip wget
}

# Grab the Darker Nzbget theme CSS archive and extract it
function grab_archive {
  echo "Downloading and extracting the Darker Nzbget theme CSS archive..."
  wget -q -O /tmp/DarkerNZBget.zip https://github.com/ydkmlt84/DarkerNZBget/archive/develop.zip
  unzip -qq -o /tmp/DarkerNZBget.zip -d /tmp/
}

# Display banner
function display_banner {
  cat /tmp/DarkerNZBget-develop/Misc/art.txt
}

# Create backup dir and make a backup of the existing style.css file
function backup {
  echo "Backing up the original style.css file..."
  if [[ "${installType}" = "local" ]]; then
    if [ ! -d "${nzbgetDir}webui/backup" ]; then
      mkdir -p "${nzbgetDir}webui/backup"
      yes |cp -rf "${nzbgetDir}webui/style.css" "${nzbgetDir}webui/backup/style.css.original"
    else
      :
    fi
  elif [[ "${installType}" = "docker" ]]; then
    mkdir -p "${appDataDir}"/backup
    docker cp "${dockerContainer}":/app/nzbget/webui/style.css "${appDataDir}"/backup/style.css.original
  fi
}

# Install the DarkerNZBget CSS
function install_theme {
  echo "Installing the custom CSS file..."
  if [[ "${installType}" = "local" ]]; then
    if [ ! -f "${nzbgetDir}webui/backup/style.css.original" ]; then
      echo "Whoops.. Somehow the stock style.css file didn't get backed up..."
      echo "Let's try that again..."
      yes |cp -rf "${nzbgetDir}webui/style.css" "${nzbgetDir}webui/backup/style.css.original"
      echo "Installing the custom CSS file...again..."
      yes |cp -rf /tmp/DarkerNZBget-develop/nzbget_custom_darkblue.css "${nzbgetDir}webui/style.css"
    else
      yes |cp -rf /tmp/DarkerNZBget-develop/nzbget_custom_darkblue.css "${nzbgetDir}webui/style.css"
    fi
  elif [[ "${installType}" = "docker" ]]; then
    if [ ! -f "${appDataDir}/backup/style.css.original" ]; then
      echo "Whoops.. Somehow the stock style.css file didn't get backed up..."
      echo "Let's try that again..."
      docker cp "${dockerContainer}":/app/nzbget/webui/style.css "${appDataDir}"/backup/style.css.original
      echo "Installing the custom CSS file...again..."
      docker cp /tmp/DarkerNZBget-develop/nzbget_custom_darkblue.css "${dockerContainer}":/app/nzbget/webui/style.css
    else
      docker cp /tmp/DarkerNZBget-develop/nzbget_custom_darkblue.css "${dockerContainer}":/app/nzbget/webui/style.css
    fi
  fi
}

# Verify the DarkerNZBget CSS has been installed and display corresponding message(s)
function validate_install {
  if [[ "${installType}" = "local" ]]; then
    if grep -q TYh5E3n "${nzbgetDir}webui/style.css"; then
      echo "The DarkerNZBget theme has been successfully installed!"
      echo "Please refresh your browser window/tab to see the new theme."
    else
      echo "The DarkerNZBget theme has NOT been installed!"
    fi
  elif [[ "${installType}" = "docker" ]]; then
    if docker exec "${dockerContainer}" grep -q TYh5E3n app/nzbget/webui/style.css; then
      echo "The DarkerNZBget theme has been successfully installed!"
      echo "Please refresh your browser window/tab to see the new theme."
      echo "NOTE: You may need to run this script every time the Docker image gets updated!"
    else
      echo "The DarkerNZBget theme has NOT been installed!"
    fi
  fi
}

# Execute functions
if [[ "${installType}" = "local" ]]; then
  package_manager
  get_nzb_dir
  install_packages
  grab_archive
  display_banner
  backup
  install_theme
  validate_install
elif [[ "${installType}" = "docker" ]]; then
  validate_container
  grab_archive
  display_banner
  get_appdata_dir
  backup
  install_theme
  validate_install
fi
