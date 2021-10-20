# # helm repo add jenkinsci https://charts.jenkins.io

resource "kubernetes_namespace" "argo_cd" {
  metadata {
    name = "argocd"
    labels = merge(local.namespace_labels, {
      cert-manager-tls = "true"
    })
  }
}

resource "helm_release" "argo_cd" {
  name      = "argocd"
  chart     = "https://github.com/argoproj/argo-helm/releases/download/argo-cd-3.25.0/argo-cd-3.25.0.tgz"
  namespace = kubernetes_namespace.argo_cd.metadata.0.name
  wait      = true
  lint      = true

  values = [
    file(format("%s/charts/argocd/values.yaml", path.module))
  ]

  lifecycle {
    ignore_changes = [
      values,
      metadata
    ]
  }
}
