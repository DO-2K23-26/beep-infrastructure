# resource "kubernetes_namespace" "gitlab-runner" {
#   metadata {
#     name = "gitlab-runner"
#   }
# }
#
# resource "kubectl_manifest" "runner-token" {
#   depends_on = [kubernetes_namespace.gitlab-runner]
#   yaml_body = <<YAML
# apiVersion: bitnami.com/v1alpha1
# kind: SealedSecret
# metadata:
#   creationTimestamp: null
#   name: runner-token
#   namespace: gitlab-runner
# spec:
#   encryptedData:
#     runner-token: ${var.gitlab_runner_token}
#     runner-registration-token: AgAFdYJsola+HLcv31c1H7OBW7PC9qCa7meaboE1Y5SA8IXpuuP99v/ozDah0m18FtPkLSIV65ELZb/erBc9P7tH+tytYWe5rYD8D6XVdCIsw0zOXem4dzF9BRjfL9FeGiuBDGnPP4b0BErapwxDR8Gr6kISrihUwaDSh8/wWbm8w/v34VFBmCQXWlAxbS6IPS9DcBLIF0ZJRwPvGKLktwdsSYpB9XS40GnfXeAsADXYkh12WvyJauhrqVHS+22C3oekef8g9iY4nd5BS2MfbxcImAwVL9lMQU4/xDbO6+DZRiwlhAm1quD2iHwwdMbx0Kc3ZrOpQqqp76agEgFjB5mcNQnrzCalnWsNSOfw1pMH0P4zec9FcQT0/x6Y3BDh8ourjfvRG9gnc9uP+1l0TPXfZ33mpmsyguisicJZ49HCADBaJ1yQJDUrcqqAbUl9AOozWHSlE3XpvQVda3wv1t3ZXKpE8OwZXvky19GhmlR4K5wLoN3UQCckG93c+i7fFrC4f+WXmzkU5QcERT5E6snvWRof5TUvP4EDJvf+TIGfF7+WsqW2IKutcCK0fvtxivY67jewpV42Qcj8ojP84VQL43jQ0i3UEQCYHxkHQRrDWZQ0MVl6UwBRPoxjR5QzuHvcpguFit2AmPsQFikQmiLLcK5zczGeq64+ewiutC8OO/OFYlczy5WWPXAyXWfUKoo=
#   template:
#     metadata:
#       creationTimestamp: null
#       name: runner-token
#       namespace: gitlab-runner
#     type: Opaque
# YAML
# }
#
# resource "helm_release" "gitlab-runner" {
#   depends_on       = [kubectl_manifest.runner-token]
#   name             = "gitlab-runner"
#   repository       = "https://charts.gitlab.io"
#   chart            = "gitlab-runner"
#   namespace        = "gitlab-runner"
#
#   set {
#     name  = "gitlabUrl"
#     value = "https://gitlab.polytech.umontpellier.fr/"
#   }
#   set {
#     name  = "runners.secret"
#     value = "runner-token"
#   }
#   set {
#     name  = "rbac.create"
#     value = "true"
#   }
#   set {
#     name  = "serviceAccount.create"
#     value = "true"
#   }
#   set_sensitive {
#     name  = "runners.config"
#     value = <<EOT
# [[runners]]
#   [runners.kubernetes]
#     namespace = "{{.Release.Namespace}}"
#     image = "alpine"
#     privileged = true
# EOT
#   }
# }
