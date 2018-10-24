#!/bin/bash
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# uncomment the following if you want this script to always succeed (no fail)
# exit 0

# uncomment the following if you want this script to always fail (forced failover)
# exit 1

{ (: </dev/tcp/127.0.0.1/80) && (: </dev/tcp/127.0.0.1/443) ; } 2>/dev/null
exit $?
