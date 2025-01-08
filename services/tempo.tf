resource "helm_release" "tempo" {
  depends_on = [kubernetes_namespace.monitoring]
  repository = "https://grafana.github.io/helm-charts"
  chart      = "tempo"
  name       = "tempo"
  namespace  = kubernetes_namespace.monitoring.metadata.0.name
}
