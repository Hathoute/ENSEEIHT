with Ada.Text_IO;  use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with System.Multiprocessors; use System.Multiprocessors;
with System.Multiprocessors.Dispatching_Domains; use System.Multiprocessors.Dispatching_Domains;

package body Google_Creuse is

	procedure Initialiser(Google: out T_Google) is
	begin
        Vecteur_Matrice.Initialiser(Google.Matrice_Creuse, Taille);
        Google.Addition := (1.0-Alpha)/T_Precision(Taille);
        Google.PreVide := Alpha/T_Precision(Taille) + Google.Addition;
	end Initialiser;

    procedure Creer(Google: in out T_Google; Liens: in LC_Integer_Integer.T_LC) is
        TH: TH_Matrice.T_TH;
        LCA: TH_Matrice.T_LCA_C.T_LCA;
        Vecteur: Vecteur_Matrice.T_Vecteur;

        procedure Incrementer(Gauche: Integer; Droit: Integer) is
        begin
            if not TH_Matrice.Cle_Presente(TH, (Gauche, Droit)) then       -- Verifier si il n'existe pas plusieurs liaisons identiques.
                TH_Matrice.Enregistrer(TH, (Gauche, Droit), 1.0);
                Vecteur_Integer.Modifier(Google.Sortants, Gauche, Vecteur_Integer.Valeur(Google.Sortants, Gauche) + 1);
            end if;
        end Incrementer;
        procedure Calculer_Sortants is
            new LC_Integer_Integer.Pour_Chaque(Incrementer);


        procedure Populer(Gauche: Integer; Droit: Integer) is
        begin
            TH_Matrice.Enregistrer(TH, (Droit, Gauche), T_Precision(Alpha)*1.0/T_Precision(Vecteur_Integer.Valeur(Google.Sortants,Gauche)) + Google.Addition);
        end Populer;
        procedure Populer_Liste is
            new LC_Integer_Integer.Pour_Chaque(Populer);


        procedure Inserer (Indice: T_Indice; Valeur: T_Precision) is
            Valeur_Matrice: T_Matrice_Valeur;
        begin
            Valeur_Matrice.Indice := Indice;
            Valeur_Matrice.Valeur := Valeur;
            Vecteur_Matrice.Ajouter(Vecteur, Valeur_Matrice);
        end Inserer;
        procedure Convertir_Vecteur is
            new TH_Matrice.T_LCA_C.Pour_Chaque (Inserer);


        function Comparer_Indice(Val1: T_Matrice_Valeur; Val2: T_Matrice_Valeur) return Boolean is
        begin
            return Val1.Indice.Y > Val2.Indice.Y;
        end Comparer_Indice;
        procedure Ordonner_Vecteur is
            new Vecteur_Matrice.Trier(Comparer_Indice);


        procedure Ajouter(Valeur_Matrice: T_Matrice_Valeur) is
        begin
            Vecteur_Matrice.Ajouter(Google.Matrice_Creuse, Valeur_Matrice);
        end Ajouter;
        procedure Combiner_Vecteurs is
            new Vecteur_Matrice.Pour_Chaque(Ajouter);

    begin
        TH_Matrice.Initialiser(TH, Taille);
        Vecteur_Integer.Initialiser(Google.Sortants, Taille);

        for J in 0..Taille-1 loop
            Vecteur_Integer.Ajouter(Google.Sortants, 0);
        end loop;

        Calculer_Sortants(Liens);
        TH_Matrice.Vider(TH);
        Populer_Liste(Liens);

        Vecteur_Matrice.Initialiser(Google.Matrice_Creuse, TH_Matrice.Taille(TH));

        for I in 0..Taille-1 loop
            LCA := TH_Matrice.LCA(TH, (I, 0));
            if TH_Matrice.T_LCA_C.Taille(LCA) /= 0 then
                Vecteur_Matrice.Initialiser(Vecteur, TH_Matrice.T_LCA_C.Taille(LCA));
                Convertir_Vecteur(LCA);
                Ordonner_Vecteur(Vecteur);
                Combiner_Vecteurs(Vecteur);
                Vecteur_Matrice.Vider(Vecteur);
            end if;
        end loop;
    end Creer;

    procedure Calculer_Rangs(Google: in out T_Google; Rangs: out Vecteur_Poids.T_Vecteur) is 
        Poids: Vecteur_Precision.T_Vecteur;
        Poids_Original: Vecteur_Precision.T_Vecteur;
        Finished: array (1..4) of Boolean;
        Bords: array (1..5) of Integer;
        Count: Integer;
        Matrice_Val: T_Matrice_Valeur;

        task type TT(Id: Integer; CPU_Id: CPU_Range)
            with CPU => CPU_Id
        is
            entry Start(Matrice: Vecteur_Matrice.T_Vecteur; Poids_Original: Vecteur_Precision.T_Vecteur);
        end TT;

        task body TT is
            Matrice_Valeur: T_Matrice_Valeur;
            pCount: Integer;
            Temp: T_Precision;
        begin
            loop select
                accept Start(Matrice: Vecteur_Matrice.T_Vecteur; Poids_Original: Vecteur_Precision.T_Vecteur) do
                    Finished(Id) := false;
                end Start;

                pCount := Bords(Id);
                Matrice_Valeur := Vecteur_Matrice.Valeur(Google.Matrice_Creuse, pCount);
                for I in Taille*(Id-1)/4..Taille*Id/4-1 loop
                    Temp := 0.0;
                    for J in 0..Taille-1 loop
                        if Matrice_Valeur.Indice.X = I and Matrice_Valeur.Indice.Y = J then
                            Temp := Temp + Vecteur_Precision.Valeur(Poids_Original, J)*Matrice_Valeur.Valeur;
                            if Bords(Id+1) = pCount+1 then
                                Matrice_Valeur.Indice.X := Taille;
                            else
                                pCount := pCount + 1;
                                Matrice_Valeur := Vecteur_Matrice.Valeur(Google.Matrice_Creuse, pCount);
                            end if;
                        else
                            Temp := Temp + Vecteur_Precision.Valeur(Poids_Original, J)*Google.Addition;
                            null;
                        end if;
                    end loop;
                    Vecteur_Precision.Modifier(Poids, I, Temp);
                end loop;
                Finished(Id) := true;
            or 
                terminate;
            end select; end loop;
        end TT;

        Task1: TT(1, Not_A_Specific_CPU);
        Task2: TT(2, Not_A_Specific_CPU);
        Task3: TT(3, Not_A_Specific_CPU);
        Task4: TT(4, Not_A_Specific_CPU);
    begin

        Vecteur_Precision.Initialiser(Poids, Taille);

        for I in 0..Taille-1 loop
            Vecteur_Precision.Ajouter(Poids, 1.0/T_Precision(Taille));
        end loop;

        
        Bords(1) := 0;
        Count := 1;
        for I in 0..Vecteur_Matrice.Taille(Google.Matrice_Creuse)-1 loop
            Matrice_Val := Vecteur_Matrice.Valeur(Google.Matrice_Creuse, I);
            while Matrice_Val.Indice.X >= Taille*Count/4 loop
                Count := Count + 1;
                Bords(Count) := I;
            end loop;
        end loop;
        Count := Count + 1;
        Bords(Count) := Vecteur_Matrice.Taille(Google.Matrice_Creuse);


        for tmp in 1..MaxIterations loop
            Count := 1;
            Vecteur_Precision.Copier(Poids_Original, Poids);
            for I in 0..Taille-1 loop
                if Vecteur_Integer.Valeur(Google.Sortants, I) = 0 then
                    Vecteur_Precision.Modifier(Poids_Original, I, Vecteur_Precision.Valeur(Poids_Original, I)*Google.PreVide/Google.Addition);
                end if;
            end loop;

            Task1.Start(Google.Matrice_Creuse, Poids_Original);
            Task2.Start(Google.Matrice_Creuse, Poids_Original);
            Task3.Start(Google.Matrice_Creuse, Poids_Original);
            Task4.Start(Google.Matrice_Creuse, Poids_Original);

            while not Finished(1) or else not Finished(2) or else not Finished(3) or else not Finished(4) loop
               null;    -- Attendre le resultat...
            end loop;

            Vecteur_Precision.Vider(Poids_Original);
        end loop;

        Put_Line("Fin des itérations");

        Vecteur_Poids.Initialiser(Rangs, Taille);
        for I in 0..Taille-1 loop
            declare
               Rank: T_Rank := (Rang => I, Poid => T_Digits(Vecteur_Precision.Valeur(Poids, I)));
            begin
                Vecteur_Poids.Ajouter(Rangs, Rank);
            end;
        end loop;
        
        Vecteur_Precision.Vider(Poids);

    end Calculer_Rangs;

end Google_Creuse;
