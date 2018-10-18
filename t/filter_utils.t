#!/usr/bin/env perl

use v5.20;

use strict;
use warnings;

use Test::More;
use OData::QueryParams::DBIC::FilterUtils;

use Data::Printer;

my %tests = (
    "Price mod 2 eq 0"                                         =>
        {
            lastop =>  0,
            lop =>     "Price",
            op =>      "mod",
            rop =>     2,
            sop =>     "eq"
        },
    "Price div 2 gt 4"                                         =>
        {
            lastop =>  4,
            lop =>     "Price",
            op =>      "div",
            rop =>     2,
            sop =>     "gt"
        },
    "Price mul 2 gt 2000"                                      =>
        {
            lastop =>  2000,
            lop =>     "Price",
            op =>      "mul",
            rop =>     2,
            sop =>     "gt"
        },
    "Price sub 5 gt 10"                                        =>
        {
            lastop =>  10,
            lop =>     "Price",
            op =>      "sub",
            rop =>     5,
            sop =>     "gt"
        },
    "Price add 5 gt 10"                                        => 
        {
            lastop =>  10,
            lop =>     "Price",
            op =>      "add",
            rop =>     5,
            sop =>     "gt"
        },
    "Price le 3.5 or Price gt 200"                             =>
        {
            lastop =>  200,
            lop =>     "Price",
            op =>      "le",
            rop =>     3.5,
            sop =>     "gt"
        },
    "Price le 200 and Price gt 3.5"                            =>
        {
            lastop =>  3.5,
            lop =>     "Price",
            op =>      "le",
            rop =>     200,
            sop =>     "gt"
        },
    "Price le 100"                                             =>
        {
            lop =>  "Price",
            op =>   "le",
            rop =>  100
        },
    "Price lt 20"                                              =>
        {
            lop =>  "Price",
            op =>   "lt",
            rop =>  20
        },
    "Price ge 10"                                              =>
        {
            lop =>  "Price",
            op =>   "ge",
            rop =>  10
        },
    "Price gt 20"                                              =>
        {
            lop =>  "Price",
            op =>   "gt",
            rop =>  20
        },
    "Address/City ne 'London'"                                 => {},
    "Address/City eq 'Redmond'"                                => {},
    "substringof('Alfreds', CompanyName) eq true"  => {},
    "endswith(CompanyName, 'Futterkiste') eq true" => {},
    "startswith(CompanyName, 'Alfr') eq true"      => {},
);


for my $filter ( sort keys %tests ) {
    my %vars = match( $filter );
    p %vars;
    is_deeply \%vars, $tests{$filter};
}

done_testing();
