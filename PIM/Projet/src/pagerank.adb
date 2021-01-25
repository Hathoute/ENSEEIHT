with Module_IO;
with Google_Naive;
with Google_Creuse;
with Types;                     use Types;
with Ada.Strings.Unbounded;     use Ada.Strings.Unbounded;
with Ada.Command_Line;          use Ada.Command_Line;

procedure PageRank is

    package Module_IO_A is 
        new Module_IO(Float);
    use Module_IO_A;

    ImpNaive: Boolean;
    PagesNum: Integer;
    MaxIterations: Integer; 
    Alpha: T_Digits; 
    NomFichier: Unbounded_String;

    Liens: LC_Integer_Integer.T_LC;
    Rangs: Vecteur_Poids.T_Vecteur;

    procedure Trier_Rangs is
		new Vecteur_Poids.Trier("<");

    procedure Lire_Ligne_Commande is
    begin
        ImpNaive := False;
        MaxIterations := 150;
        Alpha := 0.85;
        NomFichier := To_Unbounded_String("");

        declare
           I : Integer := 1;
        begin
            while I <= Argument_Count loop
                if Argument (I) = "-P" then
                    ImpNaive := True;
                elsif Argument (I) = "-I" then
                    MaxIterations := Integer'Value(Argument(I+1));
                    I := I+1;
                elsif Argument (I) = "-A" then
                    Alpha := T_Digits'Value(Argument(I+1));
                    I := I+1;
                else
                    -- Enlever les ".net" du nom
                    NomFichier := To_Unbounded_String(Argument(I)(Argument(I)'First .. Argument(I)'Last-4));
                end if;

                I := I+1;
            end loop;
        end;

    end Lire_Ligne_Commande;

    procedure Calculer_Rangs (Liens: in LC_Integer_Integer.T_LC; Rangs: out Vecteur_Poids.T_Vecteur) is
    begin
        if ImpNaive then
            declare
                Google: Google_Naive.T_Google;
            begin
                Google_Naive.Initialiser(Google, PagesNum, MaxIterations, Alpha);
                Google_Naive.Creer(Google, Liens);
                Google_Naive.Calculer_Rangs(Google, Rangs);
                Google_Naive.Vider(Google);
            end;
        else
            declare
                Google: Google_Creuse.T_Google;
            begin
                Google_Creuse.Initialiser(Google, PagesNum, MaxIterations, Alpha);
                Google_Creuse.Creer(Google, Liens);
                Google_Creuse.Calculer_Rangs(Google, Rangs);
                Google_Creuse.Vider(Google);
            end;
        end if;

    end Calculer_Rangs;

    procedure Vider(Liens: in out LC_Integer_Integer.T_LC; Rangs: in out Vecteur_Poids.T_Vecteur) is
    begin
        Vecteur_Poids.Vider(Rangs);
        LC_Integer_Integer.Vider(Liens);
    end Vider;

begin
    
    Lire_Ligne_Commande;

    Lire(NomFichier, PagesNum, Liens);

    Calculer_Rangs(Liens, Rangs);

    Trier_Rangs(Rangs);
    
    Ecrire(NomFichier, PagesNum, MaxIterations, Alpha, Rangs);

    Vider(Liens, Rangs);

end PageRank;