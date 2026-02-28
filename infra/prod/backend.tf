terraform {
  backend "s3" {
    bucket = "githubactions-tf-demo123"
    key    = "env/prod/terraform.tfstate"  
    region = "us-east-1"
  }
}
