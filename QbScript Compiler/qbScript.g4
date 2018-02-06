parser grammar QbScript;

options { tokenVocab = LexQbScript; }

script : scriptHeader LBrace scriptBody RBrace;

scriptHeader : Script Identifier LParen RParen; // TODO: support script arguments

scriptBody : | instruction scriptBody;

// Values

commonValue : int | hexint | float | vec2 | vec3 | qbkey | string | wstring | struct;
structValue : commonValue | structArray;
nonstructValue : commonValue | arrayExpr | map | passthrough;

int : Int;
hexint : HexNum;
float : Decimal;
vec2 : LParen float Comma float RParen;
vec3 : LParen float Comma float Comma float RParen;
qbkey : ident | Dollar qbcrc;
ident : Identifier;
qbcrc : HexNum HexNum HexNum HexNum HexNum HexNum HexNum HexNum;
string : String;
wstring : WString;
arrayExpr : LBrack arrayMid RBrack;
arrayMid : | nonstructValue arrayMid1;
arrayMid1 : | Comma nonstructValue arrayMid1;
map : Map LBrace mapItem+ RBrace;
mapItem : qbkey Colon nonstructValue Comma | nonstructValue Comma;
struct : Struct structItem+ EndStruct;
structItem : structType qbkey Equals structValue;
structType : StructType;
structArray : LBrack structArrayMid RBrack;
structArrayMid : | structValue structArrayMid1;
structArrayMid1 : | Comma structValue structArrayMid1;
passthrough : Passthrough;

// Instructions & expressions

instruction : Identifier LParen RParen; // TODO