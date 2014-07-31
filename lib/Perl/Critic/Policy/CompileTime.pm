# Copyright (c) 2012, cPanel, Inc.
# All rights reserved.
# http://cpanel.net/
#
# This is free software; you can redistribute it and/or modify it under the same
# terms as Perl itself.  See the LICENSE file for further details.

package Perl::Critic::Policy::CompileTime;

use strict;
use warnings;

use Perl::Critic::Utils qw(:severities :classification :ppi);

use base qw(Perl::Critic::Policy);

use PPIx::PerlCompiler ();

our $VERSION = '0.01';

my $POLICY = 'Global side effects at compile time';

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

sub violates {
    my ( $self, $node, $doc ) = @_;

    return unless $node->isa_prerun_block;

    my @violations;

    $node->find(
        sub {
            my ( $begin_block, $statement ) = @_;

            return 0 unless $statement->isa('PPI::Statement');

            push @violations,
              $self->violation(
                'Performs process image operations',
                $POLICY, $statement
              ) if $statement->performs_process_ops;

            push @violations,
              $self->violation(
                'Assignment to special var',
                $POLICY, $statement
              ) if $statement->mutates_special_var;

            push @violations, $self->violation( 'System I/O', $POLICY, $statement )
              if $statement->performs_system_io;

            return 0;
        }
    );

    return @violations;
}

1;
