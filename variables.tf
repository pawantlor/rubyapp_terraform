

variable "container-port" {
  default = "8080"
  type    = string
}

variable "kube-namespace" {
  default = "testapp"
  type    = string 
}

variable "node-port" {
  default = "30201"
  type    = string
}

variable "image-name" {
  default = "rubyapp:1.0"
  type    = string
}

variable "label-name" {
  default = "MytestApp"
  type    = string
}
