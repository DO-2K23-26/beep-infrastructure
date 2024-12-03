terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.15.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.4.4"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = var.kubeconfig
  }
}

provider "kubectl" {
  config_path = var.kubeconfig
}

provider "kubernetes" {
  config_path = var.kubeconfig
}
