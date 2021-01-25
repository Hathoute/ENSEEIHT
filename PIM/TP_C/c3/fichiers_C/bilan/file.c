/**
 *  \author Xavier Cr�gut <nom@n7.fr>
 *  \file file.c
 *
 *  Objectif :
 *	Implantation des op�rations de la file
*/

#include <malloc.h>
#include <assert.h>

#include "file.h"


void initialiser(File *f)
{
    //f->tete = NULL;
    f->queue = NULL;
    assert(est_vide(*f));
}


void detruire(File *f)
{
    while(f->tete != NULL) {
        Cellule *temp = f->tete;
        f->tete = f->tete->suivante;
        free(temp);
    }

    f->tete = NULL;
    f->queue = NULL;

    //free(f); 
    f = NULL;
}


char tete(File f)
{
    assert(! est_vide(f));

    return f.tete->valeur;
}


bool est_vide(File f)
{
    return f.tete == NULL;
}

/**
 * Obtenir une nouvelle cellule allou�e dynamiquement
 * initialis�e avec la valeur et la cellule suivante pr�cis� en param�tre.
 */
Cellule * cellule(char valeur, Cellule *suivante)
{
    Cellule *cell = malloc(sizeof(Cellule));
    cell->valeur = valeur;
    cell->suivante = suivante;
    return cell;
}


void inserer(File *f, char v)
{
    assert(f != NULL);

    Cellule* cell = cellule(v, NULL);
    if(f->tete == NULL)
        f->tete = cell;
    else
        f->queue->suivante = cell;
    
    f->queue = cell;
}

void extraire(File *f, char *v)
{
    assert(f != NULL);
    assert(! est_vide(*f));

    *v = f->tete->valeur;
    Cellule *cell = f->tete;
    f->tete = f->tete->suivante;
    free(cell);
}


int longueur(File f)
{
    Cellule *cell = f.tete;
    int i;
    for(i = 0; cell != NULL; cell = cell->suivante) {
        i++;
    }

    return i;
}
