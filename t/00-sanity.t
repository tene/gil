# This just checks that the basic parsing and call to builtin say() works.
say('1..5');
say('ok 1');
say('ok ', 2);
say('ok ', sum(1,2));
say('ok ', mul(2,2));
say('ok ', div( sum(5,5), 2 ));
