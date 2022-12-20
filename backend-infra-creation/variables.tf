# AWS access keys
variable "access_key" {
    type = string
}

variable "secret_key" {
    type = string
}

variable "region" {
  type = string
}
#==========================================================================
#==========================================================================
# Varibale for S3

variable "tfstate_bucket_name" {
  type = string
}

#==========================================================================
#==========================================================================
# Varibale for Dynamo DB
variable "dynamo_db_table_name" {
  type = string
}
variable "db_billing_mode" {
  type = string
}
