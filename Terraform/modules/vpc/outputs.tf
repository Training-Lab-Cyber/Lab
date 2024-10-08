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
  value = "${module.vpc.network_name}"
}

output "subnets" {
  value = {
    c2         = "${element(module.vpc.subnets_names, 0)}"
    redirector = "${element(module.vpc.subnets_names, 1)}"
    test       = "${element(module.vpc.subnets_names, 2)}"
    phishing   = "${element(module.vpc.subnets_names, 3)}"
    utils      = "${element(module.vpc.subnets_names, 4)}"
  }
}