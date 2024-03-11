#!/bin/bash

set -euo pipefail

. .venv/bin/activate

ansible-playbook $@