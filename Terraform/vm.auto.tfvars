vm_configs = {
  c2 = {
    zone              = "asia-northeast1-a"
    name              = "vm-c2"
    machine_type      = "n1-standard-2"
    subnet_name       = "c2"
    tags              = ["c2", "linux"]
    labels            = { group = "c2" }
    image             = "debian-cloud/debian-11"
    os                = "linux"
    add_access_config = false
    disksize          = 100
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

  bastion = {
    zone              = "asia-northeast1-a"
    name              = "vm-bastion"
    machine_type      = "n1-standard-1"
    subnet_name       = "test"
    tags              = ["bastion", "windows"]
    labels            = { group = "bastion" }
    image             = "windows-server-2022-dc-v20241010"
    os                = "windows"
    add_access_config = true
    disksize          = 50
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
