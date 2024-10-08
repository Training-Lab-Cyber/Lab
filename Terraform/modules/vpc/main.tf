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

  project_id   = "${var.project}"
  network_name = "${var.env}"

  subnets = [
    {
      subnet_name   = "${var.env}-subnet-c2"
      subnet_ip     = "10.${var.env == "dev" ? 10 : 20}.10.0/24"
      subnet_region = "us-west1"
    },{
      subnet_name   = "${var.env}-subnet-redirector"
      subnet_ip     = "10.${var.env == "dev" ? 10 : 20}.20.0/24"
      subnet_region = "us-west1"
    },{
      subnet_name   = "${var.env}-subnet-test"
      subnet_ip     = "10.${var.env == "dev" ? 10 : 20}.30.0/24"
      subnet_region = "us-west1"
    },{
      subnet_name   = "${var.env}-subnet-phishing"
      subnet_ip     = "10.${var.env == "dev" ? 10 : 20}.40.0/24"
      subnet_region = "us-west1"
    },{
      subnet_name   = "${var.env}-subnet-utils"
      subnet_ip     = "10.${var.env == "dev" ? 10 : 20}.100.0/24"
      subnet_region = "us-west1"
    },
  ]

}