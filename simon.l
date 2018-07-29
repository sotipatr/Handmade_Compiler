%x incl
%{
#include <stdio.h>
#include "y.tab.h"
#define MAX_INCLUDE_DEPTH 10
YY_BUFFER_STATE include_stack[MAX_INCLUDE_DEPTH];
int include_stack_ptr = 0;
void count ();
void comment ();
int column=0;
int lines=1;
%}

id [a-z_][a-zA-Z0-9_]*
digit [0-9]
character   \'[a-zA-Z0-9. ?  ; = * + _  - / ^ &  > % { : )# | ~(  ! , \ “ } ‘<]\'


%%
"#"include" "             BEGIN(incl);
<incl>[ \t]*      /* eat the whitespace */
<incl>[^ \t\n]+   { 
        if ( include_stack_ptr >= MAX_INCLUDE_DEPTH )
            {
	
            fprintf( stderr, "Includes nested too deeply" );
            exit( 1 );
            }

        include_stack[include_stack_ptr++] =YY_CURRENT_BUFFER;


        yyin = fopen( "file2.txt", "r" );
        

        yy_switch_to_buffer(
            yy_create_buffer( yyin, YY_BUF_SIZE ) );

        BEGIN(INITIAL);
        }

<<EOF>> {
        if ( --include_stack_ptr < 0 )
            {
printf("End of file1");
            yyterminate();
            }

        else{
            yy_switch_to_buffer( include_stack[include_stack_ptr] );
		printf("\nEnd of file2");	
		}
        }
 

[-]?{digit}+ {return (INTEGER); }
char {return CHAR; }
else { return ELSE; }
if { return IF; }
int {return INT; }
class { return CLASS; }
new { return NEW; }
return { return RETURN;}
void { return VOID; }
while {return WHILE; }
{id} { return ID; }
int" "{id}"="{digit}+";" {return ANATHESH_INT; }
char" "{id}"="{character}";" { return ANATHESH_CHAR; }
(char|int)" "{id}";" {return DHLWSH;}
{id}"="new" "(char|int)"["{digit}+"]"";" {return ARRAY;}
"'\“'"|"'\''"|"'\0'"|"'\t'"|"'\\'"|{character} { return CHARACTER;}
[\n]+  {lines++; }
[\t]+  { }
"=" {return ISON;}
"/" {return DIA;}
";" {return ERWTHMATIKO;}
"+" {return SUN;}
"-" {return PLIN;}
"*" {return EPI;}
"%" {return MOD;}
"(" {return ANPAR;}
")" {return KLPAR;}
"[" {return ANSP;}
"]" {return KLSP;}
" " {return KENO;}
"{" {return ANAG;}
"}" {return KLAG;}
"," {return KOMMA;}
"!" {return THAUM;}
"<" {return ANST;}
">" {return KLST;}
"/*" { comment( );}  
"<="  {return LE;}

">="  {return GE;}

"==" {return EQUAL;}
"!=" {return NOT_EQUAL;}
"||" {return OR;}
"&&" {return AND;}
. { }

%%


void comment( )
{
	char c, prev = 0;
  
	while ((c = input()) != 0)      /* (EOF maps to 0) */
	{
		if (c == '/' && prev == '*')
			return;
		prev = c;
	}
	error("unterminated comment");
}