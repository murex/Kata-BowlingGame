#!/usr/bin/env bash

# Utility script running "php -lf" on every php file under src and tests directories
# This is to overcome the limitation of php command being able to check only 1 file

find ./src ./tests -name "*.php" -print0 | xargs -0 -n1 -P8 php -lf
