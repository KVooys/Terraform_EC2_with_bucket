terraform {
    required_version = ">= 0.11.0"
}

provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "Your-EC2" {
  ami                  = "${var.image_id}"
  iam_instance_profile = "${aws_iam_instance_profile.EC2-profile.id}"
  instance_type        = "${var.instance_size}"
  subnet_id            = "${var.subnet}"
  source_dest_check    = "False"
  tags                 = "${var.tags}"
}

resource "aws_s3_bucket" "Your-S3" {
  count         = "${var.create_bucket}"  
  bucket        = "${var.bucket_id}"
  force_destroy = true
  acl           = "private"
  tags          = "${var.tags}"
}

resource "aws_iam_role" "EC2-role" {
  name        = "EC2-role"
  description = "Give EC2 access to 1 bucket for storage"

  assume_role_policy = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
        "Action": "sts:AssumeRole",
        "Principal": {
            "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
        }
    ]
    }
  EOF
}

data "aws_iam_policy_document" "EC2toS3-doc" {
  statement {
    effect = "Allow"  
    actions = ["s3:*"]
    resources = [
      "${aws_s3_bucket.Your-S3.arn}",
      "${aws_s3_bucket.Your-S3.arn}/*",
    ]
  }
}

resource "aws_iam_role_policy" "EC2toS3-policy" {
  role   = "${aws_iam_role.EC2-role.id}"
  policy = "${data.aws_iam_policy_document.EC2toS3-doc.json}"
}

resource "aws_iam_instance_profile" "EC2-profile" {
  name = "EC2-profile"
  role = "${aws_iam_role.EC2-role.name}"
}

