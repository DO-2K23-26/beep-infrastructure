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
  repository = "https://helm.goharbor.io"
  chart      = "harbor"
  namespace  = "harbor"
  set {
    name  = "expose.tls.enabled"
    value = "true"
  }
  set {
    name  = "expose.tls.certSource"
    value = "secret"
  }
  set {
    name  = "expose.tls.secret.secretName"
    value = "harbor-tls"
  }
  set {
    name  = "expose.ingress.hosts.core"
    value = "registry.${var.domain_name}"
  }
  set {
    name  = "expose.ingress.annotations.cert-manager\\.io/cluster-issuer"
    value = "letsencrypt-prod"
  }
  set {
    name  = "externalURL"
    value = "https://registry.${var.domain_name}"
  }
  set {
    name  = "database.type"
    value = "external"
  }
  set {
    name  = "database.external.host"
    value = "db-postgresql.harbor.svc.cluster.local"
  }
  set {
    name  = "database.external.username"
    value = "postgres"
  }
  set {
    name  = "database.external.coreDatabase"
    value = "registry"
  }
  set {
    name  = "database.external.existingSecret"
    value = "db-postgresql"
  }
  set {
    name  = "core.extraEnvVars[0].name"
    value = "CONFIG_OVERWRITE_JSON"
  }
  set {
    name = "core.extraEnvVars[0].value"
    value = jsonencode({
      auth_mode          = "oidc_auth"
      oidc_name          = "Github"
      oidc_endpoint      = "https://github.com/login/oauth/authorize"
      oidc_groups_claim  = "argocd"
      oidc_admin_group   = "argocd"
      oidc_client_id     = var.gh_client_id_argocd
      oidc_client_secret = var.gh_client_secret_argocd
      oidc_scope         = "openid,email,profile,offline_access"
      oidc_verify_cert   = "false"
      oidc_auto_onboard  = "true"
    })
  }
}

