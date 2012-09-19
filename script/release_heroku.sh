#!/bin/bash
echo "====RELEASE START!!!===="
echo "====GIT HUB PUSH===="
git push b-github master
echo "====HEROKU PUSH===="
git push sharetaskboard-heroku master
echo "====APP RESTART===="
heroku restart --app sharetaskboard

echo "====RELEASE END!!!====="

