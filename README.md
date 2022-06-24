https://itnext.io/cookbook-java-maven-docker-aws-ecr-aws-ecs-fargate-e12cfc126050
https://stackoverflow.com/questions/60916317/using-docker-for-windows-to-volume-mount-a-windows-drive-into-a-linux-container
https://www.youtube.com/watch?v=mbeQWBNaNKQ&ab_channel=CloudBeesTV

docker build -f ./Dockerfile -t jenkins-lts .

docker run \
   -p 8080:8080 \
   -v jenkins_home:/var/jenkins_home \
   -v $HOME:/home \
   -v /var/run/docker.sock:/var/run/docker.sock \
   --name jenkins-lts jenkins-lts

docker run -p 8080:8080 -v jenkins_home:/var/jenkins_home -v "//var/run/docker.sock://var/run/docker.sock" --name jenkins-lts jenkins-lts

docker exec -it jenkins-lts bash

https://docs.aws.amazon.com/AmazonECS/latest/developerguide/getting-started-aws-copilot-cli.html
https://www.youtube.com/watch?v=Nv7s-N8ZxQA&ab_channel=AWSOnlineTechTalks
https://github.com/aws/copilot-cli/issues/1345
https://aws.amazon.com/blogs/containers/developing-an-application-based-on-multiple-microservices-using-the-aws-copilot-and-aws-fargate/

copilot init --app demo-gateway-client1 \
            --name demo-gateway-client1-lb \
            --type 'Load Balanced Web Service' \
            --dockerfile 'E:\Manu\DEV\spring\demo-spring-gateway\demo-gateway-client1\Dockerfile' \
            --port 8080

copilot env init --app demo-gateway-client1 \
            --name dev \
            --profile copilot-user \
            --default-config

copilot deploy

copilot app ls
copilot app show

copilot app delete

https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-cli-tutorial-fargate.html
