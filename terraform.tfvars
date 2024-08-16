# terraform.tfvars

nginx_image = "nginx:latest"
nginx_port  = 80
node_port   = 30001
replicas    = 2
node_affinity_key   = "app"
node_affinity_value = "nginx"