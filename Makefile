GRM=compilateur.y
LEX=compilateur.l
BIN=compilateur

CC=gcc
CFLAGS=-Wall -g

OBJ=y.tab.c lex.yy.c

all: $(BIN)

%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@

y.tab.c: $(GRM)
	yacc -d $<

lex.yy.c: $(LEX)
	flex $<

$(BIN): $(OBJ)
	$(CC) $(CFLAGS) $^ -o $@

clean:
	rm $(OBJ) y.tab.h compilateur

test:
	cat test.c | ./compilateur