#!/usr/bin/env bash

# /Users/paulduvenage/.config/sqruff-dbeaver-updated.sh

cat $1 /opt/homebrew/bin/sqruff \
    fix \
    - \
    --force \
	--config /Users/paulduvenage/Documents/Check/data/.sqlfluff_local.cfg
