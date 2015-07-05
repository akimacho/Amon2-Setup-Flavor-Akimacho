#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Amon2::Setup::Flavor::Akimacho' ) || print "Bail out!\n";
}

diag( "Testing Amon2::Setup::Flavor::Akimacho $Amon2::Setup::Flavor::Akimacho::VERSION, Perl $], $^X" );
