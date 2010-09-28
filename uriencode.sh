#!/bin/bash
ENCODED=$(echo -n "$@" | \
perl -pe's/([^-_.~A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg');
echo $ENCODED
