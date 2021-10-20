resource "kubernetes_namespace" "microservice_ns" {
  metadata {
    name   = "microservice-ns"
    labels = merge(local.namespace_labels)
  }
}

resource "random_password" "pw" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "kubernetes_secret" "token" {
  metadata {
    name      = "jwt-secret"
    namespace = kubernetes_namespace.microservice_ns.metadata[0].name
  }
  data = {
    "token" = random_password.pw.result
  }
}

resource "helm_release" "redis" {
  name       = "redis"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
  namespace  = kubernetes_namespace.microservice_ns.metadata.0.name
  wait       = true
  lint       = true

  set {
    name  = "architecture"
    value = "standalone"
  }

  set {
    name  = "auth.enabled"
    value = "false"
  }

  lifecycle {
    ignore_changes = [
      metadata
    ]
  }
}
