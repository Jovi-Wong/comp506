CC = gcc

all: DemoParser.tab.h DemoParser.tab.c lex.yy.c main.c
	$(CC) -o demo DemoParser.tab.c lex.yy.c main.c 

DemoParser.tab.h DemoParser.tab.c: DemoParser.y
	bison -d DemoParser.y

lex.yy.c: DemoParser.tab.h DemoScanner.lex 
	flex DemoScanner.lex

clean:
	rm demo DemoParser.tab.h DemoParser.tab.c lex.yy.c