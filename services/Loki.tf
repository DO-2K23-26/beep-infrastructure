resource "helm_release" "Loki" {
  depends_on = [kubernetes_namespace.monitoring]
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki-stack"
  name       = "loki"
  namespace  = kubernetes_namespace.monitoring.metadata.0.name

  values = [
    <<-EOF
      loki:
        schemaConfig:
          configs:
            - from: "2024-04-01"
              store: tsdb
              object_store: s3
              schema: v13
              index:
                prefix: loki_index_
                period: 24h
        ingester:
          chunk_encoding: snappy
        querier:
          max_concurrent: 2
        pattern_ingester:
          enabled: true
        limits_config:
          allow_structured_metadata: true
          volume_enabled: true

      deploymentMode: SimpleScalable

      backend:
        replicas: 1
      read:
        replicas: 1
      write:
        replicas: 1

      minio:
        enabled: true

      gateway:
        service:
          type: LoadBalancer
    EOF
  ]
}
