#!/bin/bash
set -x
set -e

echo 'Build with maven'
mvn -B clean package -DskipTests

NAME=`mvn help:evaluate -Dexpression=project.name | grep "^[^\[]"`
VERSION=`mvn help:evaluate -Dexpression=project.version | grep "^[^\[]"`

mv target/${NAME}-${VERSION}.jar target/app.jar
