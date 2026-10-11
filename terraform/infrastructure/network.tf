resource "yandex_vpc_subnet" "main" {
  name           = "devops-diploma-subnet-a"
  zone           = var.zone
  network_id     = var.network_id
  v4_cidr_blocks = ["10.10.0.0/24"]
}

resource "yandex_vpc_subnet" "k8s_d" {
  name           = "devops-diploma-k8s-subnet-d"
  zone           = "ru-central1-d"
  network_id     = var.network_id
  v4_cidr_blocks = ["10.11.0.0/24"]
}

resource "yandex_vpc_security_group" "k8s" {
  name       = "devops-diploma-k8s-sg"
  network_id = var.network_id

  ingress {
    protocol       = "TCP"
    description    = "SSH"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "TCP"
    description = "Kubernetes API server"
    port        = 6443
    v4_cidr_blocks = [
      "10.10.0.0/24",
      "10.129.0.0/24",
      "10.11.0.0/24"
    ]
  }

  ingress {
    protocol    = "TCP"
    description = "Kubelet API"
    port        = 10250
    v4_cidr_blocks = [
      "10.10.0.0/24",
      "10.129.0.0/24",
      "10.11.0.0/24"
    ]
  }

  ingress {
    protocol    = "UDP"
    description = "Flannel VXLAN"
    port        = 8472
    v4_cidr_blocks = [
      "10.10.0.0/24",
      "10.129.0.0/24",
      "10.11.0.0/24"
    ]
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all outbound traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}