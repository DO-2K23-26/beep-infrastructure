resource "helm_release" "minio" {
  name             = "minio"
  repository       = "https://charts.min.io/"
  chart            = "minio"
  depends_on       = [kubectl_manifest.clusterissuer_letsencrypt_prod]
  namespace        = "minio"
  create_namespace = true


  // Minio server
  set {
    name  = "ingress.enabled"
    value = "true"
  }
  set {
    name  = "ingress.annotations.cert-manager\\.io/cluster-issuer"
    value = "letsencrypt-prod"
  }
  set {
    name  = "ingress.ingressClassName"
    value = "traefik"
  }

  set {
    name  = "ingress.path"
    value = "/"
  }

  set {
    name  = "ingress.hosts[0]"
    value = "minio-server.${var.domain_name}"
  }

  set {
    name  = "ingress.tls[0].secretName"
    value = "minio-server-tls"
  }
  set {
    name  = "ingress.tls[0].hosts[0]"
    value = "minio-server.${var.domain_name}"
  }

  // Minio ui
  set {
    name  = "consoleIngress.enabled"
    value = "true"
  }

  set {
    name  = "consoleIngress.annotations.cert-manager\\.io/cluster-issuer"
    value = "letsencrypt-prod"
  }

  set {
    name  = "consoleIngress.ingressClassName"
    value = "traefik"
  }

  set {
    name  = "consoleIngress.path"
    value = "/"
  }

  set {
    name  = "consoleIngress.hosts[0]"
    value = "minio.${var.domain_name}"
  }

  set {
    name  = "ingress.tls[0].secretName"
    value = "minio-tls"
  }
  set {
    name  = "ingress.tls[0].hosts[0]"
    value = "minio.${var.domain_name}"
  }

}
