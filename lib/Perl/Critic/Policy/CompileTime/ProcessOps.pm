package Perl::Critic::Policy::CompileTime::ProcessOps;

use strict;
use warnings;

use base qw(Perl::Critic::Policy::CompileTime);

sub violates {
    my ($self, $node, $doc) = @_;

    return $self->find_each_violation($node, sub {
        return shift->performs_process_ops
    }, 'Possible process operations');
}

1;
