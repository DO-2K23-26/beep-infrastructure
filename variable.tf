variable "kubeconfig" {
  type        = string
  description = "Paht to the kubeconfig file"
  default     = "~/.kube/config"
}

variable "domain_name" {
  type        = string
  description = "Domaine name"
  default     = "beep.ovh"
}

variable "gh_client_id_argocd" {
  type        = string
  description = "GitHub client ID for argocd"
}

variable "gh_client_secret_argocd" {
  type        = string
  description = "GitHub client secret for argocd"
}

variable "gh_client_id_harbor" {
  type        = string
  description = "GitHub client ID for harbor"

}

variable "gh_client_secret_harbor" {
  type        = string
  description = "GitHub client secret for harbor"
}
