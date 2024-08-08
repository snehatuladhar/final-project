#subnet for app layer
module "subnet-priv-1a" {
  source      = "./modules/subnet"
  vpc_id = module.my_vpc.vpc_id
  cidr_subnet = var.cidr_subnet_3
  az_subnet   = var.az_subnet_3
  public      = var.public_3
  tags_subnet = var.tags_subnet_3

}

module "subnet-priv-1b" {
  source      = "./modules/subnet"
  vpc_id = module.my_vpc.vpc_id
  cidr_subnet = var.cidr_subnet_4
  az_subnet   = var.az_subnet_4
  public      = var.public_4
  tags_subnet = var.tags_subnet_4

}

# route table association 
module "rt_ass_priv_1a" {
  source         = "./modules/rt_association"
  subnet_id      = module.subnet-priv-1a.subnet_id
  route_table_id = module.private_rt.rt_id
}

module "rt_ass_priv_1b" {
  source         = "./modules/rt_association"
  subnet_id      = module.subnet-priv-1b.subnet_id
  route_table_id = module.private_rt.rt_id
}


#Application load balancer 
module "app-alb" {
  source = "./modules/application_load_balancer"
  name   = "sneha-apptier-alb"
  security_groups = [module.sg_alb_app.sg_id]
  subnets         = [module.subnet-priv-1a.subnet_id, module.subnet-priv-1b.subnet_id]
  is_internal     = true
  tags_alb = var.tags_alb_app
}


#Target Group
module "appTier-tg" {
  source = "./modules/target_group"

  name                        = "sneha-appTier-tg"
  port                        = 80
  protocol                    = "HTTP" 
  vpc_id = module.my_vpc.vpc_id
  tags_tg  = var.tags_app_tg
  health_check_interval       = 30
  health_check_path           = "/health"
  health_check_protocol       = "HTTP"
  health_check_timeout        = 5
  health_check_unhealthy_threshold = 2
  health_check_healthy_threshold   = 5
}


#Listener group 
module "http_listener_app" {
  source   = "./modules/listener_group"
  lb_arn   = module.app-alb.alb_arn
  port     = "80"
  protocol = "HTTP"
  tg_arn = module.appTier-tg.tg_arn
}

#autoscaling
module "app_asg1" {
  source              = "./modules/autoscaling_group"
  vpc_zone_identifier = [module.subnet-priv-1a.subnet_id,module.subnet-priv-1b.subnet_id]
  desired_capacity  = 2
  max_size          = 3
  min_size          = 1
  target_group_arns = [module.appTier-tg.tg_arn]
  launch_template   = module.apptier_lt.lt_id
  value = "sneha-apptier_lt"
  asgname = "app_asg1"


}

module "sg_alb_app" {
  source         = "./modules/security_group"
  ingress_rules  = var.ingress_rules_app
  vpc_id         = module.my_vpc.vpc_id
  sg_name        = var.sg_name_app
  sg_description = var.sg_description_app
  egress_rules   = var.egress_rules_app
  tags_sg = var.tags_sg_app
}
#security group for app server

module "sg_app_server" {
  source = "./modules/security_group"
  ingress_rules = [
    {
      description     = "allow on 443"
      from_port       = 443
      to_port         = 443
      protocol        = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
  
    },
    {
      description     = "allow on 80"
      from_port       = 80
      to_port         = 80
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
    
    },
    # {
    #  description     = "allow on 4000"
    #   from_port       = 4000
    #   to_port         = 4000
    #   protocol        = "tcp"
    #   cidr_blocks     = ["0.0.0.0/0"]
     
    # }

  ] #var.ingress_rules_app_server
  vpc_id         = module.my_vpc.vpc_id
  sg_name        = var.sg_name_app_server
  sg_description = var.sg_description_app_server
  egress_rules   = var.egress_rules_app_server
  tags_sg = var.tags_sg_app_server
}

#Launch template
module "apptier_lt" {
  source                 = "./modules/launch_template"
  name_prefix            = "sneha-appserver-"
  image_id               = "ami-04b70fa74e45c3917" #Ubuntu 24.04
  instance_type          = "t2.micro"
  key_name               = "sneha-keypair"
  # user_data              = filebase64("${path.module}/app.sh")
  vpc_security_group_ids = [module.sg_app_server.sg_id]
  instance_profile_arn   = module.iam.ssm_instance_profile_arn
    tags_lt = {
    Name  = "sneha-apptier_lt"
  }
}

#To add ingress rule in app server security group

resource "aws_security_group_rule" "rds_connection" {
  depends_on = [
    module.sg_rds
  ]
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.sg_rds.sg_id
  security_group_id = module.sg_app_server.sg_id
  
}