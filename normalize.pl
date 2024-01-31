#!/usr/bin/env perl
use strict;
use warnings;
my $DEBUG = 1;

my @rules;

# Returns the normal form of an expression.
sub normalize {
    my ($expr) = @_;
    $expr =~ s/\s+//g; # Removes whitespace.

    for (my $i = 0; $i < @rules; $i += 2) {
        my ($rule, $pattern, $replace) = ($rules[$i], @{$rules[$i + 1]});
        while ($expr =~ s/$pattern/$replace->()/eg) {
            $expr =~ s/\s+//g;
            $DEBUG and warn "=> $expr\t$rule\n";
        }
    }

    return $expr;
}

# Regular expressions
my $NUMBER   = qr{ \d+ }x;

my $OPERATOR = qr{ [+\-*/] }x;
my $OP       = qr{ (?<OP> $OPERATOR ) }x;

my $EXPR = qr{
    (
        $NUMBER
        |
        \( (?-1) $OPERATOR (?-1) \)
    )
}x;
my $A = qr{ (?<A> $EXPR ) }x;
my $B = qr{ (?<B> $EXPR ) }x;

my $ZERO_EXPR = qr{
    ( $EXPR )
    (?(?{ eval($^N) == 0 }) | (*FAIL))
}x;
my $ZERO = qr{ (?<ZERO> $ZERO_EXPR ) }x;

# Rewrite rules
@rules = (
    # Subtraction by zero to addition
    'A-0=>A+0' => [
        qr{ $A - $ZERO }x,
        sub { "$+{A} + $+{ZERO}" },
    ],
);

# Returns the additive inverse of a negative expression.  The result is in a
# form without unary minus.
sub negate {
    my ($expr) = @_;
    $expr =~ m{ $A $OP $B }x or return $expr;
    my ($a, $op, $b) = ($+{A}, $+{OP}, $+{B});

    # -(a - b) => (b - a)
    if ($op eq '-') {
        return "($b $op $a)";
    }

    # -(a + b) =>
    #     ((-a) - b) if a < 0
    #     ((-b) - a) if b < 0
    if ($op eq '+') {
        return eval($a) < 0
            ? '(' . negate($a) . "- $b)"
            : '(' . negate($b) . "- $a)";
    }

    # -(a * b) =>
    #     ((-a) * b) if a < 0
    #     (a * (-b)) if b < 0
    #
    # -(a / b) =>
    #     ((-a) / b) if a < 0
    #     (a / (-b)) if b < 0
    return eval($a) < 0
        ? '(' . negate($a) . "$op $b)"
        : "($a $op" . negate($b) . ')';
}

if (not caller) {
    for my $expr ('((1+2)+3)-0') {
        warn "$expr\n";
        print normalize($expr), "\n";
        warn "\n";
    }
}

1;
