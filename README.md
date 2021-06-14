# rubyapp_terraform

Prerequisite:

      1. Need Minikube/Kubecluster installed (I have added commands for minikube installation in shell, but commented as sometime, it needs to be setup properly).
      2. Change the default value inside variable.tf file for config-path variable according to cluster admin file path location
      3. Docker/Terraform installed. (kubernetes provider v2.3.1/Terraform v0.12.31 was used to do this assignment) 
      4. Docker Local hub URL needed by shell file.
      5. Changed the application file (http_server.rb) with port from 80 to 8080. Generally port from 1 to 1023 are restircted for root user.
      
Steps to Execute:

      1. Copy only ci-cd.sh file to server where kubernetes admin conf is setup (Try to run script with sudo user, Docker build/push to work).
      2. Execute ci-cd.sh file with parameter of your local docker repo.
             e.g. sh ci-cd.sh local-hub
             
Output:

      1. Docker contianer will get created with name "local-hub/rubyapp:1.0" and will get pushed to Docker local-hub repo.
      2. Application will get deployed on the cluster under "testapp" namespace
             e.g. kubectl get pods,svc -n testapp
      3. curl http://localhost:30201/healthcheck should give output as: Health is OK
      4. curl http://localhost:30201/anything should give output as: Well, hello there!
