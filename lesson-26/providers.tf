provider "aws" {
  default_tags {
    tags = {
      Hillel    = "Lesson 26"
      Terraform = true
    }
  }
}

provider "aws" {
  alias = "us-east-1"

  region = "us-east-1"
  default_tags {
    tags = {
      Hillel    = "Lesson 26"
      Terraform = true
    }
  }
}

provider "external" {}
