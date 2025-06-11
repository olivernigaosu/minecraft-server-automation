# Minecraft Server Automation

## Background

Welcome! This document will show you how to fully automate the provisioning, configuration, and deployment of a Minecraft server
on AWS. We will build a fully reproducible and restart-safe pipeline using Infrastructure-as-Code tools.

This repo demonstrates how to:
- Provision AWS infrastructure with Terraform
- Configure and run a Minecraft server using Ansible
- Run Minecraft in Docker
- Make the server restart-safe and properly shut down
- Verify service availability using nmap

## Requirements

Ensure you have the following:

- [Terraform](https://developer.hashicorp.com/terraform/install) v1.6+
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) v2.14+
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) v2+
- Python 3
- Git

### AWS Credentials
- Create an IAM user with programmatic access
- Configure credentials with: aws configure

### Environment Variables
- export AWS_ACCESS_KEY_ID="your-key-id"
- export AWS_SECRET_ACCESS_KEY="your-secret"
- export AWS_SESSION_TOKEN="your-session-token"


## Diagram Overview
```
GitHub Repo
    |
    v
Terraform Provisioning (EC2 + Security Group)
    |
    v
Ansible / Bash Setup
    ├── Install Java
    ├── Download Minecraft Server
    └── Configure and enable systemd service
    |
    v
Minecraft Server Running
    |
    v
Verify with `nmap`
    |
    v
Connect using nmap
```

## How to Run the Pipeline

### 1. Clone this Repository
```git clone https://github.come/olivernigaosu/minecraft-server-automation.git```
Clones your GitHub repository to your local machine so you can access the Terraform and Ansible scripts.

```cd minecraft-server-automation```
Navigates into the root directory of your cloned repo.

### 2. Initialize and Deploy Terraform

```cd terraform```
Enters the directory containing Terraform configuration files.

```terraform init```
Initializes the working directory and downloads the required AWS provider.

```terraform apply -auto-approve```
Provisions infrastructure (EC2 instance, security group, etc.) on AWS without requiring manual approval.

### 3. Configure Minecraft Server

```cd ../provisioning```
Navigates to the folder containing your Ansible playbook and inventory file.

```ansible-playbook setup.yml -i inventory.ini```
Uses Ansible to SSH into the EC2 instance, install dependencies, download the Minecraft server JAR, accept the EULA, and configure it as a service.


```nmap -sV -Pn -p 25565 <public_ip>```
Verifies the Minecraft server is accessible by scanning the open port.

## Connect to Minecraft Server

1. Open Minecraft Java Edition
2. Click Multiplayer > Add Server
3. Enter the Public IP from Terraform output
4. Click Join Server
5. Play

## Resources

[Minecraft Server Download](https://www.minecraft.net/en-us/download/server)

[Terraform AWS Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

[Ansible Documentation](https://docs.ansible.com/)

[nmap Command Help](https://nmap.org/book/man-briefoptions.html)