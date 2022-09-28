provider "aviatrix" {
  controller_ip           = var.avtx_controllerip
  username                = var.avtx_admin_user
  password                = var.avtx_admin_password
  skip_version_validation = false
}