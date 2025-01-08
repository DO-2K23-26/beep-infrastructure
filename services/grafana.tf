resource "kubectl_manifest" "auth-github-oauth-secret" {
  depends_on = [kubernetes_namespace.monitoring]
  yaml_body  = <<YAML
apiVersion: bitnami.com/v1alpha1
kind: SealedSecret
metadata:
  name: auth-github-oauth-secret
  namespace: monitoring
spec:
  encryptedData:
    client_id: AgCyDiGQR1EeHUJKeRqztKQyqGTLAuTXHGftEZW0T1CO3UYFqZzRZ5ivmYmg+Y/B6/8ERLKL94es5w0umP0Ao1TV1/7umhbMhdOBPpStRjOX11irpVhBqsr8hSB7HVOA3njtTFGCyyZlg/9Xqffn6s9LUFOM3SFk7svaLxUFuIRBWazG3D+lefWteOu7Tzg8MbunMwo0A9Q/xZYeQ+AN1Sjuc2cxAXHSc69hmgJbQizIl2rro+61hO1C1++I42+J82ATOoNDyK2p9KutK7MENQQnOv9mP16X+SXaq8BWduoctFa+4G5u4PSjATXveLtLKENajULXN+VZLkUngN0mWJu4oBMCl4sZjesiFkEQDI2Kpu7ZZfIyfMDlcJVNMiJ7M32cvBfNRgq+ibVTTfxuRZ+ysAAPlvqDEiwZa8nYfWe5+CESQmcfaQ6bUkp2rhkmHaFsqcBsLxXPLQ3eIOsnXnzG7SvMj7rMnrGnSZ7ImN+tKyz7i5vpFDAfQTfZXsGnvMqkoJPqe9aFjbYty0+ikJLZAjCBojM9VSZCJRXkeZsX8WMhzKc0FRwD2c5H+wmqEg/doZXQIFmTLP+QIa9zNNS0QKMHMlTigXIBeZtnwazkNJUZWvbSIDGFeRhnrMqf/rKgLNYoo5aWabS9798XqOpS1WXiyjCE1LBOsi+EaIl0KUctrv8LzzX9C7QoP8NULwGZdxOI/FMUqOLecwBhRG4GQ2h0/w==
    client_secret: AgCMVb0EaM2x0nMzms80CL5pNYVqZOBNbmc9Xlmgm0puvbJ5GlY3tBwmo101CRjTvGT5U/LDUwEETE8xS9cMUcprSNeNGsozN4KOagprY0FygKNNgLrHb4stuDH8SRFhAKpulKV9cki40ZsjmWEs5LIgRib3JGvBdB4Y1qYAXr9KcTAimuH/y7Ht2Vjlgu3I0Tav/5AeNp7kYqJckXskrtXDQwMqkv1ocBCExgGP017nxJWi7hCfrnWf514trE/4DE3YvUw8r9kA4W33qztgAF63qkBr4R8C3S9xw7EXAGS13wkCkfhykkFXWwSYMeuZTWmjPGmqxyFamJMWXrzHTP7/OBj6cWqDjMwbB+V6JD8jm1Awq7fAGBcjmiWT6W3sb6fINch/g78wysHBAWDOd1W0bbHtVsG6rHdrkClim9tUZvHA03VCydQEWDuDzLPGhAQJ9SM3BlaE1Yq7b5vrnnbUlwEOMPkFmmTvWbYYQwyTDgnm8FrP7bKAVyucckFeuC3GPkMLt52wXCTYubcbICntsPpQz2KarTOdcOuFEjm+8ki4o1nj1s/IKmf5ee1HZ31i4kym6/yIclznwngOHHsr4VrVkIhGQXSxUfK4cNRR5mzO/uWPiEZNjeDWG4hfdIjfHozjGdqldh76g/osCE4GpiK8HUq+q8VECtPn7XNDG6mDeK5y4/8s0jHIEgfbEZj9UPlOjGX1KAkt7qc8cdQauS3hddeDZg01sEp7llr+lXp9eRrTxDR1
  template:
    metadata:
      name: auth-github-oauth-secret
      namespace: monitoring
    type: Opaque
YAML
}

