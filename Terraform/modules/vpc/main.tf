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
  name                    = var.env
  project                 = var.project
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  project      = var.project
  for_each      = var.subnets
  name          = "${var.env}-subnet-${each.key}"            
  region        = each.value.region
  ip_cidr_range = each.value.cidr
  network       = google_compute_network.vpc.id
}

resource "google_compute_router" "router" {
  project = var.project
  name    = "nat-router"
  network       = google_compute_network.vpc.id
  region  = "us-west1"
}

module "cloud-nat" {
  source                             = "terraform-google-modules/cloud-nat/google"
  version    = "~> 5.0"
  project_id                         = var.project
  region                             = "us-west1"
  name                               = "nat-config"
  router                             = google_compute_router.router.id
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
