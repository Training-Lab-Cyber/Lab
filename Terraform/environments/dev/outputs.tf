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


output "network" {
  value = "${module.vpc.network}"
}

output "redirector_subnet" {
  value = "${module.vpc.subnets.redirector}"
}

output "c2_subnet" {
  value = "${module.vpc.subnets.c2}"
}
output "test_subnet" {
  value = "${module.vpc.subnets.test}"
}

output "phishing_subnet" {
  value = "${module.vpc.subnets.phishing}"
}


output "utils_subnet" {
  value = "${module.vpc.subnets.utils}"
}


output "firewall_rule_http" {
  value = "${module.firewall.firewall_rule_http}"
}

output "http_instance_name" {
  value = "${module.http_server.instance_name}"
}

output "http_internal_ip" {
  value = "${module.http_server.internal_ip}"
}

output "http_external_ip" {
  value = "${module.http_server.external_ip}"
}


output "ansible_instance_name" {
  value = "${module.ansible_server.instance_name}"
}

output "ansible_internal_ip" {
  value = "${module.ansible_server.internal_ip}"
}

output "ansible_external_ip" {
  value = "${module.ansible_server.external_ip}"
}
