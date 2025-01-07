# iac-ikario

INTRODUCTION
====================================================================================
    Creates a kind k8s with rancher installed running on https://rancher.my-cluster.local/dashboard/

CREATE CLUSTER
=====================================================================================
    kind create cluster --config cluster/kind-cluster-config.yaml


CONFIGURATION WITH TERRAFORM
=====================================================================================
    run firts time
    terraform apply -target=module.cert_manager

    then
    terraform apply

UPDATE HOST FILE
=====================================================================================
    you have to modify your local host file to point, ingress expect that hostname
    127.0.0.0 rancher.my-cluster.local