package PPIx::PerlCompiler::Structure::List;

use strict;
use warnings;

sub item {
    my ( $self, $index ) = @_;

    my $expression = $self->non_whitespace_child(0) or return;

    return unless $expression->isa('PPI::Statement::Expression');

    return $expression->non_whitespace_child($index);
}

1;
