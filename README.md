https://itnext.io/cookbook-java-maven-docker-aws-ecr-aws-ecs-fargate-e12cfc126050

docker build -f ./Dockerfile -t jenkins-lts .

docker run \
   -p 8080:8080 \ 
   -v jenkins_home:/var/jenkins_home \
   -v $HOME:/home \
   -v /var/run/docker.sock:/var/run/docker.sock \
   --name jenkins-lts jenkins-lts

docker run -p 8080:8080 -v jenkins_home:/var/jenkins_home -v "//var/run/docker.sock://var/run/docker.sock" --name jenkins-lts jenkins-lts

docker exec -it jenkins-lts bash

https://stackoverflow.com/questions/60916317/using-docker-for-windows-to-volume-mount-a-windows-drive-into-a-linux-container

https://www.youtube.com/watch?v=mbeQWBNaNKQ&ab_channel=CloudBeesTV
