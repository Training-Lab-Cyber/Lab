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



resource "google_compute_instance" "vm" {
  for_each = var.vm_configs
  project      = var.project
  zone         = each.value.zone
  name         = each.value.name
  machine_type = each.value.machine_type
  tags =  each.value.tags
  labels = each.value.labels

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

  
  metadata = {
    ssh-keys = "ansible:${file(var.public_key_path)}"
  }
  metadata_startup_script = <<-EOT
    #!/bin/bash
    useradd -m -s /bin/bash ansible
    echo 'ansible ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
  EOT

}
