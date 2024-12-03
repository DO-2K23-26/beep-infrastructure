variable "kubeconfig" {
  type        = string
  description = "Path to the kubeconfig file"
  default     = "~/.kube/config"
}

variable "stunner_port" {
  type = number
  description = "The port that will be use by the stunner endpoint"
  default = 33436
}

variable "domain_name" {
  type        = string
  description = "Domaine name"
  default     = "duratm.com"
}

variable "gh_client_id_argocd" {
  type        = string
  description = "GitHub client ID for argocd"
}

variable "gh_client_secret_argocd" {
  type        = string
  description = "GitHub client secret for argocd"
}

variable "gitlab_runner_token" {
  type       = string
  description = "Gitlab runner token"
  default     = "AgACxIBp1I0MGwFalgg5T/zxd/00BwGrtb4up7nwSzuHOT67XaBkP57OK3ZxCzjp5AXT2hpdWAd6R28MKPh3kOXLdjfyBCQs/iRZQ0n9oRfHYjKUQXrWFGQZHZTdmdreaBQ3VG5EJzlKwB4oUKP6UkSa3eGPhs+SDVt71vCsYI4CxvmUOZpyTaAjhexceUwJ+7lC427TRWd4PcBVcybXgEj678Z0i0tDhu/m4JmZvqAP4rQNTepJxZZ+xdOIKQTk5bPR+AaVjGTJAlV46U85JlQr+57ISsO+/aWSUSs5xKNYNSOnqSggqYQYXnzu14kqn/rKhQy56B+WcQyT5HN7sW1za2tSnFUwjOlRRJB5XTWNxaMHmwavpUISjb8fuqINIvy91l73DchCUJrPZKt1Dd59tNfN7qltx69GctOS9S5Xh7ja/Aj91Q8363tbG7v2Qev0oo04lfPZktp3laLDx9RpIonxT2o9x5yl0PXpeMkiQ+YxhxiMjjF6DrPHg83watMlcVPk/gGrKo6qiIVxbRqa1xn0eTYBvOHsfUgEaQr6IBq++31lpdJ8IZKdr7VM1N8pLVkR1XsQc9VPaWahNsgtrDRbilX1gZoxZGNaVxuJ9j4dMobqQT+AiDEr0nn5LSaqCWMYmp3blv2HI561zHqSDgXgIanNFSB8pamme8a3i5kDF8t7SgL6VmCY2Y0hJ36bGsdXgZyD3Wg3BtHzRcK89ixKSa6bg7LK"
}
