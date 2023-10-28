variable "machine_type" {

}

variable "name" {

}

variable "network" {

}

variable "subnet" {

}

variable "sa_email" {

}

variable "ext_ip" {
  default = false
  type    = bool
}

variable "label_vm_env" {
  default = ""
  type    = string
}

variable "label_vm_type" {
  default = ""
  type    = string
}