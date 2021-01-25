
package body Google_Creuse is

	procedure Initialiser(Google: out T_Google; Taille: in Integer; MaxIterations: in Integer; Alpha: in T_Digits) is
	begin
    
        Google.Taille := Taille;
        TH_Matrice.Initialiser(Google.Matrice, Taille);
        Google.MaxIterations := MaxIterations;
        Google.Alpha := Alpha;

        Google.Addition := (1.0-Google.Alpha)/T_Digits(Google.Taille);
	end Initialiser;

    function S(Google: in T_Google; Indice: in T_Indice) return T_Digits is
    begin
        if TH_Matrice.T_LCA_C.Est_Vide(TH_Matrice.LCA(Google.Matrice, Indice)) then
            return 1.0/T_Digits(Google.Taille);
        elsif not TH_Matrice.Cle_Presente(Google.Matrice, Indice) then
            return 0.0;
        else
            return TH_Matrice.La_Donnee(Google.Matrice, Indice);
        end if;
    end S;

    function G(Google: in T_Google; Indice: in T_Indice) return T_Digits is
    begin
        return T_Digits(Google.Alpha)*S(Google, Indice) + Google.Addition;
    end G;

    procedure Creer(Google: in out T_Google; Liens: in LC_Integer_Integer.T_LC) is
        L: array(0..Google.Taille-1) of Integer;

        procedure Incrementer(Gauche: Integer; Droit: Integer) is
        begin
            if not TH_Matrice.Cle_Presente(Google.Matrice, (Gauche, Droit)) then       -- Verifier si il n'existe pas plusieurs liaisons identiques.
                L(Gauche) := L(Gauche) + 1;
                TH_Matrice.Enregistrer(Google.Matrice, (Gauche, Droit), 1.0);
            end if;
        end Incrementer;

        procedure Calculer_Sortants is
            new LC_Integer_Integer.Pour_Chaque(Incrementer);

        procedure Populer(Gauche: Integer; Droit: Integer) is
        begin
            TH_Matrice.Enregistrer(Google.Matrice, (Gauche, Droit), 1.0/T_Digits(L(Gauche)));
        end Populer;

        procedure Populer_Liste is
            new LC_Integer_Integer.Pour_Chaque(Populer);

    begin
        for J in 0..Google.Taille-1 loop
            L(J) := 0;
        end loop;

        Calculer_Sortants(Liens);
        Populer_Liste(Liens);
    end Creer;

    procedure Calculer_Rangs(Google: in out T_Google; Rangs: out Vecteur_Poids.T_Vecteur) is
        Poids: Vecteur_Digit.T_Vecteur;
        Poids_Original: Vecteur_Digit.T_Vecteur;
        Temp: T_Digits;
    begin
        Vecteur_Digit.Initialiser(Poids, Google.Taille);

        for I in 0..Google.Taille-1 loop
            Vecteur_Digit.Ajouter(Poids, 1.0/T_Digits(Google.Taille));
        end loop;

        for tmp in 1..Google.MaxIterations loop
            Vecteur_Digit.Copier(Poids_Original, Poids);
            for I in 0..Google.Taille-1 loop
                Temp := 0.0;
                for J in 0..Google.Taille-1 loop
                    Temp := Temp + Vecteur_Digit.Valeur(Poids_Original, J)*G(Google, (J,I));
                end loop;
                Vecteur_Digit.Modifier(Poids, I, Temp);
            end loop;
            Vecteur_Digit.Vider(Poids_Original);
        end loop;

        Vecteur_Poids.Initialiser(Rangs, Google.Taille);
        for I in 0..Google.Taille-1 loop
            declare
               Rank: T_Rank := (Rang => I, Poid => Vecteur_Digit.Valeur(Poids, I));
            begin
                Vecteur_Poids.Ajouter(Rangs, Rank);
            end;
        end loop;
        
        Vecteur_Digit.Vider(Poids);
    end Calculer_Rangs;

    procedure Vider (Google: in out T_Google) is
    begin
       TH_Matrice.Detruire(Google.Matrice);
    end Vider;

end Google_Creuse;
