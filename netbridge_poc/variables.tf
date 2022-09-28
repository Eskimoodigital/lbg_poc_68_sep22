variable "avtx_controllerip" {
  type = string
}

variable "avtx_admin_user" {
  type = string
} 

variable "avtx_admin_password" {
  type = string
}

variable "azure_region" {
  type    = string
  default = "UK South"
}

variable "gcp_region" {
  type    = string
  default = "europe-west2"
}

variable "azure_account" {
  type = string
  default = "Azure"
}

variable gcp_account {
  type = string
  default = "Google"
}

variable transit_insane_mode {
  default = false
}

locals {

  spokes = {
    az_shsvc_spoke1 = {
      cloud      = "Azure",
      name       = "azure-shsvc-spoke1",
      cidr       = "10.1.101.0/24",
      instance_size = "Standard_D3_v2" // Small deployment - Non-insane mode use: Standard_B1ms  Insane mode use: Standard_D3_v2
      insane_mode = true
      region     = var.azure_region,
      account    = var.azure_account,
      transit_gw = (module.transit_adoption_framework.transit["azure_transit_firenet"].transit_gateway.gw_name),
    },
    az_dcx1_spoke1 = {
      cloud      = "Azure",
      name       = "azure-dcx1-spoke1",
      cidr       = "10.1.111.0/24",
      instance_size = "Standard_B1ms" // Small deployment - Non-insane mode use: Standard_B1ms  Insane mode use: Standard_D3_v2
      insane_mode = false
      region     = var.azure_region,
      account    = var.azure_account,
      transit_gw = (module.transit_adoption_framework.transit["azure_transit_firenet"].transit_gateway.gw_name),
    },
    az_dcx1_spoke2 = {
      cloud      = "Azure",
      name       = "azure-dcx1-spoke2",
      cidr       = "10.1.112.0/24",
      instance_size = "Standard_B1ms" // Small deployment - Non-insane mode use: Standard_B1ms  Insane mode use: Standard_D3_v2
      insane_mode = false
      region     = var.azure_region,
      account    = var.azure_account,
      transit_gw = (module.transit_adoption_framework.transit["azure_transit_firenet"].transit_gateway.gw_name),
    },
    az_cne1_spoke1 = {
      cloud      = "Azure",
      name       = "azure-cne1-spoke1",
      cidr       = "10.11.101.0/24",
      instance_size = "Standard_B1ms" // Small deployment - Non-insane mode use: Standard_B1ms  Insane mode use: Standard_D3_v2
      insane_mode = false
      region     = var.azure_region,
      account    = var.azure_account,
      transit_gw = (module.transit_adoption_framework.transit["azure_cne1_mtt"].transit_gateway.gw_name),
    },
    az_cne1_spoke2 = {
      cloud      = "Azure",
      name       = "azure-cne1-spoke2",
      cidr       = "10.11.102.0/24",
      instance_size = "Standard_B1ms" // Small deployment - Non-insane mode use: Standard_B1ms  Insane mode use: Standard_D3_v2
      insane_mode = false
      region     = var.azure_region,
      account    = var.azure_account,
      transit_gw = (module.transit_adoption_framework.transit["azure_cne1_mtt"].transit_gateway.gw_name),
    },
    gcp_shsvc_spoke1 = {
      cloud      = "GCP",
      name       = "gcp-shsvc-spoke1",
      cidr       = "10.2.101.0/24",
      instance_size = "n1-highcpu-4" // Small deployment - Non-insane mode use: Standard_B1ms  Insane mode use: n1-highcpu-4
      insane_mode = true
      region     = var.gcp_region,
      account    = var.gcp_account,
      transit_gw = (module.transit_adoption_framework.transit["gcp_transit_firenet"].transit_gateway.gw_name),
    },
    gcp_dcx1_spoke1 = {
      cloud      = "GCP",
      name       = "gcp-dcx1-spoke1",
      cidr       = "10.2.111.0/24",
      instance_size = "n1-standard-1" // Small deployment - Non-insane mode use: n1-standard-1  Insane mode use: n1-highcpu-4
      insane_mode = false
      region     = var.gcp_region,
      account    = var.gcp_account,
      transit_gw = (module.transit_adoption_framework.transit["gcp_transit_firenet"].transit_gateway.gw_name),
    },
    gcp_dcx1_spoke2 = {
      cloud      = "GCP",
      name       = "gcp-dcx1-spoke2",
      cidr       = "10.2.112.0/24",
      instance_size = "n1-standard-1" // Small deployment - Non-insane mode use: n1-standard-1  Insane mode use: n1-highcpu-4
      insane_mode = false
      region     = var.gcp_region,
      account    = var.gcp_account,
      transit_gw = (module.transit_adoption_framework.transit["gcp_transit_firenet"].transit_gateway.gw_name),
    },
  }
}
