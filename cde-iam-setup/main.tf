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

resource "aws_iam_user" "users" {
  count = length(var.usernames)
  name  = var.usernames[count.index]
}

resource "aws_iam_group_membership" "group_membership" {
  name = "${var.group_name}_membership"

  users = aws_iam_user.users.*.name
  group = aws_iam_group.group.name
}
