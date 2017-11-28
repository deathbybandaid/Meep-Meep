#!/bin/sh
## This will install Meep-Meep

## Vars
NAMEOFAPP="MeepMeep"
WHATITDOES="This is a Speedtest database with a Webui."
CURRENTUSER="$(whoami)"

## Repo Vars
REPONAME=MeepMeep
REPOOWNER=deathbybandaid

## Install Directories
OPTDIRNAME=meepmeep
INSTALLPLACE=/etc/"$OPTDIRNAME"/

## Check for whiptail
{ if
which whiptail >/dev/null;
then
:
else
apt-get install -y whiptail
fi }

{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to setup $NAMEOFAPP? $WHATITDOES" 10 80) 
then
exit
else
echo "Installing"
git clone https://github.com/"$REPOOWNER"/"$REPONAME".git /etc/"$REPONAME"/

## End of install
fi }
