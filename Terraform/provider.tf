provider "aws" {
  region = var.region
  default_tags {
    tags = {
      owner     = "sneha"
      silo      = "intern"
      terraform = "true"
    }
  }
}


