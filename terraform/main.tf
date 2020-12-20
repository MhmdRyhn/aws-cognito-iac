terraform {
  backend "s3" {
    // The bucket must be present in the account which one the profile indicates.
    // This bucket must allow the profile user to have the following permissions:
    // s3:ListBucket, s3:GetObject, s3:PutObject
    // --> Sample policy for the terraform-state-bucket:
    // {
    //  "Version": "2012-10-17",
    //  "Statement": [
    //    {
    //      "Effect": "Allow",
    //      "Action": "s3:ListBucket",
    //      "Resource": "arn:aws:s3:::terraform-state-bucket"
    //    },
    //    {
    //      "Effect": "Allow",
    //      "Action": ["s3:GetObject", "s3:PutObject"],
    //      "Resource": "arn:aws:s3:::terraform-state-bucket/*"
    //    }
    //  ]
    //}

    bucket  = "terraform-state-bucket"
    key     = "application/application-state.tfstate"
    region  = "ap-southeast-1"
    profile = "dev"
  }
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
  version = "~> 3.22.0"
}
