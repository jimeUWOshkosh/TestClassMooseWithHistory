#!/usr/bin/env perl


use Test::Class::Moose::Load 't/tests';
#use Test::Class::Moose::Load qw<t/customer t/order>;
use Test::Class::Moose::Runner;
#      include_tags => [qw/api/],
my $test_suite =Test::Class::Moose::Runner->new( 
      statistics   => 1,
     exclude_tags => [qw/deprecated/],
      test_classes => \@ARGV,
)->runtests->test_report;
