package Perl::Critic::Policy::CompileTime;

use strict;
use warnings;

use Perl::Critic::Utils qw(:severities :classification :ppi);

use base qw(Perl::Critic::Policy);

our $VERSION = '0.01';

sub supported_parameters {
    return ();
}

sub default_severity {
    return $SEVERITY_HIGH;
}

sub default_themes {
    return qw(more);
}

sub applies_to {
    return 'PPI::Statement::Scheduled';
}

sub find_each_violation {
    my ($self, $node, $test, $message) = @_;

    return unless $node->isa_prerun_block;

    my @violations;

    $node->find(sub {
        my ($begin_block, $statement) = @_;

        return 0 unless $statement->isa('PPI::Statement');

        push @violations, $self->violation(
            $message,
            'No operations with global side effects at compile time',
            $statement
        ) if $test->($statement);
    });

    return @violations;
}

1;
