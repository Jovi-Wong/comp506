%{ 
/* Copyright 2016, Keith D. Cooper & Linda Torczon
 * 
 * Written at Rice University, Houston, Texas as part
 * of the instructional materials for COMP 506.
 *
 * The University may have some rights in this work.
 *
 */

#define YYERROR_VERBOSE

#include <stdio.h>
#include "demo.h"

int yylineno;
char *yytext;
extern size_t syntax_count;
void yyerror( char const *);

%}

/* Bison declarations */
%token AND
%token BY
%token CHAR
%token ELSE
%token FOR
%token IF
%token INT
%token NOT
%token OR
%token PROCEDURE
%token READ
%token THEN
%token TO
%token WHILE
%token WRITE
%token LT
%token LE
%token EQ
%token NE
%token GT
%token GE
%token NAME
%token NUMBER
%token CHARCONST

%%
 /* Grammar rules  */
Procedure: PROCEDURE NAME '{' Decls Stmts '}';

Decls: Decls Decl ';' 
	 | Decl ';';

Decl: Type SpecList;

Type: INT
	| CHAR;

SpecList: SpecList ',' Spec
		| Spec;

Spec: NAME 
	| NAME '[' Bounds ']';

Bounds: Bounds ',' Bound 
      | Bound;

Bound: NUMBER ':' NUMBER;

Stmts: Stmts Stmt 
	 | Stmt;

Stmt: Reference '=' Expr ';'
    | '{' Stmts '}' 
	| WHILE '(' Bool ')' '{' Stmts '}' 
    | FOR NAME '=' Expr TO Expr BY Expr '{' Stmts '}' 
    | IF '(' Bool ')' THEN Stmt 
	| IF '(' Bool ')' THEN Stmt ELSE Stmt 
	| READ Reference ';' 
	| WRITE Expr ';'
	| '(' ')' {yyerror("Error! No statement in ()"); err_cnt += 1;}
	| '[' ']' {yyerror("Error! No statement in []"); err_cnt += 1;}
	| '{' '}' {yyerror("Error! No statement in {}"); err_cnt += 1;}
	| ';' 	  {yyerror("Error! Unexpected semicolon"); err_cnt += 1; yyclearin;};
	

Bool: NOT OrTerm 
	| OrTerm;

OrTerm: OrTerm OR AndTerm 
	  | AndTerm;

AndTerm: AndTerm AND RelExpr 
	   | RelExpr;		

RelExpr: RelExpr LT Expr 
	   | RelExpr LE Expr 
	   | RelExpr EQ Expr 
	   | RelExpr NE Expr 
	   | RelExpr GE Expr 
	   | RelExpr GT Expr 
	   | Expr;

Expr: Expr '+' Term 
	| Expr '-' Term
	| Term;

Term: Term '*' Factor 
	| Term '/' Factor 
	| Factor;

Factor: '(' Expr ')' 
	  | Reference 
	  | NUMBER 
	  | CHARCONST;

Reference: NAME 
	     | NAME '[' Exprs ']';

Exprs: Expr ',' Exprs 
	 | Expr;

%%

/* Epilogue */


void yyerror(const char* s)
{
	err_cnt += 1;
	printf("Error! At line %d: %s\n", yylineno, s);
}