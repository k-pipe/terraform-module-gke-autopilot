////////////////////////////
// Using google provider  //
////////////////////////////

data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${google_container_cluster.k8s-cluster.endpoint}"
  cluster_ca_certificate = base64decode(google_container_cluster.k8s-cluster.master_auth[0].cluster_ca_certificate)
  token                  = data.google_client_config.default.access_token
}

provider "helm" {
  kubernetes {
      host                   = "https://${google_container_cluster.k8s-cluster.endpoint}"
      cluster_ca_certificate = base64decode(google_container_cluster.k8s-cluster.master_auth[0].cluster_ca_certificate)
      token                  = data.google_client_config.default.access_token
  }
}

provider "kubectl" {
  load_config_file       = false
  host                   = "https://${google_container_cluster.k8s-cluster.endpoint}"
  cluster_ca_certificate = base64decode(google_container_cluster.k8s-cluster.master_auth[0].cluster_ca_certificate)
  token                  = data.google_client_config.default.access_token
}

terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.25.2"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.17.0"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}
