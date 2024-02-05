# 24

[Mint](https://min.togetter.com/eKWLarx)

This is a Perl script to list "distinct" solutions to the [24 puzzle](https://en.wikipedia.org/wiki/24_(puzzle)).  The lists of solutions to each *N* puzzle are organized in the [solutions](solutions) directory and are licensed under [CC0](https://creativecommons.org/publicdomain/zero/1.0/).

* [Solutions to 24](solutions/0-99/24.tsv)
* [Solutions to 10](solutions/0-99/10.tsv)

## History

* -2013: Learned about the 10 puzzle (a variation popular in Japan).
* 2018-08: Published an [article](http://archive.today/2018.08.25-001836/http://konno.co.nf/%E3%83%86%E3%83%B3%E3%83%91%E3%82%BA%E3%83%AB) (in Japanese) on a naive solver in Ruby.
* 2022-07: Realized that eliminating duplicate solutions could not be done with a CAS such as SymPy and started my research.
* 2022-09: Finished writing the script and failed to solve the 0 puzzle.
* 2023-01: Abandoned the research and archived the results on [24-puzzle-solver/24-puzzle-solver](https://github.com/24-puzzle-solver/24-puzzle-solver).
* 2024-02: Reorganized the results in this repo, essentially unchanged.
