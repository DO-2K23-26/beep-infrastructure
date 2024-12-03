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
  depends_on = [helm_release.postgres-harbor, kubernetes_manifest.clusterissuer_letsencrypt_prod]
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
}
