variable "project" {

}

variable "cidr" {
  default = {
    europe-west6 = "10.172.0.0/20"
    europe-west8 = "10.198.0.0/20"
  }
}