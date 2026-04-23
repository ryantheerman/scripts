#!/bin/bash

# this script will provide awareness of which network we're on in broad strokes
# it boils down to...
    # we're on the home network or
    # we're not on the home network
# it will be used when sshing (or auto sshing) to remote machines for administrative purposes, or for rsyncing, or for connecting to my irssi session, and for whatever else i end up needing it for.

# if the passed in hostname has an ip on any of the 10, 20, or 30 subnets, we echo "true" to indicate confidence that we are on the home network. else we echo false.
# then the calling scripts can simply use that boolean to route down the correct path.

#getent hosts $1 | grep -qE "192\.168\.10\.|192\.168\.20\.|192\.168\.30\." # && echo "true" || echo "false"
ip route | grep -q "192\.168\.30\."
#^ the && echo part is not really necessary. the quiet flag on grep handles exiting with a 0 status if a match was found or a 1 status if no match was found.
# i can check the status in the calling script for pathing
