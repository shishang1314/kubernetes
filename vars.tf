# variables.tf

variable "nginx_image" {
  description = "The Docker image to use for the Nginx container"
  type        = string
  default     = "nginx:latest"
}

variable "nginx_port" {
  description = "Port for the Nginx service"
  type        = number
  default     = 80
}

variable "node_port" {
  description = "Node port for the Nginx service"
  type        = number
  default     = 30007
}

variable "replicas" {
  description = "Number of replicas for the Nginx deployment"
  type        = number
  default     = 2
}

variable "node_affinity_key" {
  description = "Key for node affinity"
  type        = string
  default     = "app"
}

variable "node_affinity_value" {
  description = "Value for node affinity"
  type        = string
  default     = "nginx"
}