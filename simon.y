%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
void yyerror(char*);
extern FILE *yyin;
extern FILE *yyout;
extern int lines;
int errors=0;
%}

%token ID
%token INTEGER
%token CHARACTER
%token IF
%token ELSE
%token CLASS
%token NEW
%token RETURN
%token WHILE
%token VOID
%token INT
%token CHAR
%token ARRAY
%token ANATHESH_INT
%token ANATHESH_CHAR
%token DHLWSH
%token GE
%token LE
%token EQUAL
%token NOT_EQUAL
%token OR
%token AND
%token ISON
%token ERWTHMATIKO

%token SUN
%token PLIN
%token EPI
%token DIA
%token MOD
%token ANPAR
%token KLPAR
%token ANSP
%token KLSP
%token KENO
%token ANAG
%token KLAG
%token KOMMA
%token ANST
%token KLST
%token THAUM

%right '='
%left '<' '>'   
%left '+' '-'
%left '%' '/' '*'

//%error-verbose

%% /*grammar rules*/


class: CLASS KENO ID ANAG variable2 KENO constructor KENO methodos2 KLAG|error KLAG {errors++; printf("Error class in line: %d \n", lines); yyclearin; };

variable2:variable|variable2 KENO  variable;

constructor:onoma KENO body;

methodos2: methodos| methodos2  KENO methodos;

methodos:epistrofh KENO onoma KENO body;

epistrofh:CHAR|INT|VOID;

onoma:ID ANPAR orismata KLPAR|error KLPAR {errors++;printf("Error onoma in line: %d \n", lines);  yyclearin;};

orismata:orismaduo|orismata KOMMA orismaduo|KENO;

orismaduo:type KENO orismatria;

orismatria:ID|orismatria ANSP KLSP;

type:CHAR|INT;

body: ANAG entoles KLAG|ANAG entoles KENO return KLAG|error KLAG {errors++; printf("Error body in line: %d \n", lines); yyclearin;};

entoles:entolh|entoles KENO entolh;

anathesh:metavlhth ISON expr ERWTHMATIKO|error ERWTHMATIKO {errors++; printf("Error anathesh in line: %d \n", lines); yyclearin;};

elegxos:IF ANPAR condition KLPAR KENO body KENO ELSE KENO body | WHILE  ANPAR condition KLPAR KENO body |IF ANPAR condition KLPAR KENO body| error KENO {errors++; printf("Error elegxos in line: %d \n", lines); yyclearin; };;

expr: oros | oros SUN expr| oros PLIN expr;

oros : paragontas | paragontas EPI oros |paragontas DIA oros|paragontas MOD oros ;

paragontas:metavlhth | INTEGER |ANPAR expr KLPAR |CHARACTER;

metavlhth:ID | ID ANSP expr KLSP ;

entolh:anathesh|variable|elegxos;

variable:DHLWSH | ARRAY | ANATHESH_INT | ANATHESH_CHAR;

return: RETURN KENO expr ERWTHMATIKO ;

factor: ANPAR sxesiakoi KLPAR|error KLPAR {errors++; printf("Error factor in line: %d \n", lines); yyclearin;};

condition: factor KENO  OR KENO factor | factor KENO AND KENO factor |THAUM factor|factor;

sxesiakoi: expr EQUAL expr| expr NOT_EQUAL expr |praxh;

praxh: expr LE expr|expr GE expr| expr ANST expr|expr KLST expr;

%%

void yyerror(char* s)
{
fprintf(stderr, "%s\n", s);
}

int main(int argc, char **argv)
{
++argv;
--argc;
if(argc>0)
yyin=fopen(argv[0],"r");
else yyin=stdin;
yyout=fopen("output","w");
int a=yyparse();
if(a==0)
	printf("\nParsing ok...!\n");
printf("Total number  of errors in file: %d \n", errors);
printf("Total number of lines in file: %d\n", lines);
return 0;
}
