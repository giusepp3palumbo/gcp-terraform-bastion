variable "project" {

}

variable "environment" {

}

variable "sa_email" {

}

variable "machine_type_bastion_host" {
  type    = string
  default = "f1-micro"
}

variable "machine_type_web_server" {
  type    = string
  default = "f1-micro"
}