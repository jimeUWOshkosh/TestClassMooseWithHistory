#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';

use Test::Builder;
use Test::Class::Moose::Load 't/tests';
use Test::Class::Moose::Runner;
use Test::Class::Moose::History;
use Text::Table::Tiny 'generate_table';
use Getopt::Long;
use Carp 'croak';

our $VERSION = '0.01';

my $report = Test::Class::Moose::History::Report->new;

my %report_methods = (
    last_test_status => [qw/Class Method Runtime Passed/],
    last_failures    => [qw/Class Method/],
    top_failures     => [qw/class test first last errs/],
);
my $last_failures = $report->last_failures;
my @rows = ( $report_methods{last_failures}, @{$last_failures} );
say generate_table( rows => \@rows, header_row => 1 );

my $last_test_status = $report->last_test_status;
@rows = ( $report_methods{last_test_status}, @{$last_test_status} );
say generate_table( rows => \@rows, header_row => 1 );

my $failures = $report->top_failures( { days_ago => 30, headers => 1, } );
say generate_table( rows => $failures, header_row => 1 );
$report->_dbh->disconnect();
exit 0;
