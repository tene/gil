#! /usr/local/bin/parrot

=head1 NAME

setup.pir - Python distutils style

=head1 DESCRIPTION

No Configure step, no Makefile generated.

=head1 USAGE

    $ parrot setup.pir build
    $ parrot setup.pir test
    $ sudo parrot setup.pir install

=cut

.sub 'main' :main
    .param pmc args
    $S0 = shift args
    load_bytecode 'distutils.pbc'

    $P0 = new 'Hash'
    $P0['name'] = 'gil'
    $P0['abstract'] = 'Generic Imperative Language'
    $P0['authority'] = 'http://github.com/tene'
    $P0['description'] = 'Generic Imperative Language - demo language for parrot'
    $P0['license_type'] = 'Artistic License 2.0'
    $P0['license_uri'] = 'http://www.perlfoundation.org/artistic_license_2_0'
    $P0['copyright_holder'] = 'Parrot Foundation'
    $P0['checkout_uri'] = 'git://github.com/tene/gil.git'
    $P0['browser_uri'] = 'http://github.com/tene/gil'
    $P0['project_uri'] = 'http://github.com/tene/gil'

    # build
    $P1 = new 'Hash'
    $P1['gil/gen_grammar.pir'] = 'gil/parser/grammar.pg'
    $P0['pir_pge'] = $P1

    $P2 = new 'Hash'
    $P2['gil/gen_actions.pir'] = 'gil/parser/actions.pm'
    $P0['pir_nqp'] = $P2

    $P3 = new 'Hash'
    $P4 = split "\n", <<'SOURCES'
gil/gil.pir
gil/gen_grammar.pir
gil/gen_actions.pir
gil/builtins.pir
gil/builtins/math.pir
gil/builtins/say.pir
SOURCES
    $S0 = pop $P4
    $P3['gil/gil.pbc'] = $P4
    $P3['gil.pbc'] = 'gil.pir'
    $P0['pbc_pir'] = $P3

    $P5 = new 'Hash'
    $P5['parrot-gil'] = 'gil.pbc'
    $P0['installable_pbc'] = $P5

    # test
    $S0 = get_parrot()
    $S0 .= ' gil.pbc'
    $P0['prove_exec'] = $S0

    # install
    $P0['inst_lang'] = 'gil/gil.pbc'

    .tailcall setup(args :flat, $P0 :flat :named)
.end


# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

