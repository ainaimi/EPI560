#! /bin/bash

# clone the repository
# if [ $1 == 'local' ]
# then
mkdir IMCS
git clone -b gh-pages \
  https://github.com/ainaimi/IMCS \
  IMCS
# else
# 	# configure your name and email if you have not done so
# 	git config --global user.email "ashley.naimi@emory.edu"
# 	git config --global user.name "Ashley Naimi"
# 	git config --global http.postBuffer 100000000

# 	git clone -b gh-pages \
#   https://${GH_TOKEN}@github.com/${TRAVIS_REPO_SLUG}.git \
#   IMCS
# fi

# remove contents from existing gh-pages branch
cd IMCS
git rm -rf *
echo "All files in /IMCS after git rm"
ls -l 
# replace with contents from master branch /website
cp -r ../website/* ./
# move tmp_lectures and tmp_homeworks in and rename
cp -r ../lectures ./
cp -r ../homework ./

echo "All files in /IMCS after copies"
ls -l 
ls -l lectures
ls -l homework

COMMIT_MESSAGE="update the website."
git add --all *
git commit -m "${COMMIT_MESSAGE}"
git push -q origin gh-pages

