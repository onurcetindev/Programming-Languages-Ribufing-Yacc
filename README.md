# Ribufing Programming Language

## Table of Contents

- [Ribufing Language Project](#ribufing-language-project)
  - [BNF Form](#bnf-form)
  - [Description](#description)
  - [Data Types](#data-types)
  - [Control Flow](#control-flow)
  - [Loop](#loop)
  - [Functions](#functions)
  - [Variables and Data Types](#variables-and-data-types)
  - [IO](#inputoutput)
  - [Operators](#operators)
  - [Running the Project](#running-the-project)

> #### CSE 334 - Programming Languages
>
> - This project is build for CSE 334 course of Computer Scinece Engineering of Akdeniz University.
> - Contributors
>
>   - [Bedirhan Tonğ](https://github.com/bedirhantong)
>   - [Şeyhmus Alataş](https://github.com/alatasms)
>   - [Onur Çetin](https://github.com/onurcetindev)
>
> - Technologies
>   - ![Language](https://img.shields.io/badge/-C-blue) ![Language](https://img.shields.io/badge/-Lex-yellow.svg) ![Language](https://img.shields.io/badge/-Yacc-red.svg)

### BNF FORM

The following Backus-Naur Form (BNF) grammar defines the syntax of the language:

```bnf
<line> ::= <start_statement> <statements> <end_statement>

<start_statement> ::= go
<end_statement> ::= stop

<statement> ::= <if_statement> |
                <while_statement> |
                <switch_statement> | 
                <assign> | 
                <print_statement> | 
                <commentStatement> |
                <block>

<statements> ::= <statement> <statements> | 
                 <statement>

<block> ::= { <statements> }

<if-statement> ::= kaf (<condition>) <block> |
                    kaf (<condition>) <block> kef <block> |
                    kaf (<condition>) <block> kafkef (<condition>) <block> kef <block>



<condition> ::= <num_literal> |
                <condition> <condition_operator> <condition>

<expression> ::= <num_literal> |
                <expression> <expression_operator> <expression>

<assign> ::= <identifier> <assign_opt> <str_literal> |
            string <identifier> <assign_opt> <str_literal> |
            number <identifier> <assign_opt> <expression> |
            <identifier> <assign_opt> <expression>

<commentStatement> ::= <comment> |
                        <comment> <string>

<function_definition> ::= func <identifier> () <block>

<while-statement> ::= repeat (<condition>) <block>

<switch-statement> ::= switch <identifier> <case_statement>* default <block>
<case-statement> ::= match <value> <block>

<print_statement> ::= display (<str_literal>) <semicolon> |
                      display (<expression>) <semicolon>


<return-statement> ::= return <identifier> <semicolon> | return <value> <semicolon>

<num_literal> ::= <number>
<str_literal> ::= <string>

<condition_operator> ::= and | or | eql | nql | "==" | "!=" | "<" | "<=" | ">" | ">=" 
<assign_opt> ::= "="
<expression_operator> ::= "+" | "-" | "/" | "*"
<semicolon> ::= ";"
<value> ::= <string> | <number>
<number> ::= [-]?[1-9][0-9]*|0
<identifier> = [a-z][a-zA-Z0-9_]*
<comment> ::= [\/][\/].*
<string> ::= ["].*["]

```

# Description

This describes a structured programming language with some object-oriented concepts like function definitions. Here's a breakdown of its key features:

#### Data Types:

- Supports basic data types: integers (int), doubles (double), strings (string), and booleans (boolean).

#### Control Flow:

- Offers if-else constructs with various combinations (using kaf, kef, kafkef) for conditional execution. The exact semantics of these keywords (e.g., kaf for simple if, kef for else and kafkef for if-else) would require additional information.
- switch statements for multi-way branching based on an identifier's value (inspect, match, default).

```c
number a = 1;
switch(a) {
    match 1 display("Ribufing");
}
```

#### Loop

- while loops for repeated execution based on a condition (repeat).

```c
repeat(true) {
  display("It's true");
}
```

#### Functions:

- Enables defining functions with names (func) and a block of statements (block).

```c
func greet() {  // Function declaration
  display("Hello World");
}
```

#### Variables and Data Types:

- Variables are declared with a specific data type and assigned a name (variable-declaration).
- Assignment of values is done using the assignment operator (=).
  Values and Expressions:
- Values can be numbers and strings

#### Input/Output:

- Printing to the console is achieved using the display statement.

#### Operators:

- Supports comparison (nql - not equal, eql - equal) and logical (and, or) operators.

### Running The Project

```ribufing

make ribufing

./ribufing < basic_example_with_comment.rbf
./ribufing < if_else_example.rbf
./ribufing < while_example.rbf
./ribufing < function_example.rbf
./ribufing < error_handling.rbf


```
