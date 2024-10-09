resource "kubernetes_manifest" "streaming_entrypoint" {
  manifest = {
    "apiVersion" = "helm.cattle.io/v1"
    "kind"       = "HelmChartConfig"
    "metadata" = {
      "name"      = "traefik"
      "namespace" = "kube-system"
    }
    "spec" = {
      "valuesContent" = <<-EOT
      additionalArguments:
        - "--entrypoints.stream.address=:5060/udp"
        - "--entrypoints.stream1.address=:33434/udp"
      ports:
        stream:
          port: 5060
          expose: true
          exposedPort: 5060
          protocol: UDP
        stream1:
          port: 33434
          expose: true
          exposedPort: 33434
          protocol: UDP
      
                                 
      EOT
    }
  }
}
