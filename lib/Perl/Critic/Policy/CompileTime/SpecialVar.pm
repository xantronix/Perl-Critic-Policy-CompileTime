package Perl::Critic::Policy::CompileTime::SpecialVar;

use strict;
use warnings;

use base qw(Perl::Critic::Policy::CompileTime);

sub violates {
    my ($self, $node, $doc) = @_;

    return $self->find_each_violation($node, sub {
        return shift->mutates_special_var
    }, 'Assignment to special var');
}

1;
