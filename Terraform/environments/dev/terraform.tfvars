subnets = {
  c2 = {
    region = "us-west1"
    cidr   = "10.10.10.0/24"
  }
  phishing = {
    region = "us-west1"
    cidr   = "10.10.20.0/24"
  }
  redirector = {
    region = "us-west1"
    cidr   = "10.20.10.0/24"
  }
  test = {
    region = "us-west1"
    cidr   = "10.30.10.0/24"
  }
}

vm_configs = {
  c2 = {
    zone              = "us-west1-a"
    name              = "dev-vm-c2"
    machine_type      = "n1-standard-1"
    subnet_name       = "c2"
    tags              = ["c2"]
    labels            = { group = "c2" }
    image             = "debian-cloud/debian-11"
    os                = "linux"
    add_access_config = true
  }

  redirector = {
    zone              = "us-west1-a"
    name              = "dev-vm-redirector"
    machine_type      = "n1-standard-1"
    subnet_name       = "redirector"
    tags              = ["redirector"]
    labels            = { group = "redirector" }
    image             = "debian-cloud/debian-11"
    os                = "linux"
    add_access_config = true
  }

  bastion = {
    zone              = "us-west1-a"
    name              = "dev-vm-bastion"
    machine_type      = "n1-standard-1"
    subnet_name       = "test"
    tags              = ["bastion"]
    labels            = { group = "bastion" }
    image             = "debian-cloud/debian-11"
    os                = "linux"
    add_access_config = false
  }
  ad = {
    zone              = "us-west1-a"
    name              = "dev-vm-ad"
    machine_type      = "n1-standard-1"
    subnet_name       = "test"
    tags              = ["ad"]
    labels            = { group = "ad" }
    image             = "windows-server-2022-dc-v20241010"
    os                = "windows"
    add_access_config = false
  }

}

firewall_rules = {
  http_from_internet = {
    name      = "dev-allow-http-from-internet"
    direction = "INGRESS"
    allow_protocols = [
      {
        protocol = "tcp"
        ports    = ["80"]
      }
    ]
    source_ranges      = ["0.0.0.0/0"]
    destination_ranges = []
    target_tags        = ["redirector"]
    priority           = 1000
  }

  sliver_from_myip = {
    name      = "dev-allow-grpc-from-terminal"
    direction = "INGRESS"
    allow_protocols = [
      {
        protocol = "tcp"
        ports    = ["31337"]
      }
    ]
    source_ranges      = ["220.146.34.124/32"]
    destination_ranges = []
    target_tags        = ["c2"]
    priority           = 1000
  }

  ssh_from_iap = {
    name      = "dev-allow-ssh-from-iap"
    direction = "INGRESS"
    allow_protocols = [
      {
        protocol = "tcp"
        ports    = ["22"]
      }
    ]
    source_ranges      = ["35.235.240.0/20"]
    destination_ranges = []
    target_tags        = ["redirector", "c2", "bastion"]
    priority           = 1000
  }

  winrm_from_bastion = {
    name      = "dev-allow-winrm-from-bastion"
    direction = "INGRESS"
    allow_protocols = [
      {
        protocol = "tcp"
        ports    = ["5985", "5986", "22"]
      }
    ]
    source_ranges      = ["35.235.240.0/20"]
    destination_ranges = []
    target_tags        = ["ad"]
    priority           = 1000
  }
}
