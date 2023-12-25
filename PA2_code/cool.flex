/*
 *  The scanner definition for COOL.
 */

/*
 *  Stuff enclosed in %{ %} in the first section is copied verbatim to the
 *  output, so headers and global definitions are placed here to be visible
 * to the code in the file.  Don't remove anything that was here initially
 */
%{
#include <cool-parse.h>
#include <stringtab.h>
#include <utilities.h>

/* The compiler assumes these identifiers. */
#define yylval cool_yylval
#define yylex  cool_yylex

/* Max size of string constants */
#define MAX_STR_CONST 1025
#define YY_NO_UNPUT   /* keep g++ happy */

extern FILE *fin; /* we read from this file */

/* define YY_INPUT so we read from the FILE fin:
 * This change makes it possible to use this scanner in
 * the Cool compiler.
 */
#undef YY_INPUT
#define YY_INPUT(buf,result,max_size) \
	if ( (result = fread( (char*)buf, sizeof(char), max_size, fin)) < 0) \
		YY_FATAL_ERROR( "read() in flex scanner failed");

char string_buf[MAX_STR_CONST]; /* to assemble string constants */
char *string_buf_ptr;

extern int curr_lineno;
extern int verbose_flag;

extern YYSTYPE cool_yylval;
int nesting_comments = 0;

/*
 *  Add Your own definitions here
 */

%}

/*
 * Define names for regular expressions here.
 */

DELIMITER	      [ \t\n]
WHITESPACE	    [ \r\t\f\v{DELIMITER}]+
DIGIT		        [0-9]
INTEGERS	      DIGIT+
LETTER		      [a-zA-Z]
ID              {LETTER}({LETTER}|{DIGIT})
NUMBER          {DIGIT}+(\.{DIGIT}+)?(E[+-]?{DIGIT})?
DARROW          =>
InlineComment   --[^\n]*(--|\n)
CommentOpen     \(\*
   

%%

 /*
  *  Nested comments
  */


 /*
  *  The multiple-character operators.
  */

{WHITESPACE}    { /* ignore */ } 
class           { return (CLASS); }
else            { return (ELSE); }
fi              { return (FI); }
if              { return (IF); }
in              { return (IN); }
inherits        { return (INHERITS); }
let             { return (LET); }
loop            { return (LOOP); }
pool            { return (POOL); }
then            { return (THEN); }
while           { return (WHILE); }
case            { return (CASE); }
esac            { return (ESAC); }
of              { return (OF); }
{DARROW}		    { return (DARROW); }
new             { return (NEW); }
isvoid          { return (ISVOID); }
not             { return (NOT); }
true            { cool_yylval.boolean = true; return (BOOL_CONST); }
/* 
     STR_CONST = 275,
     INT_CONST = 276,
     BOOL_CONST = 277,
     TYPEID = 278,
     OBJECTID = 279,
     ASSIGN = 280,
     NOT = 281,
     LE = 282,
     ERROR = 283,
     LET_STMT = 285
*/



 /*
  * Keywords are case-insensitive except for the values true and false,
  * which must begin with a lower-case letter.
  */


 /*
  *  String constants (C syntax)
  *  Escape sequence \c is accepted for all characters c. Except for 
  *  \n \t \b \f, the result is c.
  *
  */


%%
