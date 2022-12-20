terraform {
  backend "s3" {
    bucket = "po-test-tfstate"
    key    = "terraform.tfstate"
    region = "us-east-1"
    # Dynamo DB configs
    dynamodb_table = "po-test-db"   # DB table name
    encrypt        = true
  }
}