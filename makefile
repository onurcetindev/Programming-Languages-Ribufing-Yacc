ribufing  : ribufing.l ribufing.y
		yacc -d ribufing.y
		lex ribufing.l
		gcc -o ribufing lex.yy.c y.tab.c -ll
	
clean :
		rm -f y.tab.c y.tab.h lex.yy.c ribufing


