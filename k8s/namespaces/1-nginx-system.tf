resource "kubernetes_namespace" "nginx_system" {
  metadata {
    name = "nginx-system"
    labels = merge(local.namespace_labels, {
      cert-manager-tls = "true"
    })
  }
}

resource "helm_release" "nginx_system" {
  name      = "nginx-ingress"
  chart     = "https://raw.githubusercontent.com/ronaldmiranda/helm_charts/main/ingress-nginx-3.31.0.tgz"
  namespace = kubernetes_namespace.nginx_system.metadata.0.name
  wait      = true
  lint      = true

  values = [
    templatefile(
      format("%s/charts/nginx-system/values.yaml", path.module), {
        NAMESPACE = kubernetes_namespace.nginx_system.metadata.0.name
      })
  ]
}
