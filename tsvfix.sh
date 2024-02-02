#!/bin/sh
perl -MList::Util=max -E '@F=<>; $m=max map { (split /\t/)[1] } @F; for(@F){ s/\s+$//; $n=(split /\t/)[1]; say $_ . "\t"x($m-$n) }' "$@"
