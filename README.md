# rubyapp_terraform

Prerequisite:

      1. Need Minikube/Kubecluster installed (I have added commands for minikube installation in shell, but commented as It sometime needs to be setup properly).
      
      2. Docker/Terraform installed.
      
      3. Docker Local hub URL needed.
      
Steps to Execute:

      1. Copy only ci-cd.sh file to machine where kubernetes conf is setup (Try to run script with sudo user).
      
      2. Execute ci-cd.sh file with parameter of your local docker repo.
      
             e.g. sh ci-cd.sh local-hub
             
Output:

      1. Docker contianer will get created with name "local-hub/rubyapp:1.0" and will get pushed to Docker local-hub repo.
      
      2. Application will get deployed on the cluster for which config file is set.
