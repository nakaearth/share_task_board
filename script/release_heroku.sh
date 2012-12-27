#!/bin/bash
echo "====RELEASE START!!!===="
echo "====GIT HUB PUSH===="
git push b-github master
echo "====HEROKU PUSH===="
git push sharetaskboard-heroku master
echo "====APP RESTART===="
heroku restart --app sharetaskboard
####heroku ps:scale clockwork=1
echo "====RELEASE END!!!====="
echo "====STATIC FILES DEPLOY====="
heroku run rake assets:precompile

