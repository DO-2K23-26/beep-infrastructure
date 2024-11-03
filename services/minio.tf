resource "helm_release" "minio" {
  name             = "minio"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "minio"
  depends_on       = [kubectl_manifest.clusterissuer_letsencrypt_prod]
  namespace        = "minio"
  create_namespace = true


// Ingress configuration for web-ui
  set {
    name  = "ingress.enabled"
    value = "true"
  }

  set {
    name  = "ingress.ingressClassName"
    value = "traefik"
  }

  set {
    name  = "ingress.hostname"
    value = "minio-api.${var.domain_name}"
  }

  set {
    name  = "ingress.annotations.cert-manager\\.io/cluster-issuer"
    value = "letsencrypt-prod"
  }

  set {
    name  = "ingress.tls"
    value = "true"
  }

  // Api ingress

  set {
    name  = "apiIngress.enabled"
    value = "true"
  }

  set {
    name  = "apiIngress.ingressClassName"
    value = "traefik"
  }

  set {
    name  = "apiIngress.hostname"
    value = "minio-api.${var.domain_name}"
  }

  set {
    name  = "apiIngress.annotations.cert-manager\\.io/cluster-issuer"
    value = "letsencrypt-prod"
  }

  set {
    name  = "apiIngress.tls"
    value = "true"
  }

  set {
    name  = "mode"
    value = "distributed"
  }

  set {
    name  = "statefulset.replicaCount"
    value = "4"
  }

  set {
    name  = "provisioning.enabled"
    value = "true"
  }
  set {
    name  = "persistence.size"
    value = "20Gi"
  }


// Buckets
set {
  name  = "buckets[0].name"
  value = "beep-staging"
}

set {
  name  = "buckets[0].versioning"
  value = "Versionning"
}

set {
  name  = "buckets[0].withLock"
  value = "true"
}

}
