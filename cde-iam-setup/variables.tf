variable "group_name" {
  description = "The name of the IAM group"
  type        = string
  default     = "developers"
}

variable "usernames" {
  description = "List of IAM user names to be created and added to the group"
  type        = list(string)
}
