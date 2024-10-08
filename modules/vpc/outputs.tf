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


output "networks" {
  value = {
    redirector = "${module.vpc-redirector.network_name}"
    c2         = "${module.vpc-c2.network_name}"
    test       = "${module.vpc-test.network_name}"
    phishing   = "${module.vpc-phishing.network_name}"
  }
}

output "subnets" {
  value = {
    redirecter =  "${element(module.vpc-redirector.subnets_names, 0)}"
    c2         = "${element(module.vpc-c2.subnets_names, 0)}"
    test       = "${element(module.vpc-test.subnets_names, 0)}"
    phishing   = "${element(module.vpc-phishing.subnets_names, 0)}"
  }
}