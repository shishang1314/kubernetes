

resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  version    = "15.1.0"

  values = [
    file("prometheus_values.yml")
  ]
}

resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  version    = "6.59.0"

  values = [
    file("grafana_values.yml")
  ]
}

resource "helm_release" "alertmanager" {
  name       = "alertmanager"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "alertmanager"
  version    = "0.23.0"

  values = [
    file("alertmanager_values.yml")
  ]
}
