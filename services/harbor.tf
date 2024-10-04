resource "helm_release" "postgres-harbor" {
  name             = "db"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "postgresql"
  namespace        = "harbor"
  create_namespace = true
  set {
    name  = "auth.username"
    value = "harbor"
  }
  set {
    name  = "auth.password"
    value = "STRONG_PASSWORD"
  }
  set {
    name  = "auth.postgresPassword"
    value = "STRONG_PASSWORD"
  }
  set {
    name  = "auth.database"
    value = "registry"
  }
}
resource "helm_release" "harbor" {
  depends_on = [helm_release.postgres-harbor, kubectl_manifest.clusterissuer_letsencrypt_prod]
  name       = "harbor"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "bitnami/harbor"
  namespace  = "harbor"

  values = [
    templatefile("values/harbor.yaml.tpl", {
      domain_name             = var.domain_name
      gh_client_id_harbor     = var.gh_client_id_harbor
      gh_client_secret_harbor = var.gh_client_secret_harbor
    })
  ]

}
