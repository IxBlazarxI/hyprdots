#!/bin/bash

track=$(mpc current)

if [ -n "$track" ]; then
    clean="${track#*/}"
    clean="${clean%.*}"
    echo "$clean" | sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g'
else
    echo ""
fi
