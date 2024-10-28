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
    machine_type      = "n1-standard-2"
    subnet_name       = "c2"
    tags              = ["c2", "linux"]
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
    tags              = ["redirector", "linux"]
    labels            = { group = "redirector" }
    image             = "debian-cloud/debian-11"
    os                = "linux"
    add_access_config = true
  }

  proxy = {
    zone              = "us-west1-a"
    name              = "dev-vm-proxy"
    machine_type      = "n1-standard-1"
    subnet_name       = "test"
    tags              = ["proxy", "linux"]
    labels            = { group = "proxy" }
    image             = "debian-cloud/debian-11"
    os                = "linux"
    add_access_config = true
  }

  bastion = {
    zone              = "us-west1-a"
    name              = "dev-vm-bastion"
    machine_type      = "n1-standard-1"
    subnet_name       = "test"
    tags              = ["bastion", "windows"]
    labels            = { group = "bastion" }
    image             = "windows-server-2022-dc-v20241010"
    os                = "windows"
    add_access_config = true
  }
  ad-prod = {
    zone              = "us-west1-a"
    name              = "dev-vm-ad-prod"
    machine_type      = "n1-standard-2"
    subnet_name       = "test"
    tags              = ["ad", "windows"]
    labels            = { group = "ad-prod" }
    image             = "windows-server-2022-dc-v20241010"
    os                = "windows"
    add_access_config = false
  }
  ad-dev = {
    zone              = "us-west1-a"
    name              = "dev-vm-ad-dev"
    machine_type      = "n1-standard-2"
    subnet_name       = "test"
    tags              = ["ad", "windows"]
    labels            = { group = "ad-dev" }
    image             = "windows-server-2022-dc-v20241010"
    os                = "windows"
    add_access_config = false
  }
  pc1 = {
    zone              = "us-west1-a"
    name              = "dev-vm-pc1"
    machine_type      = "n1-standard-1"
    subnet_name       = "test"
    tags              = ["pc", "windows"]
    labels            = { group = "pc-dev" }
    image             = "windows-server-2022-dc-v20241010"
    os                = "windows"
    add_access_config = false
  }

  pc2 = {
    zone              = "us-west1-a"
    name              = "dev-vm-pc2"
    machine_type      = "n1-standard-1"
    subnet_name       = "test"
    tags              = ["pc", "windows"]
    labels            = { group = "pc-dev" }
    image             = "windows-server-2022-dc-v20241010"
    os                = "windows"
    add_access_config = false
  }

  pc3 = {
    zone              = "us-west1-a"
    name              = "dev-vm-pc3"
    machine_type      = "n1-standard-1"
    subnet_name       = "test"
    tags              = ["pc", "windows"]
    labels            = { group = "pc-dev" }
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

  c2_from_myip = {
    name      = "dev-allow-c2-from-pc"
    direction = "INGRESS"
    allow_protocols = [
      {
        protocol = "tcp"
        ports    = ["40056"]
      }
    ]
    source_ranges      = ["220.146.34.124/32"]
    destination_ranges = []
    target_tags        = ["c2"]
    priority           = 1000
  }

  http_from_redirector = {
    name      = "dev-allow-http-from-redirector"
    direction = "INGRESS"
    allow_protocols = [
      {
        protocol = "tcp"
        ports    = ["8080"]
      }
    ]
    source_ranges      = ["10.20.10.0/24"]
    destination_ranges = []
    target_tags        = ["c2"]
    priority           = 1000
  }

  rdp_inside_bastion = {
    name      = "dev-allow-rdp-inside-test"
    direction = "INGRESS"
    allow_protocols = [
      {
        protocol = "tcp"
        ports    = ["3389"]
      }
    ]
    source_ranges      = ["10.30.10.0/24"]
    destination_ranges = []
    target_tags        = ["ad", "pc", "bastion"]
    priority           = 1000
  }

  rdp_from_myip = {
    name      = "dev-allow-rdp-from-myip"
    direction = "INGRESS"
    allow_protocols = [
      {
        protocol = "tcp"
        ports    = ["3389"]
      }
    ]
    source_ranges      = ["121.103.83.2/32", "220.146.34.124/32"]
    destination_ranges = []
    target_tags        = ["bastion"]
    priority           = 1000
  }

  proxy_inside_test = {
    name      = "dev-allow-proxy-inside-test"
    direction = "INGRESS"
    allow_protocols = [
      {
        protocol = "tcp"
        ports    = ["3128"]
      }
    ]
    source_ranges      = ["10.30.10.0/24"]
    destination_ranges = []
    target_tags        = ["proxy"]
    priority           = 1000
  }

  ssh_from_privatepool = {
    name      = "dev-allow-ssh-from-privatepool"
    direction = "INGRESS"
    allow_protocols = [
      {
        protocol = "tcp"
        ports    = ["22"]
      }
    ]
    source_ranges      = ["10.254.0.0/24"]
    destination_ranges = []
    target_tags        = ["linux"]
    priority           = 1000
  }

  ssh_from_myip = {
    name      = "dev-allow-ssh-from-myip"
    direction = "INGRESS"
    allow_protocols = [
      {
        protocol = "tcp"
        ports    = ["22"]
      }
    ]
    source_ranges      = ["121.103.83.2/32", "220.146.34.124/32"]
    destination_ranges = []
    target_tags        = ["linux"]
    priority           = 1000
  }

  winrm_from_privatepool = {
    name      = "dev-allow-winrm-from-privatepool"
    direction = "INGRESS"
    allow_protocols = [
      {
        protocol = "tcp"
        ports    = ["5985", "5986"]
      }
    ]
    source_ranges      = ["10.254.0.0/24"]
    destination_ranges = []
    target_tags        = ["windows"]
    priority           = 1000
  }

  ad_inside_test = {
    name      = "dev-allow-ad-inside-test"
    direction = "INGRESS"
    allow_protocols = [
      {
        protocol = "all"
        ports    = []
      }
    ]
    source_ranges      = ["10.30.10.0/24"]
    destination_ranges = []
    target_tags        = ["ad"]
    priority           = 1000
  }

}
