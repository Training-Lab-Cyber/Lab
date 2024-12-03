vm_configs = {
  vpn = {
    zone              = "asia-northeast1-a"
    name              = "vm-openvpn"
    machine_type      = "n1-standard-1"
    subnet_name       = "vpn"
    tags              = ["vpn", "linux"]
    labels            = { group = "vpn" }
    image             = "ubuntu-os-cloud/ubuntu-2410-amd64"
    os                = "linux"
    add_access_config = true
    disksize          = 20
  }

  
  bloodhound = {
    zone              = "asia-northeast1-a"
    name              = "vm-bloodhound"
    machine_type      = "n1-standard-2"
    subnet_name       = "c2"
    tags              = ["bloodhound", "linux"]
    labels            = { group = "bloodhound" }
    image             = "debian-cloud/debian-11"
    os                = "linux"
    add_access_config = true
    disksize          = 200
  }

  cs = {
    zone              = "asia-northeast1-a"
    name              = "vm-cobaltstrike"
    machine_type      = "n1-standard-2"
    subnet_name       = "c2"
    tags              = ["c2", "linux"]
    labels            = { group = "cs" }
    image             = "ubuntu-os-cloud/ubuntu-2410-amd64"
    os                = "linux"
    add_access_config = false
    disksize          = 100
  }

  havoc = {
    zone              = "asia-northeast1-a"
    name              = "vm-havoc"
    machine_type      = "n1-standard-2"
    subnet_name       = "c2"
    tags              = ["c2", "linux"]
    labels            = { group = "havoc" }
    image             = "ubuntu-os-cloud/ubuntu-2410-amd64"
    os                = "linux"
    add_access_config = false
    disksize          = 100
  }


  redelk = {
    zone              = "asia-northeast1-a"
    name              = "vm-redelk"
    machine_type      = "n1-standard-2"
    subnet_name       = "c2"
    tags              = ["redelk", "linux"]
    labels            = { group = "redelk" }
    image             = "ubuntu-os-cloud/ubuntu-2410-amd64"
    os                = "linux"
    add_access_config = false
    disksize          = 500
  }


  phishing = {
    zone              = "asia-northeast1-a"
    name              = "vm-phishing"
    machine_type      = "n1-standard-1"
    subnet_name       = "phishing"
    tags              = ["phishing", "linux"]
    labels            = { group = "phishing" }
    image             = "debian-cloud/debian-11"
    os                = "linux"
    add_access_config = true
    disksize          = 20
  }

  redirector = {
    zone              = "asia-northeast1-a"
    name              = "vm-redirector"
    machine_type      = "n1-standard-1"
    subnet_name       = "redirector"
    tags              = ["redirector", "linux"]
    labels            = { group = "redirector" }
    image             = "debian-cloud/debian-11"
    os                = "linux"
    add_access_config = true
    disksize          = 20
  }

  proxy = {
    zone              = "asia-northeast1-a"
    name              = "vm-proxy"
    machine_type      = "n1-standard-1"
    subnet_name       = "test"
    tags              = ["proxy", "linux"]
    labels            = { group = "proxy" }
    image             = "debian-cloud/debian-11"
    os                = "linux"
    add_access_config = true
    disksize          = 20
  }

  ad-prod = {
    zone              = "asia-northeast1-a"
    name              = "vm-ad-prod"
    machine_type      = "n1-standard-2"
    subnet_name       = "test"
    tags              = ["ad", "windows"]
    labels            = { group = "ad-prod" }
    image             = "windows-server-2022-dc-v20241010"
    os                = "windows"
    add_access_config = false
    disksize          = 50
  }
  ad-dev = {
    zone              = "asia-northeast1-a"
    name              = "vm-ad-dev"
    machine_type      = "n1-standard-2"
    subnet_name       = "test"
    tags              = ["ad", "windows"]
    labels            = { group = "ad-dev" }
    image             = "windows-server-2022-dc-v20241010"
    os                = "windows"
    add_access_config = false
    disksize          = 50
  }
  ad-child = {
    zone              = "asia-northeast1-a"
    name              = "vm-ad-child"
    machine_type      = "n1-standard-2"
    subnet_name       = "test"
    tags              = ["ad", "windows"]
    labels            = { group = "ad-child" }
    image             = "windows-server-2022-dc-v20241010"
    os                = "windows"
    add_access_config = false
    disksize          = 50
  }
  pc1 = {
    zone              = "asia-northeast1-a"
    name              = "vm-terminal1"
    machine_type      = "n1-standard-1"
    subnet_name       = "test"
    tags              = ["terminal", "windows"]
    labels            = { group = "terminal-dev" }
    image             = "windows-server-2022-dc-v20241010"
    os                = "windows"
    add_access_config = false
    disksize          = 50
  }

  webserver = {
    zone              = "asia-northeast1-a"
    name              = "vm-web"
    machine_type      = "n1-standard-1"
    subnet_name       = "test"
    tags              = ["server", "windows"]
    labels            = { group = "server-dev" }
    image             = "windows-server-2022-dc-v20241010"
    os                = "windows"
    add_access_config = false
    disksize          = 50
  }

  elk = {
    zone              = "asia-northeast1-a"
    name              = "vm-elk"
    machine_type      = "n1-standard-4"
    subnet_name       = "test"
    tags              = ["elk", "linux"]
    labels            = { group = "elk" }
    image             = "debian-cloud/debian-11"
    os                = "linux"
    add_access_config = true
    disksize          = 300
  }
}
