#!/bin/bash

#******************MiniKube installation Steps Commented*******************
#curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
#sudo install minikube-linux-amd64 /usr/local/bin/minikube
#minikube start

#*******************Actual Program Starts**********************
if [ $# -eq 0 ]; then
        echo "Local docker repo is not Provided, Please provide local docker repo! Exiting"
        exit 1
fi
localrepo=$1
echo "*****Starting with hosting of rubyapp Using Shell,Docker,Terraform*****"
var1="test-assignment"
mkdir -p $var1
cd $var1
echo "*****Git clone of repo done*****"
git clone https://github.com/pawantlor/rubyapp_terraform.git
cd rubyapp_terraform
if [ ! -f Dockerfile ]; then
	echo "Could not find Dockerfile! Exiting"
	exit 1
else
        echo "*****Found Dockerfile! Proceeding*****"
fi

if [ ! -f http_server.rb ]; then
        echo "Could not find application file! Exiting"
        exit 1
else
        echo "*****Found Application file! Proceeding*****"
fi

echo "*****Running Docker Build*****"
sudo docker build -t $localrepo/rubyapp:1.0 .
sudo docker push $localrepo/rubyapp:1.0
echo "*****Done with Docker Push*****"


if [ ! -f main.tf ]; then
        echo "Wont be able to exexcute terraform! Exiting"
        exit 1
else
        echo "*****Found Terraform main file! Proceeding*****"
fi

echo "*********** Terraform Init*********"
terraform init
echo "*********** Terraform Plan*********"
terraform plan -var "image-name=$localrepo/rubyapp:1.0" -out=tfplan

echo "*********** Terraform Apply*********"

terraform apply -auto-approve "tfplan"

