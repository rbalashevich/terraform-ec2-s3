// creating an S3 bucket and allow TF to destroy it
resource "aws_s3_bucket" "b" {
  bucket        = "my-bucket-35cf"
  force_destroy = true
}

// making S3 bucket private
resource "aws_s3_bucket_public_access_block" "b_access" {
  bucket              = aws_s3_bucket.b.id
  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
}

//  creating the policy that will allow access to the S3 bucket
resource "aws_iam_policy" "bucket_policy" {
  name        = "my-bucket-policy"
  path        = "/"
  description = "My S3 Policy Allowing R/W"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:DeleteObject"
        ],
        "Resource" : [
          "arn:aws:s3:::*/*",
          "arn:aws:s3:::my-bucket-35cf"
        ]
      }
    ]
  })
}

// creating an IAM role, we'll assign the S3 bucket policy to this role
resource "aws_iam_role" "some_role" {
  name = "my_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

//  assigning the S3 bucket policy to the role
resource "aws_iam_role_policy_attachment" "some_bucket_policy" {
  role       = aws_iam_role.some_role.name
  policy_arn = aws_iam_policy.bucket_policy.arn
}

// we can’t just attach an IAM role to an ec2 instance,
// we actually need an IAM instance profile resource
// to connect the EC2 instance and the policy.
resource "aws_iam_instance_profile" "some_profile" {
  name = "some-profile"
  role = aws_iam_role.some_role.name
}
