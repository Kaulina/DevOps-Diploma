variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}

variable "zone" {
  description = "Default availability zone"
  type        = string
  default     = "ru-central1-a"
}

variable "network_id" {
  description = "Existing Yandex Cloud VPC network ID"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key for VM access"
  type        = string
}

variable "k8s_worker_b_subnet_id" {
  description = "Existing subnet ID for Kubernetes worker in ru-central1-b"
  type        = string
}

variable "ansible_ssh_public_key" {
  description = "SSH public key for Ansible access from VM A"
  type        = string
}