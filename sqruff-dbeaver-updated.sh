#!/usr/bin/env bash

cat $1 /Users/paulduvenage/.pyenv/shims/sqruff \
    fix \
    - \
    --force \
	--config /Users/paulduvenage/Documents/Check/data/.sqlfluff
