variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-2"
}

variable "cluster_name" {
  description = "Cluster name"
  type        = string
  default     = "minimal-eks-cluster"
}
