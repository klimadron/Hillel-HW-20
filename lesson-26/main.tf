# locals {
#   instance_count = 1
# }
module "instance" {
  source = "./modules/instance"

  name           = "hillel-A.Klimakhin"
  security_group_id = ""
  key_name       = var.key_name
  instance_count = local.instance_count
  create_ssm_role  = "true"
  disk_type = "gp2"
}
locals {
  instance_count = 1
}
