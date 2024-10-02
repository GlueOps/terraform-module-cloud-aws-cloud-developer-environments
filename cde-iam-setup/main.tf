resource "aws_iam_group" "group" {
  name = var.group_name
}

resource "aws_iam_group_policy_attachment" "group_policy_attachment" {
  for_each   = toset(["arn:aws:iam::aws:policy/AmazonEC2FullAccess", "arn:aws:iam::aws:policy/ReadOnlyAccess"])
  group      = aws_iam_group.group.name
  policy_arn = each.value
}

resource "aws_iam_group_policy_attachment" "ec2_instance_connect" {
  group      = aws_iam_group.group.name
  policy_arn = aws_iam_policy.ec2_instance_connect.arn
}

resource "aws_iam_group_policy_attachment" "password-mgmt" {
  group      = aws_iam_group.group.name
  policy_arn = aws_iam_policy.password-mgmt.arn
}

# Create IAM users using for_each instead of count
resource "aws_iam_user" "users" {
  for_each = toset(var.usernames)
  name     = each.key
}

# Add users to the group
resource "aws_iam_group_membership" "group_membership" {
  name = "${var.group_name}_membership"

  users = [for user in aws_iam_user.users : user.name]
  group = aws_iam_group.group.name
}