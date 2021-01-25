with Types; use Types;
package Google_Naive is

	type T_Google is limited private;

	-- Initialiser la matrice Google.
	procedure Initialiser(Google: out T_Google; Taille: in Integer; MaxIterations: in Integer; Alpha: in Types.T_Digits);

    -- Créer la matrice Google
    procedure Creer(Google: in T_Google; Liens: in LC_Integer_Integer.T_LC);

    -- Calculer les rangs depuis la matrice google.
    procedure Calculer_Rangs(Google: in T_Google; Rangs: out Vecteur_Poids.T_Vecteur);

    -- Vider les ressources utilisés par la matrice Google.RangFile
    procedure Vider(Google: in out T_Google);

private

	type T_Matrice is array(Integer range <>, Integer range <>) of Types.T_Digits;
    type T_Matrice_Access is access T_Matrice;
    type T_Google is record 
        Matrice: T_Matrice_Access;
        Taille: Integer;        -- On sait que la matrice Google est carré.
        MaxIterations: Integer;
        Alpha: Types.T_Digits;
    end record;

end Google_Naive;
