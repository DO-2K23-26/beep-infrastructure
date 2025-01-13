resource "kubectl_manifest" "traefik-middleware" {
  yaml_body = <<YAML
apiVersion: traefik.containo.us/v1alpha1
kind: Middleware
metadata:
  name: redirectscheme-https
  namespace: kube-system
spec:
  redirectScheme:
    scheme: https
    permanent: true
YAML
}
