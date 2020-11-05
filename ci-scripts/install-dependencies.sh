#!/usr/bin/env sh

set -x
# INSTALL AWS
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" 
unzip awscliv2.zip
sudo ./aws/install
# aws --version

# INSTALL aws-iam-authenticator
curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.18.8/2020-09-18/bin/linux/amd64/aws-iam-authenticator
chmod +x ./aws-iam-authenticator
mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$PATH:$HOME/bin
aws-iam-authenticator help

# mkdir ${HOME}/.aws
# echo "$AWS_CONFIG" | base64 --decode > ${HOME}/.aws/config
# echo "$AWS_CREDENTIALS" | base64 --decode > ${HOME}/.aws/credentials

# go get -u github.com/awslabs/amazon-ecr-credential-helper/ecr-login/cli/docker-credential-ecr-login

# INSTALL kubectl
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
kubectl version --client


mkdir ${HOME}/.kube
echo "$KUBE_CONFIG_YAML" | base64 --decode > ${HOME}/.kube/config


# INSTALL helm
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
sudo apt-get install apt-transport-https --yes
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get -y install helm
helm repo add pingidentity https://helm.pingidentity.com/devops
helm repo update

echo "ended install"