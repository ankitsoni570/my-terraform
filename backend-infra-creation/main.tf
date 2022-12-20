terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}
#=============================================================================
#=============================================================================
# Creation of S3 Bucket
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.tfstate_bucket_name     #name of S3 Bucket
}

# S3 Bucket versioning
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# S3 Bucket encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"  #"aws:kms"
    }
  }
}

#=============================================================================
#=============================================================================
# Dynamo DB creation
resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.dynamo_db_table_name
  billing_mode = var.db_billing_mode
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}


