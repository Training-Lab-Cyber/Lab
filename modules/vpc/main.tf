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



# VPCモジュールの呼び出し
module "vpc_redirecter" {
  source  = "terraform-google-modules/network/google"
  version = "3.3.0"

  project_id   = var.project
  network_name = "${var.env}_redirector"

  subnets = [
    {
      subnet_name   = "${var.env}_redirector-subnet-01"
      subnet_ip     = "10.${var.env == "dev" ? 10 : 20}.0.0/24"
      subnet_region = "us-west1"
    },
  ]

  secondary_ranges = {
    "${var.env}_redirector-subnet-01" = []
  }
}

module "vpc_c2" {
  source  = "terraform-google-modules/network/google"
  version = "3.3.0"

  project_id   = var.project
  network_name = "${var.env}_c2"

  subnets = [
    {
      subnet_name   = "${var.env}_c2-subnet-01"
      subnet_ip     = "10.${var.env == "dev" ? 10 : 20}.1.0/24"
      subnet_region = "us-west1"
    },
  ]

  secondary_ranges = {
    "${var.env}_c2-subnet-01" = []
  }
}

module "vpc_test" {
  source  = "terraform-google-modules/network/google"
  version = "3.3.0"

  project_id   = var.project
  network_name = "${var.env}_test"

  subnets = [
    {
      subnet_name   = "${var.env}_test-subnet-01"
      subnet_ip     = "10.${var.env == "dev" ? 10 : 20}.2.0/24"
      subnet_region = "us-west1"
    },
  ]

  secondary_ranges = {
    "${var.env}_test-subnet-01" = []
  }
}

module "vpc_phising" {
  source  = "terraform-google-modules/network/google"
  version = "3.3.0"

  project_id   = var.project
  network_name = "${var.env}_phising"

  subnets = [
    {
      subnet_name   = "${var.env}_phising-subnet-01"
      subnet_ip     = "10.${var.env == "dev" ? 10 : 20}.3.0/24"
      subnet_region = "us-west1"
    },
  ]

  secondary_ranges = {
    "${var.env}_phising-subnet-01" = []
  }
}