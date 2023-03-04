#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>


FILE* yyin;
int yylineno; 
int errorCount = 0;

int yywrap(void) {
    return 1;
}

int yyerror (const char *s) {	
	errorCount += 1;
	printf("Error! At line %d: %s\n", yylineno, s);
}

int main (int argc, char* argv[]) {
	if (argc == 2)
	{
		if((access(argv[1], F_OK)) != -1)
		{
			yyin = fopen(argv[1], "r");
		}
		else
		{
			printf("File named %s doesn't exist!\n", argv[1]);
			return 0;
		}
	} 
	else
	{
		yyin = stdin;
	}

	yyparse();

	if (errorCount == 0) {
		printf("Parse succeeds.\n");
	} else {
		printf("Parse fails. Total number of errors: %d.\n", errorCount);
	}
	return 0;
}