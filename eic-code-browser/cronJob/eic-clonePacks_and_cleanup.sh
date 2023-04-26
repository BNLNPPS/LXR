listfile_repos=/home/lxrsource/eic/repo-list.txt

while read repo; do
   if [ "X$repo" != "X" ]; then
      echo "repo=$repo"
      git clone https://github.com/eic/$repo
   fi
done <$listfile_repos

find . -type d -name ".git" -prune -exec rm -rf {} \;
find . -name "*.root" -prune -exec rm -f {} \;

# copy all the header files from the ePIC container
curl -O https://eic.github.io/eic-shell/install.sh
chmod +x ./install.sh
mkdir temp
./install.sh -n -p temp -t $PWD/temp
export SINGULARITY_CACHEDIR=$PWD/temp
export SINGULARITY_TMPDIR=$PWD/temp
singularity exec -B $PWD temp/local/lib/jug_xl-nightly.sif cp -RL /usr/local/include $PWD/include
rm -rf install.sh temp


