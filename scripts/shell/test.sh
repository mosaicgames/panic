#!/bin/sh

set -e

$HOME/.rokit/bin/rojo build default.project.json --output test.rbxl
python3 scripts/python/upload_and_run_task.py test.rbxl $1
rm test.rbxl