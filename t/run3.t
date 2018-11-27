#!/usr/bin/env perl
use strict; use warnings; use feature 'say';
#use Test::Class::Moose;
use Test::Class::Moose::History;
use Test::Class::Moose::Load 't/tests';
use Test::Class::Moose::Runner;

my %opts;
#my $runner = Test::Class::Moose::Runner->new( %opts );
my $runner = Test::Class::Moose::Runner->new( 
    statistics => 1,

    #      include_tags => [qw/api/],
    exclude_tags => [qw/deprecated/],
    test_classes => \@ARGV,);

# get current branch and latest commit id
# example assumes `git`, but you can use any info you need here
chomp( my $branch = `git rev-parse --abbrev-ref HEAD` );
chomp( my $commit = `git rev-parse HEAD` );

$runner->runtests;

my $history = Test::Class::Moose::History->new(
    runner => $runner,
    branch => $branch,
    commit => $commit,
);
$history->save;

# print report of top failures for last 30 days
use Text::Table::Tiny 'generate_table';
my $report   = Test::Class::Moose::History->new->report;
#my $last_test_status = $report->last_test_status;
#foreach my $test (@$last_test_status) {
#            my ( $file, $method, $runtime, $passed ) = @$test;
#            ...
#}
my $failures = $report->top_failures(
    {   days_ago => 30,    # optional
        headers  => 1,
    }
);
say generate_table( rows => $failures, header_row => 1 )
