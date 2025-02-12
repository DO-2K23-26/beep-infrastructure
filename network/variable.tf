variable "stunner_deployed" {
  type        = bool
  description = "true once stunner is deployed"
}

variable "stunner_port" {
  type = number
  description = "The port that will be use by the stunner endpoint"
}

variable "domain_name" {
  type        = string
  description = "Domaine name"
}
