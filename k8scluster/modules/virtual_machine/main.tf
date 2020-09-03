
resource "azurerm_virtual_machine" "vm" {
    name                  = var.vmname
    location              = var.location
    resource_group_name   = var.rgname
    network_interface_ids = [var.nicids[var.index]]
    vm_size               = var.vmsize

    storage_os_disk {
        name              = var.osdiskname
        caching           = var.caching
        create_option     = var.createoption
        managed_disk_type = var.manageddisktype
    }

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04.0-LTS"
        version   = "latest"
    }

    os_profile {
        computer_name  = var.computername
        admin_username = "manasadmin"
        admin_password = "Password1234!"
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }

    boot_diagnostics {
        enabled = "true"
        storage_uri = var.saendpoint[var.index]
    }

    
    provisioner "file" {
    source      = var.filename
    destination = var.filename 
  }
   provisioner "file" {
    source      = "daemon.json"
    destination = "daemon.json"  
  }
  provisioner "file" {
    source      = "kubernetes.list"
    destination = "kubernetes.list"  
  }
  provisioner "remote-exec" {
    inline = [
      "wget https://docs.projectcalico.org/v3.3/getting-started/kubernetes/installation/hosted/rbac-kdd.yaml",
      "wget https://docs.projectcalico.org/v3.9/getting-started/kubernetes/installation/hosted/kubernetes-datastore/calico-networking/1.7/calico.yaml",
      "sed -i -e 's/\r$//' ${var.filename}",
      "chmod +x ${var.filename}",
      "./${var.filename}"
      
    ]
  }
  connection {
    type     = "ssh"
    user     = "manasadmin"
    password = "Password1234!"
    host     = var.publicips[var.index]
  }
tags = {
        environment = var.environment
    }
}
