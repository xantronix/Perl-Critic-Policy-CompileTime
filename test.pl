#! /usr/bin/perl -Ilib

use strict;
use warnings;

use PPI::Document ();
use PPI::Find     ();

use PPIx::Perlcc ();

use Try::Tiny;

sub usage {
    my ($message) = @_;

    print STDERR "$message\n" if $message;
    print STDERR "usage: $0 file ...\n";

    exit 1;
}

sub scan_file {
    my ($file) = @_;

    my $doc = PPI::Document->new($file);

    return unless $doc;

    $doc->index_locations;
    $doc->prune('PPI::Token::Comment');

    $doc->find(sub {
        my ($top, $node) = @_;

        return 0 unless $node->isa_prerun_block;

        $node->find(sub {
            my ($begin_block, $statement) = @_;

            return 0 unless $statement->isa('PPI::Statement');

            my $report = sub {
                my ($text) = @_;

                print "$text at compile time in file $file at line @{[$statement->line_number]}, column @{[$statement->column_number]}: @{[$statement->concise_string]}\n";

                return;
            };

            try {
                if ($statement->mutates_special_var) {
                    $report->('Assignment to special var');
                }

                if ($statement->performs_system_io) {
                    $report->('Possible I/O');
                }

                if ($statement->performs_process_ops) {
                    $report->('Possible process ops');
                }
            } catch {
                print "Got error $_\n";
            };

            return 0;
        });

        return undef; # Prevent descending into block any further
    });
}

my (@files) = @ARGV;

usage('No input files provided') unless @files;

foreach my $file (@files) {
    scan_file($file);
}
