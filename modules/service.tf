resource "kubernetes_service" "service" {
  metadata {
    name = "nginx-service"
  }

  spec {
    selector = {
      app = "nginx"
    }

    type = "NodePort"

    port {
      protocol    = "TCP"
      port        = var.nginx_port
      target_port = var.nginx_port
      node_port   = var.node_port
    }
  }
}