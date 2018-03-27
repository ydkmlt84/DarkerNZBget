#!/bin/bash
#The below <backupfile> is the name of the backup for your stock CSS. Change it if you'd like. :)
backupfile="($(date +"%Y%m%d-%I:%M%p"))-stylebackup.css"
#This is the name of the CSS file. Do not change.
DarkerNZBgetCSS="nzbget_custom_darkblue.css"
#Change the <nzbgetdir> location below to where your nzbget is installed to.
nzbgetdir="/opt/nzbget"
#The start of actually doing something with the script
cat Misc/art.txt
if [ -d "$nzbgetdir"/webui ];
  then
    sudo mkdir -p "$nzbgetdir"/webui/CSSbackups
  else
    echo "There was a problem with creating the backup directory. Please make sure the nzbgetdir location is correct. Exiting"
      exit
fi
sleep 2
sudo cp "$nzbgetdir"/webui/style.css "$nzbgetdir"/webui/CSSbackups/"$backupfile"
if [ -f "$nzbgetdir"/webui/CSSbackups/"$backupfile" ];
  then
    echo "Backup of stock CSS created at "$nzbgetdir"/webui/CSSbackups/"$backupfile""
  else
    echo "Could not create a backup of the stock CSS file. Exiting"
        sleep 2
    exit
fi
sleep 3

#  We verified the backup was created in a step before so we will remove the stock CSS file and
#  prepare to copy the new file to the stockcss location.
echo "Inserting the DarkerNZBget CSS now..."
sudo rm "$nzbgetdir"/webui/style.css
sudo cp "$DarkerNZBgetCSS" "$nzbgetdir"/webui/style.css
sleep 3

#Checking to make sure all is well. Almost done.
if [ -f "$nzbgetdir"/webui/style.css ];
  then
      echo "DarkerNZBget has been installed. Now to clean up the mess a little bit."
  else
      echo "We got so close...we had trouble moving the new theme into "$nzbgetdir"/webui. Exiting."
        exit
fi
sleep 4
echo "Done...'fingers crossed' you should be able to see the custom CSS now. Refresh the page."
