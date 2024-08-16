resource "kubernetes_deployment" "nginx-deployment" {
  metadata {
    name = "nginx-deployment"
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      spec {
        affinity {
          node_affinity {
            required_during_scheduling_ignored_during_execution {
              node_selector_term {
                match_expressions {
                  key      = var.node_affinity_key
                  operator = "In"
                  values   = [var.node_affinity_value]
                }
              }
            }
          }
        }

        container {
          name  = "nginx"
          image = var.nginx_image

          volume_mount {
            name       = "nginx-config"
            mount_path = "/usr/share/nginx/html"
          }

          volume_mount {
            name       = "pod-info"
            mount_path = "/etc/podinfo"
          }

          command = ["/bin/sh"]

          args = [
            "-c",
            <<-EOT
            POD_IP=$(cat /etc/podinfo/pod_ip)
            echo "Pod IP: $POD_IP" > /usr/share/nginx/html/index.html
            exec nginx -g 'daemon off;'
            EOT
          ]
        }

        init_container {
          name  = "init-pod-ip"
          image = "busybox"

          command = ["/bin/sh", "-c"]

          args = [
            "echo $(hostname -i) > /etc/podinfo/pod_ip"
          ]

          volume_mount {
            name       = "pod-info"
            mount_path = "/etc/podinfo"
          }
        }

        volume {
          name = "nginx-config"
          empty_dir {}
        }

        volume {
          name = "pod-info"
          empty_dir {}
        }
      }
    }
  }
}