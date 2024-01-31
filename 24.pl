#!/usr/bin/env perl
use strict;
use warnings;

for my $combination (combinations_with_repetition([0 .. 9], 4)) {
    print "@$combination\n";
}

# Generates the k-combinations with repetition of an array, like Python's
# `itertools.combinations_with_replacement` or Ruby's
# `Array#repeated_combination`.
sub combinations_with_repetition {
    my ($array, $k) = @_;

    if ($k == 0) {
        return ([]);
    }

    if (@$array == 0) {
        return ();
    }

    my ($first, @rest) = @$array;
    return (
        (map { [$first, @$_] } combinations_with_repetition($array, $k - 1)),
        combinations_with_repetition([@rest], $k),
    );
}
