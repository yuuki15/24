#!/bin/sh
m=`perl -MList::Util=max -e 'print max map { (split /\t/)[1] } <>' "$@"`
perl -i -nle 's/\t+$//; $n=(split /\t/)[1]; print $_ . "\t"x('$m'-$n)' "$@"
