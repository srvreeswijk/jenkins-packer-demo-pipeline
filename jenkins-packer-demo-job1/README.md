# Bouwt in jenkins een AMi and pushes it to aws. 
The AMI contains:
- centos 7 
- nginx
- docker

- demo app from: docker repo: training/webapp

## the app 
The app runs on port 5000  
The app is wrapped in an service: `docker.demo.service` and default enabled. 
The app will start after the docker service is started


## manual build 
Start alles door het secript `build-and-launch.sh` te starten. 