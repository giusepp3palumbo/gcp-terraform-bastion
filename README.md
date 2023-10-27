

First, autenticate with your Google Account. There are several options:

https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#authentication

When Google show for auth credentials, follows this order:

https://cloud.google.com/docs/authentication/application-default-credentials


In this example I create a new service account in the IAM section of the GCP and saved it on this folder. I called it service-account-terraform.json.

```
export GOOGLE_APPLICATION_CREDENTIALS=service-account-terraform.json
```


```
terraform init
```


Each input variable accepted by a module must be declared using a variable block:
https://developer.hashicorp.com/terraform/language/values/variables#declaring-an-input-variable

Each output value exported by a module must be declared using an output block:
https://developer.hashicorp.com/terraform/language/values/outputs#declaring-an-output-value



In a module call block, the optional providers meta-argument specifies which provider configurations from the parent module will be available inside the child module.
https://developer.hashicorp.com/terraform/language/meta-arguments/module-providers#the-module-providers-meta-argument


Using Alias:
https://developer.hashicorp.com/terraform/language/providers/configuration#alias-multiple-provider-configurations

Using Data Sources
https://developer.hashicorp.com/terraform/language/data-sources
