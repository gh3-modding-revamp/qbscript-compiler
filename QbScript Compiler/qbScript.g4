parser grammar QbScript;

import LexQbScript;

script : scriptHeader '{' scriptBody '}';

scriptHeader : 'script' Identifier '(' ')'; // TODO: support script arguments

scriptBody : | instruction scriptBody;

instruction : 'asdf';
