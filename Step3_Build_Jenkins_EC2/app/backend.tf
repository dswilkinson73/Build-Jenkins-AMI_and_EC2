terraform {
  backend "s3" {
    key = "terraform/state_files/jenkins/terraform.tfstate"
  }
}
