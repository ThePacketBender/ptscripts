#/bin/sh
#edit for debian or ubuntu version if necessary
#repositories for supported versions can be found at:
#	https://packages.microsoft.com/
#	https://packages.microsoft.com/repos/

#run interctive shell with command: pwsh

cd ~/Downloads
wget http://ftp.us.debian.org/debian/pool/main/i/icu/libicu57_57.1-6+deb9u2_amd64.deb
dpkg -i libicu57_57.1-6+deb9u2_amd64.deb
apt update && apt -y install curl gnupg apt-transport-https
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-stretch-prod stretch main" > /etc/apt/sources.list.d/microsoft.list
apt update
apt -y install powershell


#other packages to consider installing:
#azure-functions-core-tools
#mssql-tools
#mssql-cli
#dotnet-sdk-2.2
#dotnet-host