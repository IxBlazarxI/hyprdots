#!/bin/bash
# Get CPU temperature
sensors | awk '/^Tctl:/ {print int($2)}'

