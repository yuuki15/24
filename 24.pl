#!/usr/bin/env perl
#
# Lists all "distinct" solutions to the 24 puzzle.
#
# Usage:
# perl 24.pl [number to make=24]
#
use strict;
use warnings;

# Loads the `normalize` and `negate` subroutines.
require "./normalize.pl";

my $number_to_make = shift;
if (not defined $number_to_make) {
    $number_to_make = 24;
}

# Loads the possible 733 expressions.  Cf. https://oeis.org/A247982.
open my $fh, "<", "expressions.txt" or die $!;
my @exprs = map { s{\s+}{}g; $_ } <$fh>; # Removes whitespace.
close $fh;

# Iterates over 715 possible combinations of digits.
for my $digits (combinations_with_repetition([0 .. 9], 4)) {
    my ($a, $b, $c, $d) = @$digits;

    my @solutions;
    my %seen;

    # Iterates over the expressions.
    for my $expr (@exprs) {
        my $value = eval $expr;

        # In case of division by zero, silently continues to the next
        # expression.
        if ($@) {
            next;
        }

        if ($value eq $number_to_make or $value eq -$number_to_make) {
            my $subst_expr = eval qq("$expr");
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
        print join("", @$digits), scalar(@solutions), @solutions;
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
        combinations_with_repetition([@rest], $k),
    );
}
