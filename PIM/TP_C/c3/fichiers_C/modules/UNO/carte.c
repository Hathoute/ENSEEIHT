#include "carte.h"


//Tableau de caractères représentant les couleurs
char C[4] = {'J', 'R', 'V', 'B'};

void init_carte(carte* la_carte, couleur c, int v, bool pr){
    la_carte->couleur = c;
    la_carte->valeur = v;
    la_carte->presente = pr;
}

void copier_carte(carte* dest, carte src){
    dest->couleur = src.couleur;
    dest->valeur = src.valeur;
    dest->presente = src.presente;
}

void afficher_carte(carte cte){
    printf("(%c;%d;%d)\t", C[cte.couleur],cte.valeur, cte.presente);
}