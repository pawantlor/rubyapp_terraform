#!/bin/bash

localrepo=$1
echo "Starting with hosting of rubyapp Using Shell,Docker,Terraform"
var1="test-assignment"
mkdir -p $var1
cd $var1
git clone https://github.com/pawantlor/ruby-app.git
cd ruby-app
if [ ! -f Dockerfile ]; then
	echo "Could not find Dockerfile! Exiting"
	exit 1
fi

if [ ! -f http_server.rb ]; then
        echo "Could not find application file! Exiting"
        exit 1
fi

docker build -t $localrepo/rubyapp:1.16 .
docker push $localrepo/rubyapp:1.16


if [ ! -f main.tf ]; then
        echo "Wont be able to exexcute terraform! Exiting"
        exit 1
fi

echo "*********** Terraform Init*********"
terraform init
echo "*********** Terraform Init*********"
terraform plan 

echo "*********** Terraform Apply*********"
terraform apply -var "image-name=$localrepo/rubyapp:1.16"

