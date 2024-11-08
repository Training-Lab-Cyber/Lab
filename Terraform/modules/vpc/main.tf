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



resource "google_compute_network" "vpc" {
}

resource "google_compute_subnetwork" "subnet" {
  project       = var.project
  for_each      = var.subnets
  name          = "${var.vpc_name}-subnet-${each.key}"
  region        = each.value.region
  ip_cidr_range = each.value.cidr
  network       = google_compute_network.vpc.id
}

resource "google_compute_firewall" "firewall_rules" {
  for_each = var.firewall_rules

  project   = var.project
  name      = each.value.name
  network   = google_compute_network.vpc.id
  direction = each.value.direction

  allow {
    protocol = each.value.allow_protocols[0].protocol
    ports    = each.value.allow_protocols[0].ports
  }

  source_ranges      = each.value.direction == "INGRESS" ? each.value.source_ranges : null
  destination_ranges = each.value.direction == "EGRESS" ? each.value.destination_ranges : null

  target_tags = each.value.target_tags
  priority    = each.value.priority
}

