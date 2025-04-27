#!/bin/bash
app_name=$1
env=$2
appImage=$3

export PATH=/github-runner/.local/bin:/github-runner/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin

 if [ -z "$app_name" -o -z "$env" ]; then
 echo Input AppName or env is missing
 exit 1
 fi
#if account not logged in then please log in to argo cd
argocd account list &>/dev/null
if [ $? -ne 0 ] ; then
    argocd_ip=$(kubectl get svc -n argocd argocd-server -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
    argocd_password=$(kubectl get secret argocd-initial-admin-secret -n argocd -o=jsonpath='{.data.password}' | base64 --decode)
    argocd login ${argocd_ip} --insecure --username admin --password ${argocd_password}
fi 

argocd app create $app_name --repo https://github.com/kp3073/aks-roboshop-helm.git --dest-namespace default --dest-server https://kubernetes.default.svc --values env-${env}/${app_name}.yaml --path . --helm-set appImage=$appImage --upsert 
argocd app sync ${app_name}

