# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

locals {
  windows_metadata_startup_script = <<-EOT
    $username = "ansible"
    $password = ConvertTo-SecureString "StrongPassword123!" -AsPlainText -Force
    $user = New-LocalUser $username -Password $password -FullName "Ansible User" -Description "Ansible management user"
    Add-LocalGroupMember -Group "Administrators" -Member $username

    $sshDir = "C:\\Users\\ansible\\.ssh"
    New-Item -ItemType Directory -Force -Path $sshDir
    $publicKey = "${file(var.public_key_path)}"
    Set-Content -Path "$sshDir\\authorized_keys" -Value $publicKey
    icacls $sshDir /inheritance:r
    icacls $sshDir /grant:r ansible:F
    icacls "$sshDir\\authorized_keys" /inheritance:r
    icacls "$sshDir\\authorized_keys" /grant:r ansible:F

    Start-Service sshd
    Set-Service -Name sshd -StartupType 'Automatic'

    $sshdConfigPath = "C:\\ProgramData\\ssh\\sshd_config"
    (Get-Content $sshdConfigPath) -replace '#PasswordAuthentication yes', 'PasswordAuthentication no' | Set-Content $sshdConfigPath
    Restart-Service sshd

    Remove-LocalGroupMember -Group "Remote Desktop Users" -Member $username

    $userSid = (New-Object System.Security.Principal.NTAccount($username)).Translate([System.Security.Principal.SecurityIdentifier]).Value
    secedit /export /cfg C:\\Windows\\Temp\\secpol.cfg
    (Get-Content C:\\Windows\\Temp\\secpol.cfg) -replace 'SeDenyInteractiveLogonRight =', 'SeDenyInteractiveLogonRight = $userSid' | Set-Content C:\\Windows\\Temp\\secpol.cfg
    secedit /configure /db secedit.sdb /cfg C:\\Windows\\Temp\\secpol.cfg /quiet

    New-NetFirewallRule -Name sshd -DisplayName "OpenSSH Server (sshd)" -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22

  EOT

  linux_metadata_startup_script = <<-EOT
    #!/bin/bash
    useradd -m -s /bin/bash ansible
    echo 'ansible ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
  EOT
}

resource "google_compute_instance" "vm" {
  for_each     = var.vm_configs
  project      = var.project
  zone         = each.value.zone
  name         = each.value.name
  machine_type = each.value.machine_type
  tags         = each.value.tags
  labels       = each.value.labels

  boot_disk {
    initialize_params {
      image = each.value.image
    }
  }

  network_interface {
    subnetwork = var.subnet_ids[each.value.subnet_name]
    dynamic "access_config" {
      for_each = each.value.add_access_config ? [1] : []
      content {}
    }
  }

  metadata = each.value.os == "windows" ? null : {
    ssh-keys = "ansible:${file(var.public_key_path)}"
  }

  metadata_startup_script = each.value.os == "windows" ? locals.windows_metadata_startup_script : locals.linux_metadata_startup_script
}
