resource "kubernetes_namespace" "zipkin_system" {
  metadata {
    name   = "zipkin-system"
    labels = merge(local.namespace_labels)
  }
}

resource "helm_release" "zipkin" {
  name      = "zipkin"
  chart     = format("%s/charts/zipkin", path.module)
  namespace = kubernetes_namespace.zipkin_system.metadata.0.name
  wait      = true
  lint      = true

  values = [
    <<VALUES
ingress:
  host: zipkin.teste
VALUES
  ]
}
