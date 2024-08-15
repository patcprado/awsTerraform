terraform {
  backend "s3" {
    bucket  = "bia-dev-terraform"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    profile = "patcprado"
  }
}