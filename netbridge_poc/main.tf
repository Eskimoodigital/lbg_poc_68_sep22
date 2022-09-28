module "transit_adoption_framework" {
  source  = "terraform-aviatrix-modules/mc-transit-deployment-framework/aviatrix"
  version = "v0.0.5"

  default_transit_accounts = {
    azure = var.azure_account,
    gcp   = var.gcp_account,
  }

  peering_mode = "custom"
  peering_map = {
    multicloud_peering : {
      gw1_name = (module.transit_adoption_framework.transit["azure_transit_firenet"].transit_gateway.gw_name),
      gw2_name = (module.transit_adoption_framework.transit["gcp_transit_firenet"].transit_gateway.gw_name)
    },
    azure_mtt_peering : {
      gw1_name = (module.transit_adoption_framework.transit["azure_cne1_mtt"].transit_gateway.gw_name),
      gw2_name = (module.transit_adoption_framework.transit["azure_transit_firenet"].transit_gateway.gw_name)
    },
  }

  transit_firenet = {
    azure_transit_firenet = {
      transit_name        = "azure-shsvc-transit"
      transit_cloud       = "azure",
      transit_cidr        = "10.1.0.0/23",
      transit_region_name = var.azure_region,
      transit_asn         = 64512,
      transit_insane_mode         = var.transit_insane_mode
      firenet             = false // Set to true to deploy firewalls
      transit_enable_transit_firenet = true // Used to enable transit firenet 
    },
    gcp_transit_firenet = {
      transit_name        = "gcp-shsvc-transit"
      transit_cloud       = "gcp",
      transit_cidr        = "10.2.0.0/20",
      transit_lan_cidr    = "10.2.16.0/20",
      transit_region_name = var.gcp_region,
      transit_asn         = 64513,
      transit_insane_mode         = var.transit_insane_mode
      firenet             = false // Set to true to deploy firewalls
      transit_enable_transit_firenet = true // Used to enable transit firenet 
    },
    azure_cne1_mtt = {
      transit_name                      = "azure-cne1-mt-transit"
      transit_cloud                     = "azure",
      transit_cidr                      = "10.11.0.0/23",
      transit_region_name               = var.azure_region,
      transit_asn                       = 64514,
      transit_insane_mode               = false
      transit_enable_multi_tier_transit = true
    },
  }
}

module "spokes" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  //version = "1.1.2"
  //version = "1.2.4"
  version = "1.3.0"

  for_each = local.spokes

  cloud      = each.value.cloud
  name       = each.value.name
  cidr       = each.value.cidr
  region     = each.value.region
  account    = each.value.account
  transit_gw = each.value.transit_gw
  insane_mode = each.value.insane_mode
  instance_size = each.value.instance_size
}