resource "kubectl_manifest" "grafana-admin-user" {
  depends_on = [kubernetes_namespace.monitoring]
  yaml_body  = <<YAML
apiVersion: bitnami.com/v1alpha1
kind: SealedSecret
metadata:
  name: grafana-admin-user
  namespace: monitoring
spec:
  encryptedData:
    admin-password: AgAd0iObaT7BwlehKy/h64voK53egKM6xBSbeG5fI4wiuG0xhGtXppBBJXGBnln2WIdfX2b2NoMIgxJbrcx/x4i+Av218RvjUYR00R6B+F6wChw+SOrseIfhFpGw23Fr1NtusoKGMpQ2gQC3L0fuZWVt6WTq3qtHpt8ghaCeUjGVwhQ00DmNQY9t2tetUvETp39kqegZOyyIeEc3aMbvSvzKHvmsNH6jF+Vc/3ynl7iv8qcfxPfNOu7vN1viqjCcfmxs/ageWOQ7PIOnjc42DeFcvL7u/WqNBqvNGKQaXsu8pFRh3z/TcQhJFsTbxVnpW7hRls7BPk0wpRPj++mMNaUkWndNGympTnv/KYU1SwbyFTeX0iRtuERgmRfcVrmJqYPamKd2ep42v3eskLsHf9cWXebg+5Om7qkUAhdfs8+58Ivwk4aUKX8DtbXF+7KQO5dN4s+0dg1bGpU/MRbhafcx2tCKowVmTI1R5ly4T7EhJ5Ch8Evo0cLRYnqhxxWxClJQ6ky4vCO9UDsDv0b3iceqsihJoKlX4QyCSZeBPiG1N2qDicDzIoorAtDrfmO3kA1mKvSd0PsSXCBF9vzRG4OGy2nE8E6XcC9M0KIrLYOZipD6rfjlARaefhzTU9ka8EyR7nL/6r43YBjD0ZOSSAztvYgQwh0ktGHCYxY1FEOuID3esmcE8nPIESHgkKXeMF3CdBs+qHr6qFuW2vV4N29d0LVZjM+5m+g4PM2XerOheA==
    admin-user: AgCP5OMmOcTfp3Er446GS/K9iOVaMd4jv4kib84YYADkV91nRav52ZDew2LZFbQI8kmUEEjNBpN1eoN70mpWbnvTQs5xAiRKxtdEiuXst9TMDdmaZQgf2p/hFtqmi9Yvb36M04tKyvtQ+UJAhxx4HYJjN9+evmBrtKRTesuxgJFWjZe+msaKLuzvkUbMCYqLHhp/5UrJ4aByjfNAGKIqOJALNbjA6nlhn9atqvJ3n6D7w7YHWwq95M6QbfND1f6WUK5M5xxOLzrHNiv7A5ZBxjRleeoTPjJUM+HmsJdH4y0CjRBobGG79X1e4HjJQL/52KXqw1lM4YPSLx+Ubnqp1t2CljXaBgBtm4wv4NzjaXUXGFRfeJG2OvApzlYxEuTYzdAoF4CSPkZ9sONznJXHWSJzs4W8kloslk6wSUa5FHNm3706tM03UGqqEdd/lyhSt5PRh+twUsPU84ZRfkqSV9kS4Y3O0gCMVlSDmxviJVQzHtBBSysnEZbq6ELwu8aZceEBOWcsHl64RaxRnvU4Q0UjveCGB7LE7Yap5axrMyrk/Kl2++3prilq0KdRWaqWhLG9d/9jI5gYojBfpLFnqHKosEfipV9+Oob/QcyUqFtmnV9varP0WhCsXT5fT0K8sShgzcuLOUUbSfDLeconXi3jeQsDHHz18m5xH5TFYMQOlbDWqjd+3udweFKTWSH0NurZLhapew==
  template:
    metadata:
      name: grafana-admin-user
      namespace: monitoring
    type: Opaque
YAML
}

resource "helm_release" "grafana" {
  depends_on = [kubernetes_namespace.monitoring, kubectl_manifest.auth-github-oauth-secret, kubectl_manifest.grafana-admin-user]
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  name       = "grafana"
  namespace  = kubernetes_namespace.monitoring.metadata.0.name

  values = [
    <<-EOF
      ingress:
        enabled: true
        annotations:
          {
            spec.ingressClassName: traefik,
            cert-manager.io/cluster-issuer: letsencrypt-prod,
          }
        hosts:
          - grafana.beep.ovh
        tls:
          - secretName: grafana-tls
            hosts:
              - grafana.beep.ovh

      admin:
        existingSecret: "grafana-admin-user"
        userKey: admin-user
        passwordKey: admin-password

      persistence:
        type: pvc
        enabled: true

      grafana.ini:
        server:
          root_url: https://grafana.beep.ovh/
        auth.github:
          enabled: true
          allow_sign_up: true
          scopes: user:email,read:org
          auth_url: https://github.com/login/oauth/authorize
          token_url: https://github.com/login/oauth/access_token
          api_url: https://api.github.com/user
          team_ids: null
          allowed_organizations: DO-2K23-26
          client_id: $__file{/etc/secrets/auth_github_oauth_secret/client_id}
          client_secret: $__file{/etc/secrets/auth_github_oauth_secret/client_secret}
          role_attribute_path: >-
            contains(groups[*], '@org/admin') && 'Admin' ||
            contains(groups[*], '@org/backend') && 'Editor' || 'Viewer'
          role_attribute_strict: false
          allow_assign_grafana_admin: false
          skip_org_role_sync: false

      extraSecretMounts:
        - name: auth-github-oauth-secret
          secretName: auth-github-oauth-secret
          defaultMode: 0440
          mountPath: /etc/secrets/auth_github_oauth_secret
          readOnly: true
    EOF
  ]
}
