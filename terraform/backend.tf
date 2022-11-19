terraform {
  backend "s3" {
    bucket = "tf-state-wcn"
    key = "terraform/"
    region = "eu-west-1"
  }
}