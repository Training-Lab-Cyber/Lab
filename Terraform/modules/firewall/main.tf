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
  network_redirector = "${element(split("-", var.subnet_redirector), 0)}"
  network_utils = "${element(split("-", var.subnet_utils), 0)}"
}

resource "google_compute_firewall" "allow-http-from-internet" {
  name    = "${local.network_redirector}-allow-http"
  network = "${local.network_redirector}"
  project = "${var.project}"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags   = ["http-server"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow-ssh-from-ansible" {
  name    = "${local.network_redirector}-allow-ssh"
  network = "${local.network_redirector}"
  project = "${var.project}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags   = ["http-server"]
  source_ranges = ["${var.ansible_ip}/32"]
}


resource "google_compute_firewall" "allow-ssh-from-iap" {
  name    = "${local.network_utils}-allow-ssh"
  network = "${local.network_utils}"
  project = "${var.project}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags   = ["ansible-server"]
  source_ranges = ["35.235.240.0/20"]
}