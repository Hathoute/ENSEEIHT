#ifndef _UNO_MAIN
#define _UNO_MAIN

#include <stdio.h>
#include <stdbool.h>
#include "carte.h"

#define NB_VALEURS 10
#define NB_CARTES (4*NB_VALEURS)

//Définition du type t_main, capable d'enregistrer un nombre variable de cartes.
struct main {
    carte * main; //tableau des cartes dans la main. 
    int nb; //monbre de cartes
};
typedef struct main t_main;

/**
 * \brief Initialiser une main.
 * \param[in] N nombre de cartes composant la main.  Précondition : N <= (NB_CARTES - 1) div 2
 * \param[out] la_main créée
 * \return true si l'initialisation a échouée.
 */
bool init_main(t_main* la_main, int N);

/**
 * \brief Afficher une main.
 * \param[in] la_main la main a afficher
 */
void afficher_main(t_main la_main);

bool est_conforme(carte c);

#endif