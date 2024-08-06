#!/usr/bin/env bash

tmp_file="/tmp/db_beaver_tmp.sql"
cat $1 > $tmp_file

/Users/paulduvenage/.pyenv/shims/sqlfluff \
	format \
	--dialect redshift \
	--config /Users/paulduvenage/Documents/Check/data/.sqlfluff $tmp_file \
	> /dev/null 2>&1

cat $tmp_file
rm $tmp_file
