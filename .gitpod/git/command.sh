#!/usr/bin/env bash

git config --global alias.random !"git add -A; git commit -am \"$(curl -s http://whatthecommit.com/index.txt)\"; git pull --rebase; git push"
