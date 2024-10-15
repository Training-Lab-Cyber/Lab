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
  env = "dev"
}

provider "google" {
  project = var.project
  version = ">= 4.51.0, < 7.0.0"
}

module "vpc" {
  source  = "../../modules/vpc"
  project = var.project
  env     = local.env
  subnet_names = [
    "${local.env}-subnet-c2",
    "${local.env}-subnet-phishing",
    "${local.env}-subnet-redirector",
    "${local.env}-subnet-test",

  ]
}

module "vm_redirector" {
  source          = "../../modules/vm_redirector"
  project         = var.project
  public_key_path = var.public_key_path
  subnet          = module.vpc.subnets["${local.env}-subnet-redirector"]
}


module "vm_c2" {
  source          = "../../modules/vm_c2"
  project         = var.project
  public_key_path = var.public_key_path
  subnet          = module.vpc.subnets["${local.env}-subnet-c2"]
}


module "firewall" {
  source            = "../../modules/firewall"
  project           = var.project
  subnet_redirector = module.vpc.subnets["${local.env}-subnet-redirector"]
  subnet_c2         = module.vpc.subnets["${local.env}-subnet-c2"]
}
