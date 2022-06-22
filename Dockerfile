FROM jenkins/jenkins:lts-jdk11
USER root
RUN apt-get update
RUN curl -sSL https://get.docker.com/ | sh && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    aws --version
# give jenkins docker rights
RUN usermod -aG docker jenkins