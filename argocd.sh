#!/bin/bash

argo_server_ip=(kubectl get svc -n argocd argocd-server -o jsonpath='{.status.loadBalancer.ingress[0].ip}') 