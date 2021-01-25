with Types; use Types;
with Vecteur;

generic
    type T_Precision is digits<>;
    Taille: Integer;
    MaxIterations: Integer;
    Alpha: T_Precision;

package Google_Naive is

	type T_Google is limited private;

    package Vecteur_Precision is
        new Vecteur (T_Precision);

	-- Initialiser la matrice Google.
	procedure Initialiser(Google: out T_Google);

    -- Créer la matrice Google
    procedure Creer(Google: in out T_Google; Liens: in LC_Integer_Integer.T_LC);

    -- Calculer les rangs depuis la matrice google.
    procedure Calculer_Rangs(Google: in T_Google; Rangs: out Vecteur_Poids.T_Vecteur);

private

	type T_Matrice is array(0..Taille-1, 0..Taille-1) of T_Precision;
    type T_Google is record 
        G: T_Matrice;
    end record;

end Google_Naive;
