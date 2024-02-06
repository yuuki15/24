# 24

[Mint](https://min.togetter.com/eKWLarx)

This is a Perl script to list "distinct" solutions to the [24 puzzle](https://en.wikipedia.org/wiki/24_(puzzle)).  The lists of solutions to each N puzzle are organized in the [solutions](solutions) directory and are licensed under [CC0](https://creativecommons.org/publicdomain/zero/1.0/).

* [Solutions to 24](solutions/0-99/24.tsv)
* [Solutions to 10](solutions/0-99/10.tsv)

## Bibliography

* [4nums.com](https://www.4nums.com/) (2012).
    * A [theory](https://www.4nums.com/theory/) and a [web service](https://www.4nums.com/solutions/100/) that returns distinct solutions to a.b.c.d = N, where 1 <= a, b, c, d <= 99 and 1 <= N <= 9999.
* [auntyellow/24](https://github.com/auntyellow/24) (2017).
    * Solvers written in JavaScript and Java.
* Azuma, Seiichi (2014).  ["Expressions with n variables"](https://searial.web.fc2.com/math/sisoku.html).
    * An algorithm for generating inequivalent expressions.
* Dominus, Mark Jason (2017).  ["Recognizing when two arithmetic expressions are essentially the same"](https://blog.plover.com/math/24-puzzle-2.html).
    * The Ezpr data structure and a [solver](https://github.com/mjdominus/24-puzzle-solver) written in Perl.
* Fan, Mei Hui (2022).  [mhfan/inrust](https://github.com/mhfan/inrust).
    * Solvers written in Rust and C++.
* Yuuki (2018).  ["Ten puzzle"](https://archive.today/2018.08.25-001836/http://konno.co.nf/%E3%83%86%E3%83%B3%E3%83%91%E3%82%BA%E3%83%AB) (in Japanese).
    * Remarks on (super-)Catalan numbers.
* OEIS
    * Du, Zhao Hui (2008).  [A140606](https://oeis.org/A140606) (Number of inequivalent expressions involving n operands).
    * Radcliffe, David (2012).  [A182173](https://oeis.org/A182173) (allowing unary minus).
    * Azuma, Seiichi (2014).  [A247982](https://oeis.org/A247982) (ignoring sign).
    * Dushoff, Jonathan (2022).  [A351922](https://oeis.org/A351922) (allowing exponentiation).

## History

<details>
<summary>[show]</summary>

* -2013: Learned about the 10 puzzle (a variation popular in Japan).
* 2022-07: Realized that eliminating duplicate solutions could not be done with a CAS such as SymPy and started the research.
* 2022-09: Finished writing the script and failed to solve the [0 puzzle](solutions/0-99/0.tsv).
* 2023-01: Abandoned the research and archived the results on [24-puzzle-solver/24-puzzle-solver](https://github.com/24-puzzle-solver/24-puzzle-solver).
* 2024-02: Reorganized the results in this repo, essentially unchanged.

</details>
