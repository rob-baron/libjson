# Just a simple Makefile to build the library
# expected to be run in a docker container
cpp := gcc -std=c++14 -I.
cc := gcc -I.
lex := flex --nowarn
yacc := bison

lexer.c: src/lexer.l
	$(lex) --outfile=lexer.c --header-file=lexer.h src/lexer.l

parser.c: src/parser.y
	$(yacc) --defines=parser.h -o parser.c src/parser.y

lexer.o: lexer.c lexer.h
	$(cc) -c lexer.c

parser.o: parser.c parser.h
	$(cc) -c parser.c

libjson.a: lexer.o parser.o
	ar rvs libjson.a lexer.o parser.o

all: libjson.a

clean:
	rm libjson.a
	rm libjson.o
	rm parser.c
	rm parser.h
	rm lexer.c
	rm lexer.h
