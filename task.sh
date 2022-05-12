#!/bin/bash
cd src
mv htmldocs docs
cd docs
mv nimList.html index.html
cd ../..
cp -r docs ../