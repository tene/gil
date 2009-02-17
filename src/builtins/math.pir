# $Id$

=head1

math.pir -- simple math functions

=cut

.namespace []

.sub 'sum'
    .param pmc a
    .param pmc b
    $P0 = n_add a, b
    .return ($P0)
.end

.sub 'sub'
    .param pmc a
    .param pmc b
    $P0 = n_sub a, b
    .return ($P0)
.end

.sub 'mul'
    .param pmc a
    .param pmc b
    $P0 = n_mul a, b
    .return ($P0)
.end

.sub 'div'
    .param pmc a
    .param pmc b
    $P0 = n_div a, b
    .return ($P0)
.end


# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

