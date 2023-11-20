#!/bin/bash
export AWS_PROFILE=default
aws configure list
aws eks update-kubeconfig --region REGION --name CLUSTER --kubeconfig=/home/gitlab-runner/.kube/config