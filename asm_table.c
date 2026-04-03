#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct instruction {
    char ope[4]; // VERIFIER LA TAILLE DANS LES FTC CHAR *
    int dest;
    int op1;
    int op2;
};

//char buffer[100];
struct instruction code[50]; // Taille 50 semble raisonnable
int table_idx = 0;  // Nombre d'instructions actuellement dans le tableau
//int current_depth;
//int temp_idx;
//int temp_name;

// 1. Fonction pour ajouter une instruction
int ajouter_instruction(const char* ope, int dest, int op1, int op2) {
    if (table_idx >= 50) {
        printf("Erreur: Tableau d'instructions plein (max 50)\n");
        return -1;  // Échec
    }
    
    // Copier l'opérateur (limiter à 3 caractères + \0)
    strncpy(code[table_idx].ope, ope, 3);
    code[table_idx].ope[3] = '\0';
    
    // Assigner les autres champs
    code[table_idx].dest = dest;
    code[table_idx].op1 = op1;
    code[table_idx].op2 = op2;
    
    table_idx++;
    
    printf("Instruction ajoutée à l'index %d : %s %d %d %d\n", 
           table_idx - 1, ope, dest, op1, op2);
    
    return table_idx - 1;  // Retourne l'index de l'instruction ajoutée
}

// 2. Fonction pour modifier une instruction
int modifier_instruction(int index, const char* ope, int dest, int op1, int op2) {
    // Vérifier si l'index est valide
    if (index < 0 || index >= table_idx) {
        printf("Erreur: Index %d invalide (0-%d)\n", index, table_idx - 1);
        return -1;  // Échec
    }
    
    // Modifier l'instruction
    strncpy(code[index].ope, ope, 3);
    code[index].ope[3] = '\0';
    code[index].dest = dest;
    code[index].op1 = op1;
    code[index].op2 = op2;
    
    printf("Instruction à l'index %d modifiée : %s %d %d %d\n", 
           index, ope, dest, op1, op2);
    
    return 0;  // Succès
}

// 3. Fonction pour modifier seulement l'opérateur
int modifier_ope(int index, const char* ope) {
    if (index < 0 || index >= table_idx) {
        printf("Erreur: Index %d invalide\n", index);
        return -1;
    }
    
    strncpy(code[index].ope, ope, 3);
    code[index].ope[3] = '\0';
    return 0;
}

// 4. Fonction pour modifier seulement la destination
int modifier_dest(int index, int dest) {
    if (index < 0 || index >= table_idx) return -1;
    code[index].dest = dest;
    return 0;
}

// 5. Fonction pour récupérer une instruction complète
struct instruction* recuperer_instruction(int index) {
    if (index < 0 || index >= table_idx) {
        printf("Erreur: Index %d invalide\n", index);
        return NULL;
    }
    
    return &code[index];
}

// 6. Fonction pour récupérer seulement l'opérateur
char* recuperer_ope(int index) {
    if (index < 0 || index >= table_idx) {
        printf("Erreur: Index %d invalide\n", index);
        return NULL;
    }
    
    return code[index].ope;
}

// 7. Fonction pour récupérer la destination
int recuperer_dest(int index) {
    if (index < 0 || index >= table_idx) {
        printf("Erreur: Index %d invalide\n", index);
        return -1;
    }
    
    return code[index].dest;
}

// 8. Fonction pour récupérer l'opérande 1
int recuperer_op1(int index) {
    if (index < 0 || index >= table_idx) {
        printf("Erreur: Index %d invalide\n", index);
        return -1;
    }
    
    return code[index].op1;
}

// 9. Fonction pour récupérer l'opérande 2
int recuperer_op2(int index) {
    if (index < 0 || index >= table_idx) {
        printf("Erreur: Index %d invalide\n", index);
        return -1;
    }
    
    return code[index].op2;
}

// 10. Fonction pour récupérer le dernier index utilisé
int recuperer_dernier_index() {
    return table_idx - 1;
}

// 11. Fonction pour récupérer le nombre total d'instructions
int recuperer_nombre_instructions() {
    return table_idx;
}

// 12. Fonction pour afficher toutes les instructions
void afficher_toutes_instructions() {
    printf("\n=== LISTE DES INSTRUCTIONS ===\n");
    printf("Total: %d instructions\n", table_idx);
    printf("+-------+------+------+------+------+\n");
    printf("| Index | Ope  | Dest | Op1  | Op2  |\n");
    printf("+-------+------+------+------+------+\n");
    
    for (int i = 0; i < table_idx; i++) {
        printf("|   %3d | %4s | %4d | %4d | %4d |\n", 
               i, code[i].ope, code[i].dest, code[i].op1, code[i].op2);
    }
    printf("+-------+------+------+------+------+\n\n");
}

// 13. Fonction pour supprimer une instruction (décalage)
int supprimer_instruction(int index) {
    if (index < 0 || index >= table_idx) {
        printf("Erreur: Index %d invalide\n", index);
        return -1;
    }
    
    // Décaler les éléments suivants vers la gauche
    for (int i = index; i < table_idx - 1; i++) {
        code[i] = code[i + 1];
    }
    
    table_idx--;
    printf("Instruction à l'index %d supprimée\n", index);
    return 0;
}

// 14. Fonction pour rechercher une instruction par opérateur
void rechercher_par_ope(const char* ope) {
    printf("\n=== RECHERCHE D'INSTRUCTIONS AVEC OPE = %s ===\n", ope);
    int trouve = 0;
    
    for (int i = 0; i < table_idx; i++) {
        if (strcmp(code[i].ope, ope) == 0) {
            printf("Index %d : %s %d %d %d\n", 
                   i, code[i].ope, code[i].dest, code[i].op1, code[i].op2);
            trouve = 1;
        }
    }
    
    if (!trouve) {
        printf("Aucune instruction trouvée avec l'opérateur '%s'\n", ope);
    }
}

