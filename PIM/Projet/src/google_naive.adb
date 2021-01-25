with Ada.Unchecked_Deallocation;

package body Google_Naive is

	procedure Initialiser(Google: out T_Google) is
	begin
        for I in 0..Taille-1 loop
            for J in 0..Taille-1 loop
                Google.G(I,J) := 0.0;
            end loop;
        end loop;
	end Initialiser;

    procedure Creer(Google: in out T_Google; Liens: in LC_Integer_Integer.T_LC) is
        L: array(0..Taille-1) of Integer;

        procedure Incrementer(Gauche: Integer; Droit: Integer) is
        begin
            if Google.G(Gauche, Droit) = 0.0 then       -- Verifier si il n'existe pas plusieurs liaisons identiques.
                L(Gauche) := L(Gauche) + 1;
                Google.G(Gauche, Droit) := 1.0;
            end if;
        end Incrementer;

        procedure Calculer_Sortants is
            new LC_Integer_Integer.Pour_Chaque(Incrementer);

        procedure Populer(Gauche: Integer; Droit: Integer) is
        begin
            Google.G(Gauche, Droit) := 1.0/T_Precision(L(Gauche));
        end Populer;

        procedure Populer_Liste is
            new LC_Integer_Integer.Pour_Chaque(Populer);

    begin
        for J in 0..Taille-1 loop
            L(J) := 0;
        end loop;

        Calculer_Sortants(Liens);
        Populer_Liste(Liens);

        for I in 0..Taille-1 loop
            for J in 0..Taille-1 loop
                if L(I) = 0 then
                    Google.G(I,J) := 1.0/T_Precision(Taille);
                end if;

                Google.G(I,J) := Google.G(I,J)*Alpha + (1.0-Alpha)/T_Precision(Taille);
            end loop;
        end loop;
    end Creer;

    procedure Calculer_Rangs(Google: in T_Google; Rangs: out Vecteur_Poids.T_Vecteur) is
        Poids: Vecteur_Precision.T_Vecteur;
        Poids_Original: Vecteur_Precision.T_Vecteur;
        Temp: T_Precision;

    begin
        Vecteur_Precision.Initialiser(Poids, Taille);

        for I in 0..Taille-1 loop
            Vecteur_Precision.Ajouter(Poids, 1.0/T_Precision(Taille));
        end loop;

        for tmp in 1..MaxIterations loop
            Vecteur_Precision.Copier(Poids_Original, Poids);
            for I in 0..Taille-1 loop
                Temp := 0.0;
                for J in 0..Taille-1 loop
                    Temp := Temp + Vecteur_Precision.Valeur(Poids_Original, J)*Google.G(J,I);
                end loop;
                Vecteur_Precision.Modifier(Poids, I, Temp);
            end loop;
            Vecteur_Precision.Vider(Poids_Original);
        end loop;

        Vecteur_Poids.Initialiser(Rangs, Taille);
        for I in 0..Taille-1 loop
            Vecteur_Poids.Ajouter(Rangs, (Rang => I, Poid => T_Digits(Vecteur_Precision.Valeur(Poids, I))));
        end loop;
        
        Vecteur_Precision.Vider(Poids);
    end Calculer_Rangs;

end Google_Naive;
