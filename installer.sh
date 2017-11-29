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
INSTALLPLACE=/opt/"$NAMEOFAPP"/
CONFIGFILESDIR=/etc/"$NAMEOFAPP"/
CONFIGURATIONFILE="$CONFIGFILESDIR"/config.ini

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

## Dependencies
echo 'Installing Dependencies'
declare -a dependenciescheckarray=("curl" "whiptail" "git")
for i in "${dependenciescheckarray[@]}"
do
echo 'Checking for ' $i
{ if
which $i >/dev/null;
then
:
else
apt-get install -y $i
fi }
echo ""
done

echo "Installing"
git clone https://github.com/"$REPOOWNER"/"$NAMEOFAPP".git $INSTALLPLACE
mkdir $CONFIGFILESDIR
echo ""

## Configuration
touch $CONFIGURATIONFILE

SPEEDTESTFREQUENCY=$(whiptail --inputbox "How Often (in minutes) should the speedtest run?" 10 80 "60" 3>&1 1>&2 2>&3)
echo "SPEEDTESTFREQUENCY=$SPEEDTESTFREQUENCY" | tee --append $CONFIGURATIONFILE

DOWNSPEED=$(whiptail --inputbox "What Is your down speed?" 10 80 "60" 3>&1 1>&2 2>&3)
echo "DOWNSPEED=$DOWNSPEED" | tee --append $CONFIGURATIONFILE

UPSPEED=$(whiptail --inputbox "What Is your up speed?" 10 80 "60" 3>&1 1>&2 2>&3)
echo "UPSPEED=$UPSPEED" | tee --append $CONFIGURATIONFILE

## Make sure all required services are running
declare -a servicecheckarray=("lighttpd" "lighttpd" "lighttpd")
for i in "${servicecheckarray[@]}"
do
echo 'Checking ' $i
if (( $(ps -ef | grep -v grep | grep $i | wc -l) > 0 ))
then
echo $i ' is running!!!'
else
echo $i ' is not running!!!'
echo $i ' is restarting!!!'
service $i restart
fi
echo ""
done

## End of install
fi
