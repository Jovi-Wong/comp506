# Basic Makefile -- relies on implicit rules
# Creates "myprogram" from "scan.l" and "myprogram.c"
#
LEX=flex
scanner: scanner.o 

scanner.o: DEMOgram.l tokens.h 
	flex DEMOgram.l
	mv lex.yy.c scanner.c
	cc -c -g scanner.c
