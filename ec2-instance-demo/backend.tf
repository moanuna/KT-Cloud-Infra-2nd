terraform {
  backend "s3" {
    bucket = "my-unique-bucket-name-2026-seungyeon" 
    key    = "terraform.tfstate"
    region = "ap-northeast-2" 
  }
}
