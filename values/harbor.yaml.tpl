expose:
  tls:
    enabled: true
    certSource: secret
    secret:
      secretName: harbor-tls
  ingress:
    hosts:
      core: registry.${domain_name}
    annotations:
      cert-manager.io/cluster-issuer: letsencrypt-prod

externalURL: https://registry.${domain_name}

database:
  type: external
  external:
    host: db-postgresql.harbor.svc.cluster.local
    username: postgres
    coreDatabase: registry
    existingSecret: db-postgresql

core:
  extraEnvVars:
    - name: CONFIG_OVERWRITE_JSON
      value: |
        {
          "auth_mode": "oidc_auth",
          "oidc_name": "GitHub",
          "oidc_endpoint": "https://github.com/login/oauth",
          "oidc_groups_claim": "beep",
          "oidc_admin_group": "beep",
          "oidc_client_id": "${gh_client_id_harbor}",
          "oidc_client_secret": "${gh_client_secret_harbor}",
          "oidc_scope": "openid,profile,email",
          "oidc_verify_cert": false,
          "oidc_auto_onboard": true
        }
