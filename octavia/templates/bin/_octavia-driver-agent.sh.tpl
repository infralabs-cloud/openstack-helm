#!/bin/bash

{{/*
Copyright 2024 Vexxhost Co., Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/}}

set -ex
COMMAND="${@:-start}"

function start () {
  # Ensure the socket directory exists before the agent binds its unix sockets
  # (shared with the API/worker container via the octavia-run emptyDir).
  mkdir -p {{ .Values.conf.driver_agent.socket_dir }}
  exec octavia-driver-agent \
        --config-file /etc/octavia/octavia.conf
}

function stop () {
  kill -TERM 1
}

$COMMAND
