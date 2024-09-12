# Beep VPS

## Description

For the Beep project, we need a VPS to host some services and the different environments of beep (staging, prod).
The infrastructure would like to be as automated as possible. For start we will need to install a k3s cluster on a VPS after this the different services will be deployed on the cluster by CI/CD with terraform.

## Endpoints

Access to the different services deployed on the VPS.

- [status.beep.ovh](https://status.beep.ovh) : Status page for the beep project and the different services. ([Uptime Kuma](https://github.com/louislam/uptime-kuma))
- [registry.beep.ovh](https://registry.beep.ovh) : Registry for the different images of the beep project. ([Harbor](https://github.com/goharbor/harbor))
- [argocd.beep.ovh](https://argocd.beep.ovh) : ArgoCD for the different environments of the beep project. ([ArgoCD](https://github.com/argoproj/argo-cd))


## Initial setup

### Update
```bash
sudo apt update && sudo apt upgrade
sudo apt clean
```

### Add do user
```bash
sudo adduser do
sudo usermod -aG sudo do
sudo mkdir /home/do/.ssh
sudo nano /home/do/.ssh/authorized_keys # Add all do2023-26 keys
sudo chown -R do:do /home/do/.ssh
sudo chmod 700 /home/do/.ssh
sudo chmod 600 /home/do/.ssh/authorized_keys
```

### Delete default user
```bash
sudo deluser --remove-home ubuntu # Delete default user (ubuntu, debian, etc)
```

### SSH
```bash
sudo nano /etc/ssh/sshd_config # Change PermitRootLogin (no), PasswordAuthentication (no), PubkeyAuthentication (yes)
```

### Install k3s
```bash
curl -sfL https://get.k3s.io | sh - 
sudo k3s kubectl get nodes # Check if k3s is installed
```

### Get kubeconfig
```bash
sudo cat /etc/rancher/k3s/k3s.yaml
```
