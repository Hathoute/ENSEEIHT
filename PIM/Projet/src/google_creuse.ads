with Types; use Types;
package Google_Creuse is

	type T_Google is limited private;

	-- Initialiser la matrice Google.
	procedure Initialiser(Google: out T_Google; Taille: in Integer; MaxIterations: in Integer; Alpha: in Types.T_Digits);

    procedure Creer(Google: in out T_Google; Liens: in LC_Integer_Integer.T_LC);

    procedure Calculer_Rangs(Google: in out T_Google; Rangs: out Vecteur_Poids.T_Vecteur);

    procedure Vider(Google: in out T_Google);

private

    type T_Google is record 
        Matrice: TH_Matrice.T_TH;
        Taille: Integer;        -- On sait que la matrice Google est carré.
        MaxIterations: Integer;
        Alpha: Types.T_Digits;
        Addition : T_Digits;
    end record;

end Google_Creuse;
