provider "kubernetes" {
  config_path = var.config-path
}
resource "kubernetes_namespace" "appns" {
  metadata {
    name = var.kube-namespace
  }
}

resource "kubernetes_deployment" "testapp" {
  metadata {
    name = "test-app"
    namespace = var.kube-namespace
    labels = {
      app = var.label-name
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = var.label-name
      }
    }

    template {
      metadata {
        labels = {
        app = var.label-name
        }
      }

      spec {
        container {
          image = var.image-name
          name  = "testapp"
          image_pull_policy = "IfNotPresent"
          port {
            container_port = var.container-port
          }

          security_context {
            run_as_user = 8087
            run_as_group = 8087
            run_as_non_root = true
            allow_privilege_escalation = false
          }


          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
          liveness_probe {
            exec { 
              command = ["curl", "http://localhost:${var.container-port}/healthcheck"]
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }

          readiness_probe {
            exec {
              command = ["curl", "http://localhost:${var.container-port}/healthcheck"]
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}
resource "kubernetes_service" "appservice" {
  metadata {
    name      = "testappservice"
    namespace = var.kube-namespace
  }
  spec {
    selector = {
      app = var.label-name 
    }
    type = "NodePort"
    port {
      node_port   = var.node-port
      port        = var.container-port
      target_port = var.container-port
    }
  }
}
