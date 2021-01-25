with Types; use Types;
with Vecteur;
with TH;

generic
    type T_Precision is digits<>;
    Taille: Integer;
    MaxIterations: Integer;
    Alpha: T_Precision;

package Google_Creuse is

	type T_Google is limited private;

	-- Initialiser la matrice Google.
	procedure Initialiser(Google: out T_Google);

    procedure Creer(Google: in out T_Google; Liens: in LC_Integer_Integer.T_LC);

    procedure Calculer_Rangs(Google: in out T_Google; Rangs: out Vecteur_Poids.T_Vecteur);

private
    type T_Matrice_Valeur is record
        Indice: T_Indice;
        Valeur: T_Precision;
    end record;

    package Vecteur_Matrice is
        new Vecteur (T_Matrice_Valeur);

    package Vecteur_Precision is
        new Vecteur (T_Precision);
        
    package TH_Matrice is
        new TH(T_Indice, T_Precision, Hachage);
    
    type T_Google is record 
        Matrice_Creuse: Vecteur_Matrice.T_Vecteur;
        Addition : T_Precision;
        PreVide: T_Precision;
        Sortants: Vecteur_Integer.T_Vecteur;
    end record;

end Google_Creuse;
