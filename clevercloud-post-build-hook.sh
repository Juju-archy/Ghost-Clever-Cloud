#!/bin/sh
npm install -g ghost-cli # install ghost-cli on Clever Cloud
mkdir ghost # create a folder for a new local instance of Ghost
cd ghost
ghost install local
ghost stop
cp ../config.production.json .
cp -r ../content/adapters/ghost-s3 content/adapters/ghost-s3