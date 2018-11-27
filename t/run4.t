#!/usr/bin/env perl
use strict; use warnings; use feature 'say';
use Test::Class::Moose::History;
use Test::Class::Moose::Load 't/tests';
use Test::Class::Moose::Runner;

my $runner = Test::Class::Moose::Runner->new( 
    statistics => 1,
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

use Text::Table::Tiny 'generate_table';
my $report   = Test::Class::Moose::History->new->report;
my $failures = $report->top_failures(
    {   days_ago => 30,    # optional
        headers  => 1,
    }
);
exit 0;
say generate_table( rows => $failures, header_row => 1 )
