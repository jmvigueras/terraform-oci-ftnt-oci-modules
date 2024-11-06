output "fgts" {
  value = { for k, v in module.fgt :
    "fgt${k + 1}" => {
      id         = v.id
      public_ip  = v.public_ip
      admin_port = local.admin_port
    }
  }
}

output "vms" {
  value = { for k, v in module.spoke_vms : "vm-spoke${k + 1}" => v.vm["public_ip"] }
}
