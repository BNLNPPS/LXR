#!/bin/sh

ver=master
topDir=/home/lxrsource/sphenix
logFile=$topDir/logs/cron-sphenix_lxr.log
lxrDir=/usr/local/share/lxr/sphenix-lxr/lxr
srcCloneScript=/home/bin/clone_sphenix_packages.sh

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
find . -type d -name ".git" -prune -exec rm -rf {} \;
find . -name "*.root" -prune -exec rm -f {} \;
echo -e "\nPackages cloning finished at" `date`

echo -e"\nIndexing started at" `date` "\n"
rm -rf $topDir/glimpsedir/lxr/$ver
cd $lxrDir
./genxref --url=http://localhost/lxr --version=$ver
echo "\nIndexing finished at" `date`        
