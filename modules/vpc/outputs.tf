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


output "c2_network" {
  value = "${module.vpc_c2.network_name}"
}

output "c2_subnet" {
  value = "${element(module.vpc_c2.subnets_names, 0)}"
}

output "redirecter_network" {
  value = "${module.vpc_redirecter.network_name}"
}

output "redirecter_subnet" {
  value = "${element(module.vpc_redirecter.subnets_names, 0)}"
}


output "test_network" {
  value = "${module.vpc_test.network_name}"
}

output "test_subnet" {
  value = "${element(module.vpc_test.subnets_names, 0)}"
}

output "phising_network" {
  value = "${module.vpc_phising.network_name}"
}

output "phising_subnet" {
  value = "${element(module.vpc_phising.subnets_names, 0)}"
}
