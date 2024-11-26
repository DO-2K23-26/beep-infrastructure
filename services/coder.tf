resource "kubernetes_namespace" "coder" {
  metadata {
    name = "coder"
  }
}

resource "kubernetes_config_map" "coder-env" {
  metadata {
    name      = "coder-env"
    namespace = "coder"
  }
  data = {
    CODER_ACCESS_URL          = "https://coder.${var.domain_name}"
    CODER_WILDCARD_ACCESS_URL = "*.coder.${var.domain_name}"
  }
}

resource "kubectl_manifest" "coder-env" {
  depends_on = [kubernetes_namespace.coder]
  yaml_body  = <<YAML
apiVersion: bitnami.com/v1alpha1
kind: SealedSecret
metadata:
  name: coder-env
  namespace: coder
spec:
  encryptedData:
    CODER_OAUTH2_GITHUB_ALLOW_SIGNUPS: AgCyGiIDZUunH59oT4vZ8e9sv5CKOsgOuUzOKfo6eBvpuNOmhlUHRP2SBNIWDHxPubNRF5FmX8/zFYUBz6bFQwvgMrqiAvTIWuidjmjckqR31FtgYp/C4DEiOMlwat49qwoXicvSA5MWgpm4DUYY6UuNwbb392/IOvyO67X8Pj5Cu/n8IEZUYQ9UKqn0LE7l6Itq3XaBYPAJs08Pl/zo+juHb8BeZp9F4Kwdqw+GyrqE1fvQGtdmyJ6Fo1/ffMQ28kbRAPeB1ebrxcGBx8CEhUmbieKMgeLEatCPcgyNq3zphpWxx2TKFI8NzAL4SRknb670W7r6B/iLKc/IAla3ExPAr+94YZ1td+0dWwMir0r1/zv0/cUqazYB2X5Sdt5h8NmjfUw5tLexJI1JKAErVkqC0qLpcRAjTxe+eEH2sSwQ5jhtC/Clnigj50z6Oa4UQ0sm+BqpjNcxb/RXeEgVUPdS7boukYzGKiYIGt0n8k6i3pCUlQjQdwyEVidGj75may5mUBd4CFkDBAxxfYbMuK8ftuO/GMT3CmQna/zbEtIYzMEz07AHchz6DS0n1TlmWCkzykKDw3zVk8B+2kQCMH551bIHaH6harnwFLFtn1yf0jyLbYkUwogsERR5RxwHf6/ppQF88sUFKmrsdduWaPgd/4+SI1hIk86xS40UIE7CfrGp9FXZr447ruxNNKcLOIHgIkn3
    CODER_OAUTH2_GITHUB_ALLOWED_ORGS: AgBokO1QevfhS0h/AZp5UUFlKQZlk26hXIbsZ2O1iqZ8jsAoh0/yNGpCDhsfPc64CG+/aYU2rK2cEUjwRbgITvOkery/qCyduV9al4YuvGwftyoWSId96v844v7FCJ1uuvfHpXkbUMiIxLK5JgHD0tVuz/bAYPAvodRmrjxxz4vX9oXBFziTgqTykBb3vlVPPkIo99CHsbVXqFX2Xw4LwW/bOIgD4oAz5YoGaGwO/zDyljGB+jfHpnRAMnK/7joFwTnWY5ahnMQvkVgbPSSyqo9HG0fNQg7lELBowCs6Us5d5v7GJcyuJ7uUAqlDU4Ekmfl98vzb/b7bsVhZBAxWlAZ27hD1NJkQSGgljO5i6u8MuUt40AfBATL398cYvpsjPiY+SuH/ooxpk8n3Nsdw2D2X3kX/nCmXlNYC2xpv1ZdGR96DzZ1g7J9yPj/q29gcqP7J3kbK1saaFaxNE8qictQUDsvfa5F2EbcUUSQygNiXwCAr3t4bM4H17zi1260LoiI+t9Yx+rCPot3vGpZQqkE6yjnsoCl8C5KUXT6vv3edhiElnEw8XcorCPwGtnsrObNvChOE+1xUvLFb+etIYl90hoeAkW12fPwrGRLWIGldc0sRZMjHRZhs92TjURMvF+egx2rMlqzD26GeAsE/yRnQhjYQwjFeTr1uUurRBhSFJTGaPeTjyPEEkr7IA+XTWT8Szu4v0ZHMjyVe
    CODER_OAUTH2_GITHUB_CLIENT_ID: AgAXI8GEAHpYm9mdoe1EjW6EaingQNay5DEp2Ko+eFEdqJpEl3PUW0fXiaD27JRiCcGodVirXjq3crHJral31ZUJywddIjF/IRJmOaigV4P1LjBj7f3bZJa3CGy17jyGu2sO6U5rRqZSoBUtupMOb/hrvRzcYF9OsuZo9T3ITUAoaNh0HT0om7XaKliIAJSI9KfvfTeVNCREKB2uv1ZRXiiTT7/9Q6y59ZnrD2KZHjk1YwOT/gA7tdUr/mC7/fyIVG7KTz8An4//1Qoo9diu1fCX7W4r4+tSM8lsTsMgGxXzwHrVhuDgJEovoK2Ayup/o77iVAYdOh8bAO3lE4TNKC1r32miFdli4RZ/75L6Kwuu/+0vzfYzYQAKrZCBgSFJNw+HpbAobtP9vebS2jS4VcBsIleap3xOxmPp/vyFCLdZdS22JG2hrc9WojzQ1tvE+0InOmb2HBZv5PS4A91icIG2/rjT3W2OyChQkD/eTy2U2AB4OWaFAOkPj5QAcORWI2ZFvswUeg848bSzClxnZonQbne9fqKtq//i5oV6aMLocOs0BY0kZyC0tvqToAvtzbV3NrVu4XaePjeVrYPJteT69IatUS9+TSwdssYKAJ7IWK9spMdHCE5WMIt2aL74fQIr0YbXoFSZKPdWZ0DWKFk9RDI1SkLVqtdhez/Fq/UEhT0HsaSj8rFL5y61Me8UCpXuLXz0eJCGNbOO4lf4p0dOG2Qviw==
    CODER_OAUTH2_GITHUB_CLIENT_SECRET: AgBFWDdlFZNkmqX2EMXGo3FFwYy71nRSoJe5Ad8GT5jhH8Z8Ic7oWgngZpLjqvcpYnJ9qQH5R6bSRfRzhDkZ9IdQ1eH0J4IDwXiyjCwvuuar2xO9JrM3J7G6Vm90K2aID1AZMJmgvwAQMSLa7Kjl6SJMc6OYO0001RbvZAgSay4wE6qbzuwIq8BLYpbUSg3+CmltGFfV8RcRRLr8D76HnqqB+xx1FoFfqNNDViF9VUCe16vLslA/5gQyxlXn4s07RV494EviC/6shNizmcnE98Rrov00LwdwwICVy6sAn+ccWoXi9B/ziVZ6sBeEu06kBUdplGRmLcRWcvMaRjkqZD8VqJrZ27fdjKcoikJ3p/kY8WB/JBHVZSN5XYXSuF6wHJobA52bxz+kcJZAKOXa5kXdaNXAeKGjzrTycSep4v/pMm+DSXJPsvUuorJeftNogI6fMcPPA6JSWnSU1S1Zz4HcDE6Nn1jpd0h5AGvhRwjz9ZIubNuivFksHuWkqVoXYImgD0HuD36+Caa2/D4ofFOKzF07Yn38e2iRiJyMnLdLQ57VEGIZ/gKTuJo+wq6Ng7v8VmrBDbu01X8BcRd2hJaE9jZzvzlZfhzjCM+RSm2TU3Ae5mWOJEvt1q5CGFm1wPXWwyps4n5s6+u7h+cDJBMyAzKmWuMinlhQPVPjGpeSI0JXOAFyWxUZhI7j+bKb4UEQaC3mdbkiCYGPjyxIm88CIW9x4nqulNyhEPwfyztD0Pl3oA8M4Gma
    CODER_PG_CONNECTION_URL: AgBITaRla5BVdlY1YGwyGdQ3k2Gmco7SBVbUdPixVq5fvj7lGDgqGRRukGN5xvSF17pZB1SbLEIAWUJsIjVc/oQcCzMyZESdwiv5VLyPO54XIwv3DpwXVzyXRJqgtW6nLtx/JQrCX8UvNp8ASLdApTI+f5j4YRePnpPTvCgGSTeMKm+GIzXv3OFMwsjDamZUaKgvMS9P/Ux6Dw/TxB6Y4mWMhEA9w5haYU8VBDvNSaEVh54w4vCEA7HWfXO25d1Dww1tQhy9idDxPeYYStbepf/wWA9pve1/si14vmZhyU1Un0eyR7c5jqr1d4RcxO38FwjPL9BHcwvugd+iVwfMRfZifDqqT+b7pJBlO8LRxYzwUrxKLIBDFmF1KNcVCyAY7gY7s+l6WWBb8U1RazqTgsa1L7nSeGRJM8hwVmNXLn50rf6bSpqJeCPils6J6OUkxvEP2/9z69+NdTa92Jd6hvQ4poeLvDYgT1yR9LdLMi5hsPdgz7c/GA8IudaHw+ANnXyxkaFK/Momn3iaIhtYC5AFFpvrCz5xPeop+i9QMYUlxTZnKlg2INS5xrd2rWhj0Q3hukgzhu3uBJHKGTniG785zrbBO7oJvLfUOZdlgbyJA/dinXXve16jkqsCcEeVzMaZXPM8BA1kVEKDkyRbG70qtCXKYt88rBMN+rZRL64NfY62gwRvqU0F03hXBVyoVlj/BWGasa8IuQy7rG4MwUh0KaYXEVnIKGG5Hi7Op/YirCWZn1w9ghFsUul36vFuGT7HNbgtTejKxJv1TEkNqsAGh8rsQ3+hSgH/HpNOPZPvX/UTDGg/Gh2Pms+hMe8bbbSrZmjXfAl88DcirmidXANc
  template:
    metadata:
      name: coder-env
      namespace: coder
    type: Opaque
YAML
}

