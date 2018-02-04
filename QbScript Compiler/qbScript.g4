grammar QbScript;

fragment A : [aA];
fragment B : [bB];
fragment C : [cC];
fragment D : [dD];
fragment E : [eE];
fragment F : [fF];
fragment G : [gG];
fragment H : [hH];
fragment I : [iI];
fragment J : [jJ];
fragment K : [kK];
fragment L : [lL];
fragment M : [mM];
fragment N : [nN];
fragment O : [oO];
fragment P : [pP];
fragment Q : [qQ];
fragment R : [rR];
fragment S : [sS];
fragment T : [tT];
fragment U : [uU];
fragment V : [vV];
fragment W : [wW];
fragment X : [xX];
fragment Y : [yY];
fragment Z : [zZ];

fragment Alpha : [a-zA-Z];
fragment Digit : [0-9];
fragment IdChar : Alpha | Digit | '_';

WhiteSpace : [ \t\r\n] -> skip;
Reserved : I F | E L S E | C A S E;
Identifier : Alpha IdChar+;

scriptHeader : 'script' Identifier '(' ')'; // TODO: support script arguments