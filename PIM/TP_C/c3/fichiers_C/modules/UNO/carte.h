#ifndef _UNO_CARTE
#define _UNO_CARTE

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>


enum couleur {JAUNE, ROUGE, VERT, BLEU};
typedef enum couleur couleur;

//Définition du type carte
struct carte {
    couleur couleur;
    int valeur; // Invariant : valeur >= 0 && valeur < NB_VALEURS
    bool presente; // la carte est-elle presente dans le jeu ?
};
typedef struct carte carte;


void init_carte(carte* la_carte, couleur c, int v, bool pr);
void copier_carte(carte* dest, carte src);
void afficher_carte(carte cte);
#endif