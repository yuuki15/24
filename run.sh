#!/bin/sh
for start in $(seq 0 100 1000); do
    end=$(($start + 99))

    start_padded=$(printf '%04d' $start)
    end_padded=$(printf '%04d' $end)

    dir=solutions/$start_padded-$end_padded
    mkdir -p $dir

    for target_number in $(seq -f '%04g' $start $end); do
        out=$dir/$target_number.tsv
        (set -x; time perl solve.pl $target_number > $out)

        # Unjags the TSV file to make GitHub happy.
        max_number_of_tabs=$(perl -MList::Util=max -e 'print max map { tr/\t// } <>' $out)
        perl -i -nle 'print $_ . ("\t" x ('$max_number_of_tabs' - tr/\t//))' $out
    done
done
