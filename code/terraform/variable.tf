variable "aws_region" {
  description = "AWS region to launch servers."
  default = "us-east-1"
}

variable "access_key" {}
variable "secret_key" {}

data "aws_caller_identity" "current" {}

output "account_id" {
  value = "${data.aws_caller_identity.current.account_id}"
}

output "caller_arn" {
  value = "${data.aws_caller_identity.current.arn}"
}

output "caller_user" {
  value = "${data.aws_caller_identity.current.user_id}"
}
