#!/bin/sh
for start in $(seq 0 100 1000); do
    end=$(($start + 99))

    output_dir=solutions/$start-$end
    mkdir -p $output_dir

    for target_number in $(seq $start $end); do
        output_file=$output_dir/$target_number.tsv
        (set -x; time perl solve.pl $target_number > $output_file)

        # Unjags the TSV file to make GitHub happy.
        max_number_of_tabs=$(perl -MList::Util=max -e 'print max map { tr/\t// } <>' $output_file)
        perl -i -nle 'print $_ . ("\t" x ('$max_number_of_tabs' - tr/\t//))' $output_file
    done
done
