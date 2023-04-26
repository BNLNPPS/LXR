#!/bin/sh

ver=master
topDir=/home/lxrsource/eic
logFile=$topDir/logs/cron-eic_lxr.log
lxrDir=/usr/local/share/lxr/eic-lxr/lxr
srcCloneScript=/home/bin/eic-clonePacks_and_cleanup.sh

# preserve/define file descriptor-3 to terminal
exec 3>&1
WEEKDAY=`date +%w`
exec &> ${logFile}_${WEEKDAY}

echo "topDir=$topDir version=$ver"

echo -e "Packages cloning started at" `date` "\n"
cd $topDir/source/$ver
rm -rf *

# clone the packages and removed ".git" and "*.root"
$srcCloneScript
echo -e "\nPackages cloning finished at" `date`

echo -e"\nIndexing started at" `date` "\n"
rm -rf $topDir/glimpsedir/lxr/$ver
cd $lxrDir
./genxref --url=http://localhost/lxr --version=$ver
echo "\nIndexing finished at" `date`        
