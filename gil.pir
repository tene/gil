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

Creates the gil compiler using a C<PCT::HLLCompiler>
object.

=cut

.namespace [ 'gil::Compiler' ]

.loadlib 'gil_group'

.sub 'onload' :anon :load :init
    load_bytecode 'PCT.pbc'

    $P0 = get_hll_global ['PCT'], 'HLLCompiler'
    $P1 = $P0.'new'()
    $P1.'language'('gil')
    $P1.'parsegrammar'('gil::Grammar')
    $P1.'parseactions'('gil::Grammar::Actions')
.end

=item main(args :slurpy)  :main

Start compilation by passing any command line C<args>
to the gil compiler.

=cut

.sub 'main' :main
    .param pmc args

    $P0 = compreg 'gil'
    $P1 = $P0.'command_line'(args)
.end


.include 'src/gen_builtins.pir'
.include 'src/gen_grammar.pir'
.include 'src/gen_actions.pir'

=back

=cut

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

