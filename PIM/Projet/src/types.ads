with TH;
with LC;
with Vecteur;

package Types is

    type T_Digits is digits 3;

    type T_Rank is record 
        Rang: Integer;
        Poid: T_Digits;
    end record;

    type T_Indice is record
        X: Integer;
        Y: Integer;
    end record;

    -- Fonction d'Hachage.
    function Hachage (Indice: in T_Indice) return Integer;

    package LC_Integer_Integer is
		new LC (Integer, Integer);

    package Vecteur_Poids is
        new Vecteur (Types.T_Rank);

    package Vecteur_Digit is
        new Vecteur (T_Digits);

    package TH_Matrice is
        new TH(T_Indice, T_Digits, Hachage);

    function "<"(Gauche: T_Rank; Droit: T_Rank) return Boolean;

end Types;