with Ada.Unchecked_Deallocation;

package body Google_Naive is

	procedure Initialiser(Google: out T_Google; Taille: in Integer; MaxIterations: in Integer; Alpha: in T_Digits) is
	begin
    
        Google.Taille := Taille;
        Google.Matrice := new T_Matrice(0..Taille-1, 0..Taille-1);
        Google.MaxIterations := MaxIterations;
        Google.Alpha := Alpha;

        for I in 0..Taille-1 loop
            for J in 0..Taille-1 loop
                Google.Matrice.all(I,J) := 0.0;
            end loop;
        end loop;
	end Initialiser;

    procedure Creer(Google: in T_Google; Liens: in LC_Integer_Integer.T_LC) is
        L: array(0..Google.Taille-1) of Integer;

        procedure Incrementer(Gauche: Integer; Droit: Integer) is
        begin
            if Google.Matrice(Gauche, Droit) = 0.0 then       -- Verifier si il n'existe pas plusieurs liaisons identiques.
                L(Gauche) := L(Gauche) + 1;
                Google.Matrice(Gauche, Droit) := 1.0;
            end if;
        end Incrementer;

        procedure Calculer_Sortants is
            new LC_Integer_Integer.Pour_Chaque(Incrementer);

        procedure Populer(Gauche: Integer; Droit: Integer) is
        begin
            Google.Matrice(Gauche, Droit) := 1.0/T_Digits(L(Gauche));
        end Populer;

        procedure Populer_Liste is
            new LC_Integer_Integer.Pour_Chaque(Populer);

    begin
        for J in 0..Google.Taille-1 loop
            L(J) := 0;
        end loop;

        Calculer_Sortants(Liens);
        Populer_Liste(Liens);

        for I in 0..Google.Taille-1 loop
            for J in 0..Google.Taille-1 loop
                if L(I) = 0 then
                    Google.Matrice(I,J) := 1.0/T_Digits(Google.Taille);
                end if;

                Google.Matrice(I,J) := Google.Matrice(I,J)*Google.Alpha + (1.0-Google.Alpha)/T_Digits(Google.Taille);
            end loop;
        end loop;
    end Creer;

    procedure Calculer_Rangs(Google: in T_Google; Rangs: out Vecteur_Poids.T_Vecteur) is
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
                    Temp := Temp + Vecteur_Digit.Valeur(Poids_Original, J)*Google.Matrice.all(J,I);
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
        procedure Free is
		    new Ada.Unchecked_Deallocation (Object => T_Matrice, Name => T_Matrice_Access);
    begin
        Free(Google.Matrice);
    end Vider;

end Google_Naive;
