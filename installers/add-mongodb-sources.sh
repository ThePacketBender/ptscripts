#!/bin/bash


sudo apt-get install curl ca-certificates gnupg
sudo rm -rf /var/apt/cache/archives
sudo apt autoclean && sudo apt autoremove
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.pub | sudo apt-key add -
# mongo pgp key directory listing https://www.mongodb.org/static/pgp/
if [[ ! -d "/etc/apt/sources.list.d/" ]]; then mkdir /etc/apt/sources.list.d/ ; fi
echo 'deb [arc=amd64] https://repo.mongodb.org/apt/debian stretch/mongodb-org/4.2 main amd64' >> /etc/apt/sources.list.d/mongo.list