#!/bin/sh
[[ -d /tmp/github_utilities ]] && rm -rf /tmp/github_utilities
mkdir /tmp/github_utilities
prevdir=`pwd`
cd /tmp/github_utilities
git clone https://github.com/eic/utilities.git
array=($(cat utilities/jenkins/EIC/Doxygen.Jenkins | grep "dir(" | cut -d"'" -f2 | grep -v work | grep -v utilities))
cd $prevdir
rm -rf /tmp/github_utilities
[[ -f clone_packages_for_indexing.sh ]] && rm -f clone_packages_for_indexing.sh
touch clone_packages_for_indexing.sh
for i in "${array[@]}"
do
    echo "git clone https://github.com/eic/${i}" >> clone_packages_for_indexing.sh
done

