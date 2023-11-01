variable "project" {

}

variable "cidr" {
  default = {
    europe-west6 = "10.172.0.0/20"
    us-east-2    = "172.20.1.0/24"
  }
}