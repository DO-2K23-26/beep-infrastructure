resource "helm_release" "uptime_kuma" {
  depends_on = [kubectl_manifest.clusterissuer_letsencrypt_prod, kubernetes_namespace.monitoring]
  name       = "uptime-kuma"
  repository = "https://helm.irsigler.cloud"
  chart      = "uptime-kuma"
  namespace  = "monitoring"
  set {
    name  = "ingress.enabled"
    value = "true"
  }
  set {
    name  = "ingress.annotations.cert-manager\\.io/cluster-issuer"
    value = "letsencrypt-prod"
  }
  set {
    name  = "ingress.hosts[0].host"
    value = "status.${var.domain_name}"
  }
  set {
    name  = "ingress.hosts[0].paths[0].path"
    value = "/"
  }
  set {
    name  = "ingress.hosts[0].paths[0].pathType"
    value = "ImplementationSpecific"
  }
  set {
    name  = "ingress.tls[0].secretName"
    value = "uptime-kuma-tls"
  }
  set {
    name  = "ingress.tls[0].hosts[0]"
    value = "status.${var.domain_name}"
  }
}
