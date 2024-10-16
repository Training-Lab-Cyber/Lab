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


module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "3.3.0"

  project_id   = var.project
  network_name = var.env
  subnets = [
    for subnet_name in var.subnet_names : {
      subnet_name   = subnet_name
      subnet_ip     = "10.${var.env == "dev" ? 10 : 20}.${10 + (index(var.subnet_names, subnet_name) * 10)}.0/24"
      subnet_region = "us-west1"
    }
  ]
  routes = [
    {
      name              = "egress-internet"
      description       = "route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      tags              = "egress-inet"
      next_hop_internet = "true"
  }, ]
}

resource "google_compute_router" "router" {
  project = var.project
  name    = "nat-router"
  network = module.vpc.network_name
  region  = "us-west1"
}

module "cloud-nat" {
  source                             = "terraform-google-modules/cloud-nat/google"
  version    = "~> 5.0"
  project_id                         = var.project
  region                             = "us-west1"
  name                               = "nat-config"
  router                             = google_compute_router.router.name
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
