resource "helm_release" "argocd" {
  depends_on       = [kubectl_manifest.clusterissuer_letsencrypt_prod]
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true

  set {
    name  = "global.domain"
    value = "argocd.${var.domain_name}"
  }

  set {
    name  = "configs.cm.create"
    value = "true"
  }

  set {
    name  = "configs.cm.dex\\.config"
    value = <<-EOT
      connectors:
        - type: github
          id: github
          name: GitHub
          config:
            clientID: ${var.gh_client_id_argocd}
            clientSecret: ${var.gh_client_secret_argocd}
            orgs:
              - name: DO-2K23-26
    EOT
  }

  set {
    name  = "configs.rbac.policy\\.ghgroup\\.csv"
    value = <<-EOT
      g\, DO-2K23-26:argocd\, role:admin
    EOT
  }

  set {
    name  = "configs.params.server\\.insecure"
    value = "true"
  }

  set {
    name  = "server.certificate.enabled"
    value = "true"
  }

  set {
    name  = "server.certificate.issuer.group"
    value = "cert-manager.io"
  }

  set {
    name  = "server.certificate.issuer.kind"
    value = "ClusterIssuer"
  }

  set {
    name  = "server.certificate.issuer.name"
    value = "letsencrypt-prod"
  }

  set {
    name  = "server.ingress.enabled"
    value = "true"
  }

  set {
    name  = "server.ingress.ingressClassName"
    value = "traefik"
  }

  set {
    name  = "server.ingress.tls"
    value = "true"
  }
}