resource "kubectl_manifest" "postgres-users-passwords" {
  depends_on = [kubernetes_namespace.coder]
  yaml_body  = <<YAML
apiVersion: bitnami.com/v1alpha1
kind: SealedSecret
metadata:
  name: postgres-users-passwords
  namespace: coder
spec:
  encryptedData:
    password: AgAWI8pBt6EM5yLTlAokUgYCOG1jxGIuVCM+gIvk9Cqb+CGhTCPzG6/R9sn+x00XY5WbnSuAUQH5+Z/wtVRsyi4v/PiB+V9Ozv+CsQsmigbA+tufe8LUVs1zG1fgeuKspCLRsVlJ5m0/JIOC1XDyPrY77q1PQdWnKnvCnHN/PEjnoufNCwkpuJHHQZ+6ekdt6j4OTLl1Q+MIexy7mEOhVXh1T8fmkTiZti32x6yK6wV+yRx5D1jieAcXqJwqt7+De3r4+v2LYLRRiew7aprBfgjRuQcf3KTgp3Tgz/FP5xSLgtorwceTZ9OjLV/5LUqL6oK0CFnlVX0bRNq2hQ97ptBV+/5Upnb4VZXuM69KHTev4IzsIYU2N7Pb4JUSVIWqMpA83ltcDPPiQCDfzYD/ZhyjTni1VWbScNe7QGrqyBx/grYqBgHfG2Z1f2KczL5BpnRDgHrChLVEeuI9ImrlLdDJhCDPHNNgDWBbzUCBa3CbK8ILDdFhUzyyM/Is7QfP8QKKTXAjyRbedmZgY5TXF5tzAaCEevmWBoq2TcVuFgqEMyrnV6bDrJi7rTUFFpQdyMi3g4l7vpSKCQK4xu8Wz5xxCb1ba3xvTYTWVZrY7wYx2fcrqd1ngChueOX50LNpT4kJh19FA47kPT4zvtLE0zjb/kzuSUsh/RhCWK5RjJ0LHBDQ27hHASwL0AiI8xteFbQ7jO8TD1eA0AJuoV1saBeit+bpjLcujFAqDmrJPm8=
    postgres-password: AgAuSEdPUZ1czAzAF/bMTi0ucG41/uI8JYzsj5PbLvuGV0ulpr6lyHNMAJc/+rLDNWRNTOBcPswGXO1wu8l4DBigUqpIp6OM3l0DrXkXl3vkyhHFXDfcvjVhJjFtrV4DNbhXWTh8luvOMtAVA5gzOZwTig1vlNT5Mfbtg79R8QbUJ9NbSCmZ2jWKER9mANYHyNZuxxVupNXnF/5DqhT2A4Lh8YVODlwJWVNPNi3W2iF8KkaeHae+1R3Y3WHciTBjTV/RU2r832o5CoGgWUMxxq58PRb10B/BV5kcVM6XcwrKXQNuEH5ljepMmGsIwTPUcncKBk9gSgigI/OmkuSYHSst3p8zygHgKoKwyTthsyiGE05L2HBmowS5511JM+y/W9xZvci1fl/QxBej1BLcGIh9w4iqGG031CJLdtiUj4GxLqx7CjYVpYCrFJUOxiUTKRgJxXV/lfG0Ol2qfclng8KQBY0t4BrW9KnOlMz5z05lChWEUKtyVUpp7/Y9ZowMZ2H5FthU9wsq5s6htPvK6fR4kX7rD0tmwlNRIegWBpWvZhqFAdK1n/H37IU1ReurzjNdzbQVBIs7U4sQ/jjO8OKveQL30UqUhrMfXWHrPHbOi+3cZ+TC+2diEBQfrF9XPQZ+NfL5u8jF4goB94w3i6btfYDIMGYA892njOHy8sNbvJnmNmmkzvPXLc5n9bAvqk7pJawustO7HKxoRN1HshJaCGvM59WQ7FYoyEmIDEyUlDFCnLe8s1C5QGQpinUBgKOSubo=
  template:
    metadata:
      name: postgres-users-passwords
      namespace: coder
    type: Opaque
YAML
}

