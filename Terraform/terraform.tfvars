#Project region
region = "us-east-1"
###################
#vpc
tags_vpc = {
  Name = "sneha-vpc",
}
cidr_vpc = "172.16.0.0/16"

######################
#subnet-1-public-us-easr-1a
#vpc_id
cidr_subnet_1 = "172.16.1.0/24"
az_subnet_1   = "us-east-1a"
public_1      = "true"
tags_subnet_1 = {
  Name = "sneha-pub-us-east-1a",
}


#######################
#subnet-2-public-ap-south-1b
cidr_subnet_2 = "172.16.2.0/24"
az_subnet_2   = "us-east-1b"
public_2      = "true"
tags_subnet_2 = {
  Name = "sneha-pub-us-east-1b",
}


#######################
#subnet-1-private-east-1a
cidr_subnet_3 = "172.16.3.0/24"
az_subnet_3   = "us-east-1a"
public_3      = "false"
tags_subnet_3 = {
  Name = "sneha-priv-us-east-1a",
}

#######################
#subnet-2-private-us-east-1b
cidr_subnet_4 = "172.16.4.0/24"
az_subnet_4   = "us-east-1b"
public_4      = "false"
tags_subnet_4 = {
  Name = "sneha-priv-us-east-1b",
}

#######################
#igw
tags_igw = {
  Name = "sneha-igw",
}

##############################
#route_table
rt_tags_pub = {
  Name = "sneha-rt-public",
}
rt_cidr_block_pub = "0.0.0.0/0"

#route_table
rt_tags_priv = {
  Name = "sneha-rt-private",
}
rt_cidr_block_priv = "0.0.0.0/0"

##############################
#eip
tags_eip = {
  Name = "sneha-eip-1",
}

##############################
#nat
tags_nat = {
  Name = "sneha-nat-1",
}
##############################
#sg_alb_web
sg_name_web = "web-alb-sg"
tags_sg_web = {
  Name = "sneha-web-alb-sg",
}
ingress_rules_web = [
  {
    description     = "allow on 443"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = null
  },
  {
    description     = "allow on 80"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = null
  },
  {
   description     = "allow on 4000"
    from_port       = 4000
    to_port         = 4000
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = null
  }
]

egress_rules_web = [
  {
    description     = "allow"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = null
  }
]
sg_description_web = " SG for WEB ALB"

#sg_alb_web
sg_name_app = "app-alb-sg"
tags_sg_app = {
  Name = "tf-app-alb-sg",
}
ingress_rules_app = [
  {
    description     = "allow on 443"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = null
  },
  {
    description     = "allow on 80"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = null
  },
  {
    description     = "allow on 4000"
    from_port       = 4000
    to_port         = 4000
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = null
  }
]

egress_rules_app = [
  {
    description     = "allow"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = null
  }
]
sg_description_app = " SG for APP ALB"
#sg_web_server
sg_name_web_server = "web_server-sg"
tags_sg_web_server = {
  Name = "sneha-web_server-sg",
}
# ingress_rules_web_server = [
#   {
#     description = "allow on 443"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = null
#     security_groups       = [aws_security_group.alb-sg.id]
#   },
#   {
#     description = "allow on 80"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = null
#     security_groups       = [aws_security_group.alb-sg.id]
#   }
# ]

egress_rules_web_server = [
  {
    description     = "allow"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = null
  }
]
sg_description_web_server = " SG for web_server"

##############################
#sg_app_server
sg_name_app_server = "app_server-sg"
tags_sg_app_server = {
  Name = "sneha-app_server-sg",
}
# ingress_rules_app_server = [
#   {
#     description = "allow on 443"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = null
#     security_groups       = [aws_security_group.alb-sg.id]
#   },
#   {
#     description = "allow on 80"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = null
#     security_groups       = [aws_security_group.alb-sg.id]
#   }
# ]

egress_rules_app_server = [
  {
    description     = "allow"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = null
  }
]
sg_description_app_server = " SG for app_server"


##############################
#web alb
tags_alb_web = {
  Name = "sneha-webtier-alb",
}

#app alb
tags_alb_app = {
  Name = "sneha-apptier-alb",
}

##############################
#target group

tags_web_tg = {
  Name = "sneha-webtier-tg",
}

tags_app_tg = {
  Name = "sneha-apptier-tg",
}
email         = "snehatuladhar098@gmail.com" 