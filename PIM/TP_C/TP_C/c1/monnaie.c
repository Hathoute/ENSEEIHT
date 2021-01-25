#include <stdlib.h> 
#include <stdio.h>
#include <assert.h>
#include <stdbool.h>

// Definition du type monnaie
struct monnaie {
    double valeur;
    char devise;
};

typedef struct monnaie Monnaie;

/**
 * \brief Initialiser une monnaie 
 * \param[out] m monnaie à initialiser
 * \param[in] valeur valeur à affecter à m
 * \param[in] devise devise à affecter à m
 * \pre valeur > 0
 */ 
void initialiser(Monnaie m, double valeur, char devise){
    assert(valeur > 0);
    m.devise = devise;
    m.valeur = valeur;
}


/**
 * \brief Ajouter une monnaie m2 à une monnaie m1 
 * \param[in] m1 monnaie a ajouter à m2
 * \param[in,out] m2 resultat de l'addition de m1 et m2
 */ 
bool ajouter(Monnaie m1, Monnaie m2) {
    if(m1.devise != m2.devise)
        return false;

    m2.devise += m1.devise;
    return true;
}


/**
 * \brief Tester Initialiser 
 */ 
void tester_initialiser(){
    Monnaie m;
    initialiser(m, 1.2, '$');
    assert(m.devise == '$');
    assert(m.valeur == 1.2);
    initialiser(m, 0, 'D');
    assert(m.devise == 'D');
    assert(m.valeur == 0);
    initialiser(m, 999999, '€');
    assert(m.devise == '€');
    assert(m.valeur == 999999);
}

/**
 * \brief Tester Ajouter 
 */ 
void tester_ajouter(){
    Monnaie m1, m2;
    initialiser(m1, 1.2, '$');
    initialiser(m2, 0, 'D');
    assert(!ajouter(m1, m2));

    initialiser(m2, 2.2, '$');
    assert(ajouter(m1, m2));
    assert(m2.valeur == (1.2+2.2));
}



int main(void){
    // Un tableau de 5 monnaies
    Monnaie monnaies[5];

    //Initialiser les monnaies
    for(int i = 0; i < 5; i++) {
        double valeur;
        char devise;
        printf("Donner la valeur et la devise de la monnaie #%i: ", i+1);
        scanf("%lf %c", &valeur, &devise);
        monnaies[i].devise = devise;
        monnaies[i].valeur = valeur;
    }
 
    // Afficher la somme des toutes les monnaies qui sont dans une devise entrée par l'utilisateur.
    char devise;
    double somme = 0;
    printf("Donner la devise dont vous voulez calculer la somme: ");
    scanf(" %c", &devise);
    for(int i = 0; i < 5; i++) {
        somme += monnaies[i].devise == devise ? monnaies[i].valeur : 0;
    }

    printf("La somme des devises %c est %lf", devise, somme);
    return EXIT_SUCCESS;
}
