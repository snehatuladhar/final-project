module "sns_topic" {
  source  = "terraform-aws-modules/sns/aws"
  version = "6.1.0"

  name = "sns-mail"

  create_topic_policy = true
  topic_policy_statements = {
    pub = {
      actions = ["sns:Publish"]
      principals = [{
        type        = "Service"
        identifiers = ["events.amazonaws.com"]
      }]
      effect = "Allow"
    }
  }

  subscriptions = {
    email = {
      protocol = "email"
      endpoint = var.email
    }
  }
}