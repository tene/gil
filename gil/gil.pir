
=head1 TITLE

gil.pir - A gil compiler.

=head2 Description

This is the base file for the gil compiler.

This file includes the parsing and grammar rules from
the src/ directory, loads the relevant PGE libraries,
and registers the compiler under the name 'gil'.

=head2 Functions

=over 4

=item onload()

Creates thegil compiler using a C<PCT::HLLCompiler>
object.

=cut

.namespace [ 'gil::Compiler' ]

.sub 'onload' :anon :load :init
    load_bytecode 'PCT.pbc'

    $P0 = get_hll_global ['PCT'], 'HLLCompiler'
    $P1 = $P0.'new'()
    $P1.'language'('gil')
    $P1.'parsegrammar'('gil::Grammar')
    $P1.'parseactions'('gil::Grammar::Actions')
.end

.include 'gil/builtins.pir'
.include 'gil/gen_grammar.pir'
.include 'gil/gen_actions.pir'

=back

=cut

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

