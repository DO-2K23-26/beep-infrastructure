module "services" {
  source                  = "./services"
  domain_name             = var.domain_name
  gh_client_id_argocd     = var.gh_client_id_argocd
  gh_client_secret_argocd = var.gh_client_secret_argocd
  gitlab_runner_token     = var.gitlab_runner_token
}

module "network" {
  source = "./network"
  stunner_port = var.stunner_port
  stunner_deployed = module.services.stunner_deployed
}
