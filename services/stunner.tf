resource "kubernetes_namespace" "stunner_system" {
  metadata {
    name = "stunner-system"
  }
}

resource "kubernetes_manifest" "stunner_gateway_operator" {
  depends_on = [kubernetes_namespace.stunner_system, helm_release.argocd]
  manifest = {
    "apiVersion" = "argoproj.io/v1alpha1"
    "kind"       = "Application"
    "metadata" = {
      "name"      = "stunner-gateway-operator"
      "namespace" = "argocd"
    }
    "spec" = {
      "destination" = {
        "name"      = ""
        "namespace" = "stunner-system"
        "server"    = "https://kubernetes.default.svc"
      }
      "source" = {
        "path"            = ""
        "repoURL"         = "https://l7mp.io/stunner"
        "targetRevision"  = "0.21.0"
        "chart"           = "stunner-gateway-operator"
        "helm" = {
          "values" = <<-EOT
          stunnerGatewayOperator:
            dataplane:
              spec:
                hostNetwork: false
                enableMetricsEndpoint: true
          EOT
        }
      }
      "project"    = "default"
      "syncPolicy" = {
        "automated" = {
          "prune"    = true
          "selfHeal" = true
        }
        "syncOptions" = [
          "CreateNamespace=true",
          "ServerSideApply=true"
        ]
      }
    }
  }
}

output "stunner_deployed" {
  depends_on = [kubernetes_manifest.stunner_gateway_operator]
  value = true
}
