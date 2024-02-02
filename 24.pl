#!/usr/bin/env perl
#
# Lists all "distinct" solutions to the 24 puzzle.
#
# Usage:
# perl 24.pl [number to make=24] [min number to use=1] [max number to use=13]
#
use strict;
use warnings;

my $number_to_make = shift;
if (not defined $number_to_make) {
    $number_to_make = 24;
}

my $min = shift;
if (not defined $min) {
    $min = 1;
}

my $max = shift;
if (not defined $max) {
    $max = 13;
}

my @numbers_to_use = ($min .. $max);

# Loads the `normalize` and `negate` subroutines.
require "./normalize.pl";

# Loads the possible 733 expressions.  Cf.: https://oeis.org/A247982
open my $fh, "<", "expressions.txt" or die $!;
my @expressions = map { s/\s+//g; $_ } <$fh>; # Removes whitespace.
close $fh;

# Iterates over the possible 4-combinations with repetition of numbers.  If 13
# numbers are used, there would be C(13+4-1, 4) = 1820 ways.  Cf.:
# https://mathworld.wolfram.com/Multichoose.html
for my $numbers (combinations_with_repetition(\@numbers_to_use, 4)) {
    my ($a, $b, $c, $d) = @$numbers;

    my @solutions;
    my %seen;

    # Iterates over the expressions.
    for my $expr (@expressions) {
        my $value = eval $expr;

        # Skips if there is a division by zero.
        if ($@) {
            next;
        }

        if ($value eq $number_to_make or $value eq -$number_to_make) {
            # The expression with variables substituted with numbers (but not
            # evaluated).
            my $subst_expr = eval qq("$expr");
            # E.g.:
            #
            # | $a          | 1
            # | $b          | 2
            # | $c          | 3
            # | $d          | 4
            # | $expr       | "(($a*$b)*$c)*$d"
            # | $value      | 24
            # | $subst_expr | "((1*2)*3)*4"

            if ($value < 0) {
                $subst_expr = negate($subst_expr);
                $subst_expr =~ s{ \s+ | ^\( | \)$ }{}gx;
            }

            my $normal_form = normalize($subst_expr);

            if (not exists $seen{$normal_form}) {
                push @solutions, $normal_form;
                $seen{$normal_form} = 1;
            }
        }
    }

    if (@solutions) {
        local $, = "\t";
        local $\ = "\n";
        print join(" ", @$numbers), scalar(@solutions), @solutions;
    }
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
        combinations_with_repetition(\@rest, $k),
    );
}
