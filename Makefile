lexer: lex.yy.o symbol_table.o
	gcc -o $@ $^

symbol_table.o: symbol_table.c symbol_table.h
	gcc -c $<

lex.yy.c: lexer.l symbol_table.h
	flex $<

clean:
	rm -f \
		lex.yy.o lex.yy.c \
		main.o main \
		symbol_table.o \
		lexer