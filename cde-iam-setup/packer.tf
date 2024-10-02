# https://github.com/glueops/codespaces
# Credentials are generated in the UI/Console.
resource "aws_iam_user" "packer" {
  provider = aws.iam
  name     = "packer"
}

resource "aws_iam_policy" "packer" {
  provider = aws.iam

  name        = "packer"
  description = "Used for automated builds via github actions"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ec2:*",
        ],
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_user_policy_attachment" "packer" {
  provider = aws.iam

  user       = aws_iam_user.packer.name
  policy_arn = aws_iam_policy.packer.arn
}
