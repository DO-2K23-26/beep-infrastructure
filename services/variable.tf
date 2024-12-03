variable "domain_name" {
  type        = string
  description = "Domaine name"
  default     = "duratm.com"
}

variable "gh_client_id_argocd" {
  type        = string
  description = "GitHub client ID for argocd"
}

variable "gh_client_secret_argocd" {
  type        = string
  description = "GitHub client secret for argocd"
}

variable "gitlab_runner_token" {
  type       = string
  description = "Gitlab runner token"
}