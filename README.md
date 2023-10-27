
# What is that

This project is a demonstration of using Terraform provider aliasing and modular resource layout to do work in multiple GCP regions within a single terraform project. 

![GCP Architecture with Bastian Host](https://github.com/giusepp3palumbo/terraform/blob/main/img/hld.png?raw=true)

# Before you launch

You need to be autenticated in gcloud to launch Terraform. 
There are several options to authenticate, documented [here](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#authentication).
When you launch gcloud, the CLI automatically looks for auth credentials, following the order documented [here](https://cloud.google.com/docs/authentication/application-default-credentials).

To automate the launch of Terraform it is more convenient not to log in with your personal account. That's why I personally create a new service account.

If you decide to create a service account, in the IAM section of the GCP you should assign to it these roles:

* Compute Admin
* Compute Network Admin
* Project IAM Admin
* Service Account Admin
* Service Account User 


Save the service account key on the main folder and set the environment variable GOOGLE_APPLICATION_CREDENTIALS to reference this Service Account Key and tell to gcloud to login in whit it.

```
export GOOGLE_APPLICATION_CREDENTIALS=service-account-terraform.json
```

I saved the key in the service-account-terraform.json file.

You can launch the internal script "init.sh" that do this for you:
```
source ./init.sh
```

# How to launch

Then launch this command to install the terraform provider:

```
terraform init
```

If you don't want to prompt the project-id, add the file "terraform.tfvars" in the main directory with that content:
```
project = "yourproject"
```

To see which resources it provisions, you can launch:

```
terraform plan
```

To apply the changes:

```
terraform apply
```


## Main Topics Covered

### Google Cloud Platform (GCP)

These resources are used:
* Virtual Private Cloud [doc](https://cloud.google.com/vpc/docs/overview)
* Google Cloud Engine [doc](https://cloud.google.com/compute/docs/instances)
* IAM [doc](https://cloud.google.com/iam/docs/overview)
  * For the list of all roles look [here](https://cloud.google.com/compute/docs/access/iam#console_permission)
  * Service Account [doc](https://cloud.google.com/iam/docs/service-account-overview)
* Firewall [doc](https://cloud.google.com/firewall/docs/about-firewalls?hl=en)

The architectural pattern used:
* **Bastion Host**: to avoid the exposure of all VMs on external network, you can expose only one VM, called Bastion Host, from which you can connect to others VMs [doc](https://cloud.google.com/compute/docs/connect/ssh-using-bastion-host). On the official [terraform-google-modules](https://github.com/terraform-google-modules/terraform-google-bastion-host/tree/master) git page you can find more Terraform example about that.


### Terraform
* Each input variable accepted by a module must be declared using a variable block. [doc](https://developer.hashicorp.com/terraform/language/values/variables#declaring-an-input-variable)
* Each output value exported by a module must be declared using an output block:
[doc](https://developer.hashicorp.com/terraform/language/values/outputs#declaring-an-output-value)
* In a module call block, the optional providers meta-argument specifies which provider configurations from the parent module will be available inside the child module. [doc](https://developer.hashicorp.com/terraform/language/meta-arguments/module-providers#the-module-providers-meta-argument)
* Using Alias: [doc](https://developer.hashicorp.com/terraform/language/providers/configuration#alias-multiple-provider-configurations)
* Using Data Sources [doc](https://developer.hashicorp.com/terraform/language/data-sources)

# NOTE
it is not a good idea to access all the other VMs with the Bastion Host service account because you have no way of understanding, in the case of multiple users, which of these has carried out malicious operations on the other VMs. On the audit logs you would always see the service account logged in and not the effective user. This was done for demonstration purposes only.

# TODO
1. 