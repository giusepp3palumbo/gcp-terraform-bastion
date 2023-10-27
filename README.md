
# What is that

This project is a demonstration of using terraform provider aliasing and modular resource layout to do work in multiple GCP regions within a single terraform project. 

# How to launch

First, autenticate with your Google Account. There are several options documented [here](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#authentication).

When Google show for auth credentials, follows the order documented [here](https://cloud.google.com/docs/authentication/application-default-credentials).

For this project I personally create a new service account in the IAM section of the GCP with roles Compute Admin and Compute Network Admin and saved it on the main folder. I saved the key in the service-account-terraform.json file. Set the environment variable GOOGLE_APPLICATION_CREDENTIALS to reference this Service Account Key and tell to gcloud to login in whit it.

```
export GOOGLE_APPLICATION_CREDENTIALS=service-account-terraform.json
```

You can launch the internal script "init.sh" that do this for you:
```
source ./init.sh
```

Then launch this command to install the terraform provider:

```
terraform init
```

To see which resources it provisions, you can launch:

```
terraform plan
```

To apply the changes:

```
terraform apply
```

# How it works

* Each input variable accepted by a module must be declared using a variable block. [doc](https://developer.hashicorp.com/terraform/language/values/variables#declaring-an-input-variable)

* Each output value exported by a module must be declared using an output block:
[doc](https://developer.hashicorp.com/terraform/language/values/outputs#declaring-an-output-value)

* In a module call block, the optional providers meta-argument specifies which provider configurations from the parent module will be available inside the child module. [doc](https://developer.hashicorp.com/terraform/language/meta-arguments/module-providers#the-module-providers-meta-argument)

* Using Alias: [doc](https://developer.hashicorp.com/terraform/language/providers/configuration#alias-multiple-provider-configurations)

* Using Data Sources [doc](https://developer.hashicorp.com/terraform/language/data-sources)

# TODO
1. implement Bastion Host [doc](https://cloud.google.com/compute/docs/connect/ssh-using-bastion-host?hl=it)