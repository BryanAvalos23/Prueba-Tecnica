terraform {
  backend "s3" {
    bucket  = "backend-prueba-cusca"
    key     = "environments/prod.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
