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


variable "project" {}
variable "public_key_path" {}

variable "subnets" {
  type = map(object({
    region = string
    cidr   = string
  }))
}
variable "vm_configs" {
  type = map(object({
    name   = string
    subnet_name   = string
    zone   = string
    machine_type   = string
    image = string
    tags = list(string)
  labels = map(string)
  add_access_config = bool
  }))
}


variable "firewall_rules" {
  type = map(object({
    name            = string
    direction       = string    # INGRESS or EGRESS
    allow_protocols = list(object({
      protocol = string
      ports    = list(string)
    }))
    source_ranges   = list(string)    # For ingress rules
    destination_ranges = list(string) # For egress rules
    target_tags     = list(string)    # Optional, to target specific instances
    priority           = number  # Default priority is 1000
  }))
}
