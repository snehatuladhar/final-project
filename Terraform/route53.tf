module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 3.0"
  zone_name = "sandbox.adex.ltd"  

  records = [
    {
      name = "todo"  
      type = "A"
      alias = {
        name    = "dualstack.sneha-webtier-alb-723709358.us-east-1.elb.amazonaws.com."
        zone_id = "Z08712023TNVIZ18XIFTV"  
      }
      evaluate_target_health = true
    }
  ]
}
