#!/usr/bin/env perl
#
# Normalizes an expression that represents a solution to the 24 puzzle.
#
# Usage:
# perl normalize.pl [EXPR1] [EXPR2] ...
#
use strict;
use warnings;
my $VERBOSE = 0;

#
# Regular expressions.
#

# A number.
my $NUMBER   = qr{ \d+ }x;

# An operator.
my $OPERATOR = qr{ [+\-*/] }x;
my $OP       = qr{ (?<OP> $OPERATOR ) }x;

# An expression.
my $EXPR = qr{
    (
        $NUMBER
        |
        \( (?-1) $OPERATOR (?-1) \)
    )
}x;
my $A = qr{ (?<A> $EXPR ) }x;
my $B = qr{ (?<B> $EXPR ) }x;

# An expression whose value is 0.
my $ZERO_EXPR = qr{
    ( $EXPR )
    (?(?{ eval($^N) eq 0 }) | (*FAIL) )
}x;
my $ZERO = qr{ (?<ZERO> $ZERO_EXPR ) }x;

#
# Rewrite rules.
#
my @rules = (
    # Subtraction by zero to addition.
    # "A-0=>A+0" => [ qr{ $A - $ZERO }x => sub { "$+{A} + $+{ZERO}" } ],
);

# Returns the normal form of an expression.
sub normalize {
    my ($expr) = @_;
    $expr =~ s{\s+}{}g; # Removes whitespace.

    for (my $i = 0; $i < @rules; $i += 2) {
        my ($pattern, $replace) = @{$rules[$i + 1]};

        while ($expr =~ s{$pattern}{$replace->()}eg) {
            $expr =~ s{\s+}{}g;
            if ($VERBOSE) { warn "=> $expr\t$rules[$i]\n" }
        }
    }

    return $expr;
}

# Returns the additive inverse of a negative expression.  The result is in a
# form without unary minus.
sub negate {
    my ($expr) = @_;
    $expr =~ s{\s+}{}g;
    if (not $expr =~ m{ $A $OP $B }x) {
        return $expr;
    }
    my ($a, $op, $b) = ($+{A}, $+{OP}, $+{B});

    # a - b => (b - a)
    if ($op eq "-") {
        return "($b $op $a)";
    }

    # a + b =>
    #     ((-a) - b) if a < 0
    #     ((-b) - a) if b < 0
    if ($op eq "+") {
        return eval($a) < 0
            ? "(" . negate($a) . "- $b)"
            : "(" . negate($b) . "- $a)";
    }

    # a * b =>
    #     ((-a) * b) if a < 0
    #     (a * (-b)) if b < 0
    #
    # a / b =>
    #     ((-a) / b) if a < 0
    #     (a / (-b)) if b < 0
    return eval($a) < 0
        ? "(" . negate($a) . "$op $b)"
        : "($a $op" . negate($b) . ")";
}

if (not caller) {
    $VERBOSE = 1;
    for my $expr (@ARGV) {
        warn "$expr\n";
        print normalize($expr), "\n";
        warn "\n";
    }
}

1;
