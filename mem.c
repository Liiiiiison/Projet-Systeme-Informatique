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

void init_mem()
{ 
    current_idx = 0; 
    temp_idx = 0 ;
    temp_name = 0 ;
}

int is_var(char * a){
    int index = get_index(a);
    if (index!=-1){
        return mem[index].var;
    }
    return -1;
}

int is_init(char * a){
    int index = get_index(a);
    if (index!=-1){
        return mem[index].init;
    }
    return -1;
}

void go_deeper() {
    current_depth++;
}

void come_back(){
    current_depth--;
}

int add_int(char * a)
{
    if (get_index(a)==-1 && strlen(a) <= 100){
        strcpy(mem[current_idx].name,a);
        mem[current_idx].init = 0;
        mem[current_idx].depth = current_depth;
        mem[current_idx].var = 1;

        current_idx++; 
        return current_idx-1; 
    }
    return -1;
}

int init_int(int index) {
    if (mem[index].var == 1)
    mem[index].init = 1 ;
}

int add_const(char * a)
{
    if (get_index(a)==-1 && strlen(a) <= 100){
        strcpy(mem[current_idx].name,a);
        mem[current_idx].init = 0;
        mem[current_idx].depth = current_depth;
        mem[current_idx].var = 0;

        current_idx++; 
        return current_idx-1; 
    }
    return -1;
}

int init_const(int index) {
    if (mem[index].init == 0 && mem[index].var == 0) {
        mem[index].init = 1 ;
        return 0 ;
    }
    return -1;
}

int add_temp() {// pas besoin de vérifier qu'il n'y a pas déjà le même chiffre dans la table, 
                // on ne saura pas à l'avance avant de compiler et c'est même pas un pb
        strcpy(mem[current_idx].name,"temp");
        strcat(mem[current_idx].name,temp_name);
        mem[current_idx].init = 1;
        mem[current_idx].depth = current_depth;
        mem[current_idx].var = 0;
        temp_name++ ;
        temp_idx = current_idx + temp_name;
        return temp_idx - 1;
}

void reinit_temp() {
    temp_name  = 0 ;
    temp_idx = current_idx ; // nécessare ? 
}

int get_index(char * a){
    for (int i=0;i<current_idx;i++){
        if (strcmp(mem[i].name,a)) {
            return i ;
        }
    }
    return -1 ;
}


//0 a false 0
//1 b true  1 