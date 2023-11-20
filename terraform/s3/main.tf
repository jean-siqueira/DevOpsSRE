terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


resource "aws_s3_bucket" "devops-sre" {
  bucket = "s3-devops-sre.com"

}

resource "aws_s3_bucket_versioning" "devops-sre" {
  bucket = aws_s3_bucket.devops-sre.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_cors_configuration" "devops-sre" {
  bucket = aws_s3_bucket.devops-sre.id
  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000    
  }
}

resource "aws_s3_bucket_acl" "devops-sre_bucket_acl" {
  bucket = aws_s3_bucket.devops-sre.id
  #acl    = "public-read"
  acl    = "private"

}

# Resource to avoid error "AccessControlListNotSupported: The bucket does not allow ACLs"
resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.devops-sre.id
  rule {
    object_ownership = "ObjectWriter"
  }
}