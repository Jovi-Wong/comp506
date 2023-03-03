CC = gcc

all: parser.tab.h parser.tab.c lex.yy.c main.c
	$(CC) -o demo parser.tab.c lex.yy.c main.c 

parser.tab.h parser.tab.c: parser.y
	$(BISON) -d DemoParser.y

lex.yy.c: parser.tab.h scanner.lex 
	$(FLEX) DemoScanner.lex

clean:
	rm demo parser.tab.h parser.tab.c lex.yy.c