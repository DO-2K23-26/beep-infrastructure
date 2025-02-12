resource "kubernetes_namespace" "stunner" {
  metadata {
    name = "stunner"
  }
}

resource "kubernetes_manifest" "stunner_gateway_class" {
  depends_on = [kubernetes_namespace.stunner]
  manifest = {
    "apiVersion" = "gateway.networking.k8s.io/v1"
    "kind"       = "GatewayClass"
    "metadata" = {
      "name" = "stunner-gatewayclass"
    }
    "spec" = {
      "controllerName" = "stunner.l7mp.io/gateway-operator"
      "parametersRef" = {
        "group"     = "stunner.l7mp.io"
        "kind"      = "GatewayConfig"
        "name"      = "stunner-gatewayconfig"
        "namespace" = "stunner"
      }
      "description" = "STUNner is a WebRTC ingress gateway for Kubernetes"
    }
  }
}

resource "kubernetes_manifest" "stunner_gateway_config" {
  depends_on = [kubernetes_manifest.stunner_gateway_class]
  manifest = {
    "apiVersion" = "stunner.l7mp.io/v1"
    "kind"       = "GatewayConfig"
    "metadata" = {
      "name"      = "stunner-gatewayconfig"
      "namespace" = "stunner"
    }
    "spec" = {
      "realm"    = "stunner.l7mp.io"
      //change auth type to use beep backend
      "authType" = "static"
      "userName" = "user-1"
      "password" = "pass-1"
    }
  }
}

resource "kubernetes_manifest" "udp_gateway" {
  depends_on = [kubernetes_manifest.stunner_gateway_config]
  manifest = {
    "apiVersion" = "gateway.networking.k8s.io/v1"
    "kind"       = "Gateway"
    "metadata" = {
      "name"      = "udp-gateway"
      "namespace" = "stunner"
    }
    "spec" = {
      "gatewayClassName" = "stunner-gatewayclass"
      "listeners" = [
        {
          "name"     = "udp-listener"
          "port"     = var.stunner_port
          "protocol" = "TURN-UDP"
        }
      ]
    }
  }
}