module "services" {
  source                  = "./services"
  domain_name             = var.domain_name
  gh_client_id_argocd     = var.gh_client_id_argocd
  gh_client_secret_argocd = var.gh_client_secret_argocd
  gh_client_id_harbor     = var.gh_client_secret_harbor
  gh_client_secret_harbor = var.gh_client_secret_harbor
}
