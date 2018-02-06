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
fragment HexChar : [a-fA-F] | Digit;

LineComment : '//' ~[\r\n]* '\r'? '\n' -> skip; // LineComment must come before WhiteSpace for the \r\n bit to work
BlockComment : '/*' .*? '*/' -> skip;
WhiteSpace : [ \t\r\n] -> skip;
If : I F;
Else : E L S E;
Case : C A S E;
Struct : S T R U C T '{' -> pushMode(STRUCT);
Map : M A P;
Script : S C R I P T;
Identifier : Alpha IdChar+;
HexNum : '0x' Digit+;
Decimal : '-'? Digit+ '.' Digit+ (E Digit+)?;
Int : '-'? Digit+;
Passthrough : '<...>';

Colon : ':';
Comma : ',';
Dollar : '$';
Equals : '=';
LBrace : '{';
LBrack : '[';
LParen : '(';
RBrace : '}';
RBrack : ']';
RParen : ')';

String : '\'' -> more, pushMode(STR);
WString : '"' -> more, pushMode(WSTR);

mode STR;

StringEnd : '\'' -> popMode;
StringEsc : '\\' -> pushMode(STRESC);
StringText : . -> more;

mode WSTR;

WStringEnd : '"' -> popMode;
WStringEsc : '\\' -> pushMode(WSTRESC);
WStringText : . -> more;

mode STRESC;

Esc : FakeEsc | SingleEsc | OctEsc | HexEsc;
FakeEsc : '&' -> popMode; // To separate e.g. an octal escape from an adjacent digit
SingleEsc : [\\'"a-wyzA-WYZ] -> popMode;
OctEsc : Digit Digit? Digit? -> popMode;
HexEsc : 'x' HexChar HexChar -> popMode;

mode WSTRESC;

WEsc : WFakeEsc | WSingleEsc | WOctEsc | WHexEsc;
WFakeEsc : '&' -> popMode; // To separate e.g. an octal escape from an adjacent digit
WSingleEsc : [\\'"a-wyzA-WYZ] -> popMode;
WOctEsc : Digit+ -> popMode;
WHexEsc : 'x' (HexChar HexChar)+ -> popMode;

mode STRUCT;

StructType : I N T | F L O A T | S T R I N G | W S T R I N G | V E C T O R '2' | V E C T O R '3' | Struct
           | A R R A Y '<' StructType '>' | Q B K E Y | Q B K E Y R E F | S T R I N G P T R | S T R I N G Q S;

EndStruct : '}' -> popMode;