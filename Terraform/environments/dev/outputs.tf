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
  value = module.vpc.network
}

output "subnets" {
  value = module.vpc.subnets
}

output "subnets2" {
  value = module.vpc.subnets2
}

output "vm_redirector_name" {
  value = module.vm_redirector.instance_name
}

output "vm_redirector_internal_ip" {
  value = module.vm_redirector.internal_ip
}

output "vm_redirector_external_ip" {
  value = module.vm_redirector.external_ip
}

