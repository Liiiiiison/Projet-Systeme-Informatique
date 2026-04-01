#include <stdio.h>
#include <stdlib.h>

struct data {
    char name[100]; //VERIFIER LA TAILLE DANS LES FTC CHAR *
    char init;
    int depth;
    char var;
};


struct data mem[50]; // quelle taille choisir ? 
int current_idx; 
int current_depth;
int temp_idx ;
int temp_name ;

void init_mem();

int is_var(char * a);

int is_init(char * a);

void go_deeper();

void come_back();

int add_int(char * a);

int init_int(int index) ;

int add_const(char * a);

int init_const(int index);

int add_temp();

void reinit_temp() ;

int get_index(char * a);


//0 a false 0
//1 b true  1 mem.c