package PPIx::Perlcc::Element;

use strict;
use warnings;

BEGIN {
    require PPI::Element;

    push @PPI::Element::ISA, __PACKAGE__;
}

sub non_whitespace_child {
    my ($self, $index) = @_;

    my $child;
    my $count = 0;

    foreach my $child (@{$self->{'children'}}) {
        next if $child->isa('PPI::Token::Whitespace');

        if ($count++ == $index) {
            return $child;
        }
    }

    return;
}

sub matches {
    my ($self, $type, $expected) = @_;

    return 0 unless $self->isa($type);

    if ($expected) {
        my $content = $self->{'content'};

        if (ref($expected) eq 'Regexp') {
            return 0 unless $content =~ $expected;
        } else {
            return 0 unless $content eq $expected;
        }
    }

    return 1;
}

1;