resource "helm_release" "postgres-coder" {
  depends_on = [kubectl_manifest.postgres-users-passwords]
  name       = "db"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  namespace  = "coder"
  version    = "15.5.28"

  set {
    name  = "auth.enablePostgresUser"
    value = "true"
  }

  set {
    name  = "auth.existingSecret"
    value = "postgres-users-passwords"
  }

  set {
    name  = "auth.username"
    value = "coder"
  }

  set {
    name  = "auth.database"
    value = "coder"
  }

  set {
    name  = "auth.secretKeys.adminPasswordKey"
    value = "postgres-password"
  }

  set {
    name  = "auth.secretKeys.userPasswordKey"
    value = "password"
  }

}

resource "helm_release" "coder" {
  depends_on = [helm_release.postgres-coder, kubectl_manifest.clusterissuer_letsencrypt_prod, kubectl_manifest.coder-env, kubernetes_config_map.coder-env]
  name       = "coder"
  repository = "https://helm.coder.com/v2"
  chart      = "coder"
  namespace  = "coder"

  set {
    name  = "coder.envFrom[0].configMapRef.name"
    value = "coder-env"
  }

  set {
    name  = "coder.envFrom[1].secretRef.name"
    value = "coder-env"
  }

  set {
    name  = "coder.envUseClusterAccessURL"
    value = "false"
  }

  set {
    name  = "coder.service.type"
    value = "ClusterIP"
  }

  set {
    name  = "coder.ingress.enable"
    value = "true"
  }

  set {
    name  = "coder.ingress.className"
    value = "traefik"
  }

  set {
    name  = "coder.ingress.host"
    value = "coder.beep.ovh"
  }

  set {
    name  = "coder.ingress.wildcardHost"
    value = "*.coder.beep.ovh"
  }

  set {
    name  = "coder.ingress.annotations.cert-manager\\.io/cluster-issuer"
    value = "letsencrypt-prod"
  }

  set {
    name  = "coder.ingress.tls.enable"
    value = "true"
  }

  set {
    name  = "coder.ingress.tls.secretName"
    value = "coder-tls"
  }

  set {
    name  = "coder.ingress.tls.wildcardSecretName"
    value = "wildcard-coder-tls"
  }
}
