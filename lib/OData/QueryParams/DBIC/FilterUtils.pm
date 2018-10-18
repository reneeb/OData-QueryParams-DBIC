package OData::QueryParams::DBIC::FilterUtils;

# ABSTRACT: Utilities to parse filter param

use v5.20;

use strict;
use warnings;

use parent 'Exporter';

use feature 'signatures';
no warnings 'experimental::signatures';

use Data::Printer;

our @EXPORT = qw(match);

our %CAPTURES;
my $GRAMMAR = qr!
  (?(DEFINE)
      (?<binops> eq|ne|gt|ge|lt|le|and|or|add|sub|mul|div|mod)
      (?<unops>  not)
      (?<funcname> endswith|substringof|startswith)
      (?<string> (?<quote>["']).*?(?&quote))
      (?<function>
          (?&funcname)
          \(
              (?: (?&word) | (?&string) )
              ,
              (?: (?&word) | (?&string) )
              (?:
                  ,
                  (?: (?&word) | (?&string) )
              )?
          \)
      )
      (?<word>   [a-zA-Z0-9_\/\.]+)
      (?<filter> 
          \A
          (?:
              (?<lop>(?&word)) |
              (?<lfunc>(?&function))
          )
          \s+ (?<op>(?&binops)) \s+
          (?:
              (?<rop>(?&word)) |
              (?<rfunc>(?&function))
          )
          (?:
              \s+
              (?<sop>(?&binops))
              \s+
              (?:
                  (?<lastop>(?&word)) |
                  (?<lastfunc>(?&function))
              )
          )*?
          \z
          (?{ %CAPTURES = %+ })
      )
  )
  (?&filter)
!xms;

sub match ( $string ) {
    local %CAPTURES;

    my $success = $string =~ $GRAMMAR;
    return %CAPTURES;
}

1;

__END__


