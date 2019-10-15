# elm-docker-sample

A sample that publishes an application created with Elm on a k8s cluster using Amazon EKS.

## Local setup

~~~
$ git clone https://github.com/suito01/elm-docker-sample.git
$ npm install
$ npm start
~~~

The local Web server is started up and the development environment is established.

## with Docker

~~~
$ git clone https://github.com/suito01/elm-docker-sample.git
$ docker build -t {your tag} .
~~~

## k8s setup

Please register your AWS account and install the eksctl tool and kubectl beforehand.

~~~
$ git clone https://github.com/suito01/elm-docker-sample.git
$ eksctl create cluster -n elm-docker-sample
$ kubectl apply -f k8s/development.yaml
$ kubectl apply -f k8s/service.yaml
~~~
