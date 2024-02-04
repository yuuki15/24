all:
	set -x; \
	for n in `seq -w 0 24`; do \
	    time perl solve.pl $$n > solutions/$$n.tsv; \
	    sh tsvfix.sh solutions/$$n.tsv; \
	done
