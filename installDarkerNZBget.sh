#!/bin/bash
#The below <backuplocation> is where your stock CSS will be backed up to. Change it if you'd like
#but you will need to change the mkdir command to match.
backuplocation="stocknzbgetcss"
backupfile="~/Documents/stocknzbgetcss/stylebackup.css"
#This is the name of the CSS file that will be downloaded. Do not change.
DarkerNZBgetCSS="nzbget_custom_darkblue.css"
#Change the <stockcss> location below to where your nzbget is installed to.
stockcss="/opt/nzbget/webui/style.css"
cd ~/Documents
mkdir "$backuplocation"
cp "$stockcss" "$backuplocation"/stylebackup.css
if [ -f "$backuplocation"/stylebackup.css ];
then
        echo "Backup of stock CSS created at '$backupfile'"
else
        exit
fi
sleep 3
echo "I am now in the ~/Documents folder, and downloading the custom css."
wget -q https://rawgit.com/ydkmlt84/DarkerNZBget/develop/nzbget_custom_darkblue.css
sleep 3
echo "File downloaded...now to copy it to the nzbget location."
#Checking to make sure we have a backup
if [ -f "$backuplocation"/stylebackup.css ];
then
        rm "$stockcss"
        sudo cp ~/Documents/"$DarkerNZBgetCSS" "$stockcss"
else
        echo "The backup failed. Stopping the rest of the script."
        exit
fi
sleep 3
echo "Now to clean up the mess a little bit (removing the downloaded custom CSS file)"
        rm ~/Documents/"$DarkerNZBgetCSS"
sleep 4
echo "Done...'fingers crossed' you should be able to see the custom CSS now."
