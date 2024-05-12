%{
#include <stdio.h>
#include <stdbool.h>
#include "y.tab.h"
void yyerror(char *s);
int yylex();
%}
%option nounput yylineno

STRING ["].*["]
NUMBER [-]?[1-9][0-9]*|0

COMMENT [\/][\/].*

var [a-z][a-zA-Z0-9_]*


%%

"+"                      {return ADD; }
"-"                      {return SUB; }
"*"                      {return MUL; }
"/"                     {return DIV; }
"nql"                    {return NOT_EQUALS_CHECK; }
"eql"                    {return EQUALS_CHECK; }
"kaf"                   {return IF; }
"kef"                 {return ELSE; }
"kafkef"               {return ELSE_IF; }
"repeat"                   {return WHILE; }
"true"                  {return TRUE;}
"false"                 {return FALSE;}
"not"                   {return NOT;}
"number"                {return TYPE_NUMBER; }
"string"                {return TYPE_STRING; }
"boolean"               {return TYPE_BOOLEAN; }
"func"                  {return FUNCTION; }
"switch"                {return SWITCH; }
"case"                  {return CASE; }
"default"                 {return DEFAULT; }
"display"                 {return PRINT; }
"or"                      {return OR; }
"and"                    {return AND; }
"="                     {return ASSIGN_OPT;}
"!"                     {return NOT; }
"{"                      {return LCRLBRYCS; }
"}"                      {return RCRLBRYCS; }
"("                      {return LEFTPAR; }
")"                      {return RIGHTPAR; }
";"                      {return SEMICOLON; }
"<"                      {return LESS; }
"<="                    {return LESSEQUAL; }
">"                     {return GREATER ; }
">="                    {return GREATEREQUAL; }
"go"                      {return GO; }
"stop"                    {return STOP; }
"exit"                    {return EXIT; }
{var}                   {yylval.id = yytext[0]; return IDENTIFIER;}
{NUMBER}                {yylval.num = atoi(yytext); return NUMBER; }
{STRING}                {char* str = malloc(yyleng - 2);
                        strncpy(str, yytext + 1, yyleng - 2);
                        yylval.str = str;
                        return STRING;}

	
{COMMENT}               {return COMMENT; }


[ \t]                   ;
.                       {ECHO; yyerror("Unexpected character"); }


%%

int yywrap() {
    return 1;
}
