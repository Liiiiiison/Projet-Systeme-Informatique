GRM=compilateur.y
LEX=compilateur.l
BIN=compilateur

CC=gcc
CFLAGS=-Wall -g

OBJ1=y.tab.c lex.yy.c 
OBJ2=y.tab.c lex.yy.c mem.c

all: $(BIN)

%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@

y.tab.c: $(GRM)
	yacc -d $<

lex.yy.c: $(LEX)
	flex $<

$(BIN): $(OBJ2) 
	$(CC) $(CFLAGS) $^ -o $@

clean:
	rm $(OBJ1) y.tab.h compilateur

test:
	cat test.c | ./compilateur