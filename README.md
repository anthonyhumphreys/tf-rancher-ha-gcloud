# Terraform - Rancher High Availability Installation

## Purpose
This terraform project will allow you to deploy a Highly Available Rancher installation to your Google Cloud.

## Deployment
Clone the repo and copy your service_account.json to the repo directory and run terraform plan to see the execution plan.

This project will deploy 3 Ubuntu 16.04 Nodes and install docker 18.09.2 on them. They will be deployed under a managed instance group.

PRs and feedback welcome! More documentation to follow...!