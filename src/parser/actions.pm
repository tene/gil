# $Id$

=begin comments

gil::Grammar::Actions - ast transformations for gil

This file contains the methods that are used by the parse grammar
to build the PAST representation of an gil program.
Each method below corresponds to a rule in F<src/parser/grammar.pg>,
and is invoked at the point where C<{*}> appears in the rule,
with the current match object as the first argument.  If the
line containing C<{*}> also has a C<#= key> comment, then the
value of the comment is passed as the second argument to the method.

=end comments

class gil::Grammar::Actions;

method TOP($/) {
    my $past := PAST::Block.new( :blocktype('declaration'), :node( $/ ) );
    for $<statement> {
        $past.push( $( $_ ) );
    }
    make $past;
}


method statement($/, $key) {
    make $( $/{$key} );
}

method assignment($/) {
    my $var := $($<variable>);
    my $past := PAST::Op.new( :pasttype('bind'), :node( $/ ) );
    $past.push($var);
    $past.push( $( $<expr> ) );
    make $past;
}

method expr($/, $key) {
    make $( $/{$key} );
}

method funcall($/) {
    my $past := PAST::Op.new( :name(~$<fname>), :pasttype('call'), :node( $/ ) );
    for $<expr> {
        $past.push( $( $_ ) );
    }
    make $past;
}


method value($/, $key) {
    make $( $/{$key} );
}


method variable($/,$key) {
    my $var := PAST::Var.new( :name($<name>), :scope('lexical'), :viviself('Undef'));
    if $key eq 'declaration' {
        $var.isdecl(1);
    }
    make $var;
}


method integer($/) {
    make PAST::Val.new( :value( ~$/ ), :returns('Integer'), :node($/) );
}


method quote($/) {
    make PAST::Val.new( :value( $($<string_literal>) ), :node($/) );
}


# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:

