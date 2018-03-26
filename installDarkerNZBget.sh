#!/bin/bash
#The below <backuplocation> is where your stock CSS will be backed up to. Change it if you'd like. :)
backuplocation="~/Documents/stocknzbgetcss/"
backupfile="~/Documents/stocknzbgetcss/(date +"%Y_%m_%d_%I_%M_%p")-stylebackup.css"
#This is the name of the CSS file. Do not change.
DarkerNZBgetCSS="nzbget_custom_darkblue.css"
#Change the <stockcss> location below to where your nzbget is installed to.
stockcss="/opt/nzbget"
#The start of actually doing something with the script
cat Misc/art.txt
if [ -d "$backuplocation" ];
  then
    cp "$stockcss"/webui/style.css "$backupfile"
  else
    mkdir "$backuplocation"
fi
if [ -d "$backuplocation"];
  then
    cp "$stockcss"/webui/style.css "$backupfile"
  else
    echo "Could not make new directory at '$backuplocation'. Exiting"
      sleep 2
        exit
fi
if [ -f "$backupfile" ];
  then
    echo "Backup of stock CSS created at '$backupfile'"
  else
    echo "Could not create a backup of the stock CSS file. Exiting"
        sleep 2
    exit
fi
sleep 3
          #echo "I am now in the ~/Documents folder, and downloading the custom css."
          #wget -q https://rawgit.com/ydkmlt84/DarkerNZBget/develop/nzbget_custom_darkblue.css
          #sleep 3
          #echo "File downloaded...now to copy it to the nzbget location."

#  We verified the backup was created in a step before so we will remove the stock CSS file and
#  prepare to copy the new file to the stockcss location.
echo "Inserting the DarkerNZBget CSS now..."
rm "$stockcss"/webui/style.css
sudo cp "$DarkerNZBgetCSS" "$stockcss"/webui/style.css
sleep 3

#Checking to make sure all is well. Almost done.
if [ -f "$stockcss" ];
  then
      echo "DarkerNZBget has been installed. Now to clean up the mess a little bit."
  else
      echo "We got so close...we had trouble moving the new theme into '$stockcss'. Exiting."
        exit
fi
sleep 4
echo "Done...'fingers crossed' you should be able to see the custom CSS now. Refresh the page."
