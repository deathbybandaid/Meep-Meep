#!/bin/sh
## This will install Meep-Meep

## Vars
NAMEOFAPP="Meep-Meep"
WHATITDOES="This is a Speedtest database with a Webui."
CURRENTUSER="$(whoami)"

## Install Directories
OPTDIRNAME=meepmeep
INSTALLPLACE=/etc/"$OPTDIRNAME"/

{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to setup $NAMEOFAPP? $WHATITDOES" 10 80) 
then
exit
else
echo "Installing"


## End of install
fi }
