#ifndef INSTRUCTIONS_H
#define INSTRUCTIONS_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Constantes
#define MAX_INSTRUCTIONS 50
#define MAX_OPE_LEN 4

// Structure d'instruction
struct instruction {
    char ope[MAX_OPE_LEN];  // Code opération (3 caractères + \0)
    int dest;               // Destination / numéro d'instruction cible
    int op1;                // Opérande 1 / registre condition (@X)
    int op2;                // Opérande 2 / numéro d'instruction (pour JMF)
};

// Variables globales (déclarées comme extern)
extern struct instruction code[MAX_INSTRUCTIONS];
//extern int current_idx;
//extern int current_depth;

// ============ FONCTIONS D'AJOUT ============
/**
 * Ajoute une instruction à la fin du tableau
 * @param ope : Opérateur (ex: "ADD", "JMP", "JMF")
 * @param dest : Destination
 * @param op1 : Opérande 1
 * @param op2 : Opérande 2
 * @return Index de l'instruction ajoutée, -1 si erreur
 */
int ajouter_instruction(const char* ope, int dest, int op1, int op2);

// ============ FONCTIONS DE MODIFICATION ============
/**
 * Modifie complètement une instruction
 * @param index : Index de l'instruction à modifier
 * @return 0 si succès, -1 si erreur
 */
int modifier_instruction(int index, const char* ope, int dest, int op1, int op2);

/**
 * Modifie seulement l'opérateur d'une instruction
 * @param index : Index de l'instruction
 * @param ope : Nouvel opérateur
 * @return 0 si succès, -1 si erreur
 */
int modifier_ope(int index, const char* ope);

/**
 * Modifie seulement la destination d'une instruction
 * @param index : Index de l'instruction
 * @param dest : Nouvelle destination
 * @return 0 si succès, -1 si erreur
 */
int modifier_dest(int index, int dest);

/**
 * Modifie seulement l'opérande 1
 * @param index : Index de l'instruction
 * @param op1 : Nouvel opérande 1
 * @return 0 si succès, -1 si erreur
 */
int modifier_op1(int index, int op1);

/**
 * Modifie seulement l'opérande 2
 * @param index : Index de l'instruction
 * @param op2 : Nouvel opérande 2
 * @return 0 si succès, -1 si erreur
 */
int modifier_op2(int index, int op2);

// ============ FONCTIONS DE LECTURE ============
/**
 * Récupère une instruction complète
 * @param index : Index de l'instruction
 * @return Pointeur vers l'instruction, NULL si erreur
 */
struct instruction* recuperer_instruction(int index);

/**
 * Récupère l'opérateur d'une instruction
 * @param index : Index de l'instruction
 * @return Chaîne de caractères, NULL si erreur
 */
char* recuperer_ope(int index);

/**
 * Récupère la destination d'une instruction
 * @param index : Index de l'instruction
 * @return Valeur de dest, -1 si erreur
 */
int recuperer_dest(int index);

/**
 * Récupère l'opérande 1 d'une instruction
 * @param index : Index de l'instruction
 * @return Valeur de op1, -1 si erreur
 */
int recuperer_op1(int index);

/**
 * Récupère l'opérande 2 d'une instruction
 * @param index : Index de l'instruction
 * @return Valeur de op2, -1 si erreur
 */
int recuperer_op2(int index);

// ============ FONCTIONS D'INFORMATION ============
/**
 * Récupère le dernier index utilisé
 * @return Dernier index, -1 si tableau vide
 */
int recuperer_dernier_index(void);

/**
 * Récupère le nombre total d'instructions
 * @return Nombre d'instructions dans le tableau
 */
int recuperer_nombre_instructions(void);

// ============ FONCTIONS D'AFFICHAGE ============
/**
 * Affiche toutes les instructions du tableau
 */
void afficher_toutes_instructions(void);

/**
 * Affiche une instruction spécifique
 * @param index : Index de l'instruction à afficher
 */
void afficher_instruction(int index);

// ============ FONCTIONS DE GESTION ============
/**
 * Supprime une instruction (décalage des suivantes)
 * @param index : Index de l'instruction à supprimer
 * @return 0 si succès, -1 si erreur
 */
int supprimer_instruction(int index);

/**
 * Recherche les instructions par opérateur
 * @param ope : Opérateur à rechercher
 */
void rechercher_par_ope(const char* ope);

/**
 * Vide complètement le tableau d'instructions
 */
void vider_tableau(void);

/**
 * Initialise le tableau d'instructions
 */
void initialiser_tableau(void);

#endif // INSTRUCTIONS_H