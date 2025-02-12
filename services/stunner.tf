resource "helm_release" "stunner_gateway_operator" {
  name             = "stunner-gateway-operator"
  repository       = "https://l7mp.io/stunner"
  chart            = "stunner-gateway-operator"
  namespace        = "stunner-system"
  version          = "0.21.0"
  create_namespace = true
  set {
    name  = "stunnerGatewayOperator.dataplane.spec.hostNetwork"
    value = "false"
  }

  set {
    name  = "stunnerGatewayOperator.dataplane.spec.enableMetricsEndpoint"
    value = "true"
  }
}

output "stunner_deployed" {
  depends_on = [helm_release.stunner_gateway_operator]
  value      = true
}