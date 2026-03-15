#!/bin/bash
set -e

# System update
apt-get update -y

# Install base dependencies
apt-get install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  wget \
  unzip \
  apt-transport-https \
  software-properties-common

# ---------------- Install Latest JDK (21) ----------------
apt-get install -y openjdk-21-jdk

# Verify Java
java -version

# ---------------- Install Jenkins ----------------
wget -O /usr/share/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/" \
> /etc/apt/sources.list.d/jenkins.list

apt-get update -y
apt-get install -y jenkins

systemctl enable jenkins
systemctl start jenkins

# ---------------- Install Docker ----------------
apt-get install -y docker.io

systemctl enable docker
systemctl start docker

usermod -aG docker ubuntu
usermod -aG docker jenkins

# ---------------- Install Trivy ----------------
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor -o /usr/share/keyrings/trivy.gpg

echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] \
https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" \
> /etc/apt/sources.list.d/trivy.list

apt-get update -y
apt-get install -y trivy

# ---------------- Install AWS CLI v2 ----------------
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip
unzip awscliv2.zip
./aws/install

# ---------------- Install kubectl ----------------
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# ---------------- Install Helm ----------------
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
