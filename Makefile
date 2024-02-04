all:
	set -x; \
	for n in `seq -w 0 24`; do \
	    time perl 24.pl $$n > $$n.tsv; \
	    sh tsvfix.sh $$n.tsv; \
	done
