# Setup

brew install postgres

rvm use 3.2.2

rvm gemset use tiny_url --create
gem install rails --no-document

rails new tiny_url --api -d postgresql --skip-git --skip-docker --skip-ci

