%{

void yyerror (char *s);
int yylex();                         // C declerations

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

int symbols[52];
char *strings[52];

int symbolVal(char symbol);
void updateSymbolVal(char symbol, int val);
void updateStringsVal(char symbol, char *val);
int computeSymbolIndex(char token);
char *stringsVal(char symbol);

%}

                                   // Yacc definitions
%union{
    int num;
    char id;
    char *str;

}

%start line

%token GO STOP PRINT COMMENT TRUE FALSE
%token ASSIGN_OPT ADD SUB MUL DIV AND OR NOT
%token EQUALS_CHECK NOT_EQUALS_CHECK GREATER LESS GREATEREQUAL LESSEQUAL
%token LEFTPAR RIGHTPAR LCRLBRYCS RCRLBRYCS SEMICOLON
%token IF ELSE ELSE_IF WHILE FUNCTION SWITCH CASE DEFAULT
%token TYPE_STRING TYPE_NUMBER TYPE_BOOLEAN EXIT


%token <id> IDENTIFIER
%token <str> STRING
%token <num> NUMBER

%type <id> assign

%type <num> expression condition num_literal 
%type <void> if_statement  function_definition
%type <str> str_literal
%type <void> block


%left ADD SUB
%left MUL DIV
%left AND OR NOT ASSIGN_OPT
%left EQUALS_CHECK NOTEQUALS_CHECK GREATER LESS GREATEREQUAL LESSEQUAL
%left LEFTPAR RIGHTPAR CRLBRYCS SEMICOLON COMMENT

%%


line:
   start_statement statements end_statement {printf("correct\n");}
;

start_statement:
        GO      {printf("PROGRAM STARTED\n");}
;

end_statement:
        STOP    {printf("PROGRAM ENDED\n");}
;

statement:
        print_statement SEMICOLON {;}

	|function_definition {;}
        |if_statement {;}
	//|elseIfStatement {;}
      
        |commentStatement {;}
        |while_statement {;}
        |assign SEMICOLON {;}
        |block {;}
;

statements:
        statement statements {;}
        | statement {;}
;


block:
    LCRLBRYCS statements RCRLBRYCS {;}
;


//condition_sequence:
//
//      condition {;}
//      | condition AND logics {;}
//      | condition OR logics {;}
//;

condition:
         num_literal {$$ = $1;}
        | condition AND condition {$$ = $1 && $3;}
        | condition OR condition {$$ = $1 || $3;}
        | condition EQUALS_CHECK condition {$$ = $1 == $3;}
        | condition NOT_EQUALS_CHECK condition {$$ = $1 != $3;}
        | condition LESS condition {$$ = $1 < $3;}
        | condition LESSEQUAL condition {$$ = $1 <= $3;}
        | condition GREATER condition {$$ = $1 > $3;}
        | condition GREATEREQUAL condition {$$ = $1 >= $3;}
;

expression:
        num_literal {$$ = $1;}
        | expression ADD expression {$$ = $1 + $3;}
        | expression SUB expression {$$ = $1 - $3;}
        | expression MUL expression {$$ = $1 * $3;}
        | expression DIV expression {
                if ($3 == 0){
                        yyerror("Cannot divide by 0\n");
                }else{
                        $$ = $1 / $3;
                }
        }
;

assign:
        IDENTIFIER ASSIGN_OPT str_literal {updateStringsVal($1,$3); }
        | TYPE_STRING IDENTIFIER ASSIGN_OPT str_literal {updateStringsVal($2,$4); }
        | TYPE_NUMBER IDENTIFIER ASSIGN_OPT expression {updateSymbolVal($2,$4); }
        | IDENTIFIER ASSIGN_OPT expression {updateSymbolVal($1,$3); }

;
function_definition:
        FUNCTION IDENTIFIER LEFTPAR RIGHTPAR block { printf("Function %s defined\n", $2); }
;


if_statement:

    IF LEFTPAR condition RIGHTPAR block %prec IF {
        if ($3 == TRUE) {
            printf("IF block executed\n"); // If bloğunun çalıştığını kontrol etmek için ekledim
        }
    }
    | IF LEFTPAR condition RIGHTPAR block ELSE block %prec IF {
        if ($3 == TRUE) {
            printf("IF block executed\n"); // If bloğunun çalıştığını kontrol etmek için ekledim
        } else {
            printf("ELSE block executed\n"); // Else bloğunun çalıştığını kontrol etmek için ekledim
        }
    }
    | IF LEFTPAR condition RIGHTPAR block ELSE_IF LEFTPAR condition RIGHTPAR block ELSE block {
        if ($3 == TRUE) {
            printf("IF block executed\n"); // If bloğunun çalıştığını kontrol etmek için ekledim
        } else if ($8 == TRUE) {
            printf("ELSE_IF block executed\n"); // Else If bloğunun çalıştığını kontrol etmek için ekledim
        } else {
            printf("ELSE block executed\n"); // Else bloğunun çalıştığını kontrol etmek için ekledim
        }
    }
    ;



/*if_statement:

        IF LEFTPAR condition RIGHTPAR block %prec IF {
                if ($3) {

                }
        }
        | IF LEFTPAR condition RIGHTPAR block ELSE block %prec IF {
                if ($3) {

                }else {

                }
        }
        | IF LEFTPAR condition RIGHTPAR block ELSE_IF LEFTPAR condition RIGHTPAR block ELSE block {
                if ($3) {

                }
                else if ($8) {

                }else{

                }
        }

;*/


commentStatement:
    COMMENT  {printf("Comment is valid\n");}
;

//else_if_statement:
//      ELSE_IF LEFTPAR condition_sequence RIGHTPAR block {
//              if ($3) {
//
//              }
//      }
//      | ELSE_IF LEFTPAR condition_sequence RIGHTPAR block else_if_statement {
//      }
//;


 while_statement:
        WHILE LEFTPAR condition RIGHTPAR block {
                while ($3) {

                        //complete loop
                break;

                }
        }
;

print_statement:
        PRINT LEFTPAR str_literal RIGHTPAR {
                printf("%s\n", $3);
        }
        | PRINT LEFTPAR expression RIGHTPAR {
                printf("%d\n", $3);
        }
;

//literal:
//      num_literal {;}
//      | str_literal {;}
//;

num_literal:
        NUMBER {$$ = $1;}
        | IDENTIFIER {$$ = symbolVal($1);}
;


str_literal:

        STRING {
                $$ = $1;
}

;


%%

int computeSymbolIndex(char token)
{
    int idx = -1;
    if(islower(token)){
        idx = token - 'a' + 26;
    }
    else if(isupper(token)){
        idx = token - 'A';
    }
    return idx;
}

int symbolVal(char symbol)
{
    int bucket = computeSymbolIndex(symbol);
        return symbols[bucket];
}

char *stringsVal(char symbol)
{
    int idx = computeSymbolIndex(symbol);
    printf("%s\n", strings[idx]);
    return strings[idx];
}


void updateSymbolVal(char symbol, int val)
{
    int idx = computeSymbolIndex(symbol);
    symbols[idx] = val;
}
void updateStringsVal(char symbol, char *val)
{
    int idx = computeSymbolIndex(symbol);
    strings[idx] = val;
}

int main(void){
    int i;
    for(i = 0; i < 52; i++){
        symbols[i] = 0;
        strings[i] = "";
    }
return yyparse();
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);}
