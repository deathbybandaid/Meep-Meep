#!/bin/sh
## This will install Meep-Meep

## Vars
NAMEOFAPP=MeepMeep
WHATITDOES="This is a Speedtest database with a Webui."
CURRENTUSER="$(whoami)"

## Repo Vars
REPONAME=MeepMeep
REPOOWNER=deathbybandaid

## Install Directories
INSTALLPLACE=/etc/"$NAMEOFAPP"/
CONFIGURATIONFILE="$INSTALLPLACE"/config.ini

## Check for whiptail
{ if
which whiptail >/dev/null;
then
:
else
apt-get install -y whiptail
fi }

if 
(whiptail --title "$NAMEOFAPP" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to setup $NAMEOFAPP? $WHATITDOES" 10 80) 
then
exit
else
echo "Installing"
git clone https://github.com/"$REPOOWNER"/"$NAMEOFAPP".git $INSTALLPLACE

## Configuration
SPEEDTESTFREQUENCY=$(whiptail --inputbox "How Often (in minutes) should the speedtest run?" 10 80 "60" 3>&1 1>&2 2>&3)
echo "SPEEDTESTFREQUENCY=$SPEEDTESTFREQUENCY" | tee --append $CONFIGURATIONFILE

## End of install
fi
