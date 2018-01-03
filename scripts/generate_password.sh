#!/usr/bin/env bash

pwgen -Cs 20 1 | tr -d ' ' | tr -d '\n' | pbcopy
