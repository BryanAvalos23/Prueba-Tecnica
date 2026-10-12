aws_region   = "us-east-1"
project-name = "prueba-tecnica-cusca"
cidr_block   = "10.0.0.0/16"

subnets = {
  sbn-public-z1 = {
    name       = "sbn-public-z1-d"
    cidr_block = "10.0.10.0/24"
    tier       = "public"
    az         = "us-east-1a"
  }

  sbn-public-z2 = {
    name       = "sbn-public-z2-d"
    cidr_block = "10.0.11.0/24"
    tier       = "public"
    az         = "us-east-1b"
  }

  sbn-private-z1 = {
    name       = "sbn-private-z1-d"
    cidr_block = "10.0.20.0/24"
    tier       = "private"
    az         = "us-east-1a"
  }

  sbn-private-z2 = {
    name       = "sbn-private-z2-d"
    cidr_block = "10.0.21.0/24"
    tier       = "private"
    az         = "us-east-1b"
  }
}
