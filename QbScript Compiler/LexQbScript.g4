lexer grammar LexQbScript;

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

LineComment : '//' ~[\r\n]* '\r'? '\n' -> skip; // LineComment must come before WhiteSpace for the \r\n bit to work
BlockComment : '/*' .*? '*/' -> skip;
WhiteSpace : [ \t\r\n] -> skip;
Reserved : I F | E L S E | C A S E;
Identifier : Alpha IdChar+;
HexNum : '0x' Digit+;
Decimal : '-'? Digit+ '.' Digit+ (E Digit+)?;

String : '\'' -> more, pushMode(STR);
WString : '"' -> more, pushMode(WSTR);

mode STR;

StringEnd : '\'' -> popMode;
StringEsc : '\\' -> pushMode(STRESC);
StringText : . -> more;

mode WSTR;

WStringEnd : '"' -> popMode;
WStringEsc : '\\' -> pushMode(STRESC);
WStringText : . -> more;

mode STRESC;

Esc : FakeEsc | SingleEsc | OctEsc | HexEsc;
FakeEsc : '&' -> popMode; // To separate e.g. an octal escape from an adjacent digit
SingleEsc : [\\'"a-wyzA-WYZ] -> popMode;
OctEsc : [0-9]+ -> popMode;
HexEsc : 'x' [0-9a-fA-F]+ -> popMode;
