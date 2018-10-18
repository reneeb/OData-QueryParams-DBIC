#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use OData::QueryParams::DBIC;

my %tests = (
    "filter=substringof('Alfreds', CompanyName) eq true"  => {},
    "filter=endswith(CompanyName, 'Futterkiste') eq true" => {},
    "filter=startswith(CompanyName, 'Alfr') eq true"      => {},
    "filter=length(CompanyName) eq 19"                    => {},
    "filter=indexof(CompanyName, 'lfreds') eq 1"          => {},
    "filter=replace(CompanyName, ' ', '') eq 'AlfredsFutterkiste'" => {},
    "filter=substring(CompanyName, 1) eq 'lfreds Futterkiste'"     => {},
    "filter=substring(CompanyName, 1, 2) eq 'lf'"                  => {},
    "filter=tolower(CompanyName) eq 'alfreds futterkiste'"         => {},
    "filter=toupper(CompanyName) eq 'ALFREDS FUTTERKISTE'"         => {},
    "filter=trim(CompanyName) eq 'Alfreds Futterkiste'"            => {},
    "filter=concat(concat(City, ', '), Country) eq 'Berlin, Germany'" => {},
    "filter=day(BirthDate) eq 8"                                      => {},
    "filter=hour(BirthDate) eq 0"                                     => {},
    "filter=minute(BirthDate) eq 0"                                   => {},
    "filter=month(BirthDate) eq 12"                                   => {},
    "filter=filter=second(BirthDate) eq 0"                            => {},
    "filter=year(BirthDate) eq 1948"                                  => {},
    "filter=round(Freight) eq 32d"                                    => {},
    "filter=round(Freight) eq 32"                                     => {},
    "filter=floor(Freight) eq 32d"                                    => {},
    "filter=floor(Freight) eq 32"                                     => {},
    "filter=ceiling(Freight) eq 33d"                                  => {},
    "filter=ceiling(Freight) eq 33"                                   => {},
    "filter=isof('NorthwindModel.Order')"                             => {},
    "filter=isof(ShipCountry, 'Edm.String')"                          => {},
    "filter=(Price sub 5) gt 10"                                      => {},
    "filter=Price mod 2 eq 0"                                         => {},
    "filter=Price div 2 gt 4"                                         => {},
    "filter=Price mul 2 gt 2000"                                      => {},
    "filter=Price sub 5 gt 10"                                        => {},
    "filter=Price add 5 gt 10"                                        => {},
    "filter=not endswith(Description,'milk')"                         => {},
    "filter=Price le 3.5 or Price gt 200"                             => {},
    "filter=Price le 200 and Price gt 3.5"                            => {},
    "filter=Price le 100"                                             => {},
    "filter=Price lt 20"                                              => {},
    "filter=Price ge 10"                                              => {},
    "filter=Price gt 20"                                              => {},
    "filter=Address/City ne 'London'"                                 => {},
    "filter=Address/City eq 'Redmond'"                                => {},
);

for my $query_string ( sort keys %tests ) {
    my $result = params_to_dbic( $query_string );
    is_deeply $result, $tests{$query_string}, 'Query: ' . $query_string;
}

done_testing();
