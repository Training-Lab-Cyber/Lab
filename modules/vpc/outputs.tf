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


output "redirecter_network" {
  value = module.vpc_redirecter.network_name
}

output "redirecter_subnet" {
  value = element(module.vpc_redirecter.subnets_names, 0)
}

output "C2_network" {
  value = module.vpc_C2.network_name
}

output "C2_subnet" {
  value = element(module.vpc_C2.subnets_names, 0)
}

output "Test_network" {
  value = module.vpc_Test.network_name
}

output "Test_subnet" {
  value = element(module.vpc_Test.subnets_names, 0)
}

output "Phising_network" {
  value = module.vpc_Phising.network_name
}

output "Phising_subnet" {
  value = element(module.vpc_Phising.subnets_names, 0)
}