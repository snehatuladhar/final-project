 variable name_prefix{
    type = string
 }

 variable image_id {
    type = string
 }

 variable instance_type{
    type = string
 }

 variable key_name{
    type = string
 }

#  variable user_data{
#     type = string
#  }

 variable vpc_security_group_ids {
    type = list
  }
 variable "tags_lt" {
   description = "Tags to apply to the launch template and instances"
   type        = map(string)
  }

variable "instance_profile_arn" {
  description = "IAM Instance Profile ARN"
  type        = string
}