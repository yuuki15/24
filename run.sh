#!/bin/sh
for start in $(seq 0 100 1000); do
	end=$(($start + 99))

	start_padded=$(printf '%04d' $start)
	end_padded=$(printf '%04d' $end)

	dir=solutions-test/$start_padded-$end_padded
	mkdir -p $dir

	for n in $(seq -f '%04g' $start $end); do
		out=$dir/$n.tsv
		(set -x; time perl solve.pl $n 0 1 > $out)

		# Unjags the TSV file to make GitHub happy.  Cf.
		# https://docs.github.com/en/repositories/working-with-files/using-files/working-with-non-code-files#rendering-csv-and-tsv-data
		max_number_of_tabs=$(perl -MList::Util=max -e 'print max map { tr/\t// } <>' $out)
		perl -i -nle 'print $_ . ("\t" x ('$max_number_of_tabs' - tr/\t//))' $out
	done
done
