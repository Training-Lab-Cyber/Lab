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

vm_configs={  
    c2 = {
    zone            = "us-west1-a"
    name            = "dev-vm-c2"
    machine_type    = "n1-standard-1"
    subnet_name     = "c2"
    tags            = ["c2"]
    labels          = { group = "c2"}
    image           = "debian-cloud/debian-11"
    add_access_config = true
  }

  redirector = {
    zone            = "us-west1-a"
    name            = "dev-vm-redirector"
    machine_type    = "n1-standard-1"
    subnet_name     = "redirector"
    tags            = ["redirector"]
    labels          = { group = "redirector"}
    image           = "debian-cloud/debian-11"
    add_access_config = true
  }

}

firewall_rules = {
  ssh = {
    name            = "dev-allow-http-from-internet"
    direction       = "INGRESS"
    allow_protocols = [
      {
        protocol = "tcp"
        ports    = ["80"]
      }
    ]
    source_ranges   = ["0.0.0.0/0"]
    destination_ranges = []
    target_tags     = ["redirector"]
    priority           = 1000
  }

  sliver = {
    name            = "dev-allow-grpc-from-terminal"
    direction       = "INGRESS"
    allow_protocols = [
      {
        protocol = "tcp"
        ports    = ["31337"]
      }
    ]
    source_ranges   = ["220.146.34.124/32"]
    destination_ranges = []
    target_tags     = ["c2"]
    priority           = 1000
  }

  egress = {
    name            = "dev-allow-ssh-from-iap"
    direction       = "INGRESS"
    allow_protocols = [
      {
        protocol = "tcp"
        ports    = ["22"]
      }
    ]
    source_ranges = ["35.235.240.0/20"]
    destination_ranges = []
    target_tags     = ["redirector","c2"]
    priority           = 1000
  }
}