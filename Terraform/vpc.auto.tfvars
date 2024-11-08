subnets = {
  c2 = {
    region = "asia-northeast1"
    cidr   = "10.1.0.0/24"
  }
  phishing = {
    region = "asia-northeast1"
    cidr   = "10.2.0.0/24"
  }
  redirector = {
    region = "asia-northeast1"
    cidr   = "10.3.0.0/24"
  }
  test = {
    region = "asia-northeast1"
    cidr   = "10.4.0.0/24"
  }
}

firewall_rules = {
  http_from_internet = {
    name      = "allow-http-from-internet"
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

  proxy_from_c2 = {
    name      = "allow-proxy-from-c2"
    direction = "INGRESS"
    allow_protocols = [
      {
        protocol = "tcp"
        ports    = ["3128"]
      }
    ]
    source_ranges      = ["10.1.0.0/24"]
    destination_ranges = []
    target_tags        = ["redirector"]
    priority           = 1000
  }

  c2_from_myip = {
    name      = "allow-c2-from-myip"
    direction = "INGRESS"
    allow_protocols = [
      {
        protocol = "tcp"
        ports    = ["40056"]
      }
    ]
    source_ranges      = ["220.146.34.124/32", "121.103.83.2"]
    destination_ranges = []
    target_tags        = ["redirector"]
    priority           = 1000
  }

  ssh_from_c2 = {
    name      = "allow-ssh-from-c2"
    direction = "INGRESS"
    allow_protocols = [
      {
        protocol = "tcp"
        ports    = ["22"]
      }
    ]
    source_ranges      = ["10.1.0.0/24"]
    destination_ranges = []
    target_tags        = ["redirector"]
    priority           = 1000
  }

  rdp_inside_test = {
    name      = "allow-rdp-inside-test"
    direction = "INGRESS"
    allow_protocols = [
      {
        protocol = "tcp"
        ports    = ["3389"]
      }
    ]
    source_ranges      = ["10.4.0.0/24"]
    destination_ranges = []
    target_tags        = ["ad", "terminal", "bastion", "server"]
    priority           = 1000
  }

  rdp_from_myip = {
    name      = "allow-rdp-from-myip"
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
    name      = "allow-proxy-inside-test"
    direction = "INGRESS"
    allow_protocols = [
      {
        protocol = "tcp"
        ports    = ["3128"]
      }
    ]
    source_ranges      = ["10.4.0.0/24"]
    destination_ranges = []
    target_tags        = ["proxy"]
    priority           = 1000
  }


  all_inside_test = {
    name      = "allow-all-inside-test"
    direction = "INGRESS"
    allow_protocols = [
      {
        protocol = "all"
        ports    = []
      }
    ]
    source_ranges      = ["10.4.0.0/24"]
    destination_ranges = []
    target_tags        = ["windows"]
    priority           = 1000
  }

  ssh_from_privatepool = {
    name      = "allow-ssh-from-privatepool"
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

  winrm_from_privatepool = {
    name      = "allow-winrm-from-privatepool"
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
}
