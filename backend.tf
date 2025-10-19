terraform {
  backend "s3" {
    bucket = "bucket-adianny-training-backend"
    key    = "terraform.tfstate"
    region = "eu-west-1"
  }
}
