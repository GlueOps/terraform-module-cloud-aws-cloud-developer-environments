resource "aws_iam_user" "slackbot" {
  name = "slackbot"
}
resource "aws_iam_policy" "slackbot" {
  name        = "slackbot"
  description = "Used devBot in GlueOps slack"
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
resource "aws_iam_user_policy_attachment" "slackbot" {
  user       = aws_iam_user.slackbot.name
  policy_arn = aws_iam_policy.slackbot.arn
}
