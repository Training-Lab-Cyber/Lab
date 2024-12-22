# Redteam Infrastructure using Terraform and Ansible

## Overview
This lab  is used for automatic creation of redteam infrastructure, including C2 server, HTTP redirector and testing environments like AD server and terminals.
> Warning: This lab is still early PoC stage and there are lots of hardcoded credentials. Please DO NOT use this lab in a production environment.

## Functions

| Name | Functions | Components |
| ---- | ---- |---- |
| Teamserver |MultiPlayer<br>Payload Generation<br>Listeners (HTTP/HTTPS,SMB,DNS)<br>Customizable C2 Profiles | CobaltStrike<br>Havoc<br>Sliver |
| Attacker's terminal | Connect teamserver<br>R&D | Windows11<br>Kali Linux<br>VMWare/VirtualBox |
| Recdirector | HTTP/S traffic redirection<br>Controlled by  RewriteRule in Apache<br>SSH reverse port forwarding<br>Restrict direct inbound access to the C2| Apache Web Server |
| CDN | Proxy traffic to the redirectors | CloudFront<br>Azure CDN<br>CloudFrare |
| Socks proxy | Passing through firewalls using HTTP/HTTPS<br>Increase network communication speed | Chisel |
| VPN | Connection from attacker's terminal to C2<br>MFA | OpenVPN<br>YubiKey/Google Authenticator |
| Phishing | Upload C2 agents | Apache Web Server |
| Code repository | Git | GitLab |
| Storage | Cloud-based object storage<br>Policy based protection | GoogleCloud Storage |
| CyberRange<br>Testing | Testing operation<br>R&D | Windows Server<br>Active Directory<br>Windows11<br>AV/EDR<br>SIEM |

## Diagrams

* Building Flow
![alt text](image-4.png)
* Networking
![alt text](image-3.png)

<div style="page-break-before:always"></div>

## GitOps Style Implementation
The lab uses Google Cloud to host virtusl machines and virtual networks.  
In order to make the environment disposable, almost all the components are implemented using IaC(terraform and ansible) for automatic construction.

The codes is intended for continuous integration and delivery (CI/CD) pipeline on CloudBuild and Github. 

## Requirements (manual creation)
* Github repository which hosts these codes
* Google Cloud project
* Service Account which has all the privileges below
    - under construction
* Storage blob to store tfstate file
* VPC (name: redteam-vpc)
* VPC peering settings for cloudbuild private pool
* CloudBuild settings
    - Trigger: start building stage when pushed to the Github branch
    - private pool

## Usage
To build the lab, push this repository to the Github branch.

## Roadmap
* Eliminate hardcoded creds
* Eliminate manual creation parts described above
* Create CDNs
* Documentation