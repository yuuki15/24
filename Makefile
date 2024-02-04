all:
	set -x; \
	for n in `seq -w 0 1000`; do \
	    out=solutions/$$n.tsv; \
	    time perl solve.pl $$n 0 1 > $$out; \
	    sh tsvfix.sh $$out; \
	done
