#！/usr/bin/env bash

gitbook build
cp -a _book/*  .
git checkout master
git add .
git commit -m 'update chapter'
git push origin master
