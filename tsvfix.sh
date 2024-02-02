#!/bin/sh
max_number_of_tabs=`perl -MList::Util=max -e 'print max map { tr/\t// } <>' "$@"`
perl -i -nle 'print $_ . ("\t" x ('$max_number_of_tabs' - tr/\t//))' "$@"
