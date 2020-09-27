variable "aws_profile" {
  type        = string
  description = "Name of teh AWS profile."
}

variable "aws_region" {
  type        = string
  description = "AWS region."
  default     = "ap-southeast-1" # Singapore
}

variable "environment" {
  type        = string
  description = "Name of the environment, e.g., dev, test, stable, uat, staging, prod etc."
  default     = "prod"
}

variable "app_name" {
  type        = string
  description = "Name of the application which this user pool will be used for."
}

variable "user_pool_name" {
  type        = string
  description = "Name of the cognito user pool."
}

variable "app_client_name" {
  type        = string
  description = "Name of the default app client."
}
