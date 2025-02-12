resource "helm_release" "cert-manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  namespace        = "cert-manager"
  create_namespace = true
  set {
    name  = "crds.enabled"
    value = "true"
  }
  set {
    name = "config.apiVersion"
    value = "controller.config.cert-manager.io/v1alpha1"
  }
  set {
    name = "config.kind"
    value = "ControllerConfiguration"
  }
  set {
    name = "config.enableGatewayAPI"
    value = "true"
  }
}

resource "kubectl_manifest" "clusterissuer_letsencrypt_prod" {
  depends_on = [helm_release.cert-manager]

  yaml_body = <<YAML
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    email: contact@${var.domain_name}
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: letsencrypt-prod
    solvers:
    - http01:
        ingress:
          class: traefik
YAML
}
