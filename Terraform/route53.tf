module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 3.0"
  zone_name = "sandbox.adex.ltd"

  records = [
    {
      name = "todo"
      type = "A"
      alias = {
        name    = module.web-alb.dns_name
        zone_id = module.web-alb.zone_id
      }

    }
  ]
}
