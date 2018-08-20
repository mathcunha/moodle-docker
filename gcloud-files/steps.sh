#!/bin/bash

kubectl apply -f mysql-volumeclaim.yaml
kubectl apply -f moodle-volumeclaim.yaml
kubectl get pvc
kubectl create secret generic mysql --from-literal=password=$1
kubectl create -f mysql.yaml
kubectl get pod -l app=mysql
kubectl create -f mysql-service.yaml
kubectl get service mysql
kubectl create -f moodle.yaml
kubectl get pod -l app=moodle
kubectl create -f moodle-service.yaml
kubectl get svc -l app=moodle


#//at mysql kubectl exec mysql-78f86955bc-7xmfd -ti /bin/bash
#set global innodb_file_format = `BARRACUDA`;
#set global innodb_large_prefix = `ON`;
