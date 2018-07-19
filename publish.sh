#！/usr/bin/env bash


gitbook build
cp -a _book/*  .
rm -rf _book
git add .
git commit -m 'update chapter'
git push origin master
