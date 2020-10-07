-- Score PIXAL le 07/10/2020 à 17:34 : 100%

with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

-- Lire et écrire un tableau d'entiers.
procedure Tableau_IO is

	Capacite: constant Integer := 10;	-- Cette taille est arbitraire

	type T_TableauBrut is array (1..Capacite) of Integer;

	type T_Tableau is
		record
			Elements: T_TableauBrut;
			Taille: Integer;
			-- Invariant: 0 <= Taille and Taille <= Capacite;
		end record;


--------------------[ Ne pas changer le code qui précède ]---------------------

	procedure Lire (Tableau: out T_Tableau; Default: in Integer) is
        Indice: Integer;
    begin
        Tableau.Taille := 0;
        for J in 1..Capacite loop
            Tableau.Elements(J) := Default;
        end loop;

        Put("Indice (-1 pour arrêter) ? ");
        Get(Indice);
        while Indice /= -1 loop
            if Indice > Capacite or Indice < 1 then
                Put("Erreur : l'indice doit être entre 1 et ");
                Put(Capacite, 0);
                Put_Line(".");
            else
                Put("Valeur ? ");
                Get(Tableau.Elements(Indice));
                if Indice > Tableau.Taille then
                    Tableau.Taille := Indice;
                end if;
            end if;

            Put("Indice (-1 pour arrêter) ? ");
            Get(Indice);
        end loop;
    end Lire;

    procedure Ecrire (Tableau: in T_Tableau) is
    begin
        Put("[");
        for J in 1..Tableau.Taille loop
            if J > 1 then
               Put(", ");
            end if;
            Put(Tableau.Elements(J), 1);
        end loop;
        Put("]");
    end Ecrire;
----[ Ne pas changer le code qui suit, sauf pour la question optionnelle  ]----


	Tab1: T_Tableau;	-- Un tableau
	Defaut: Integer;	-- Valeur par défaut
begin
	-- Demander la valeur par défaut
	Put ("Valeur par défaut ? ");
	Get (Defaut);

	Lire (Tab1, Defaut);

	-- Afficher le tableau lu
	Put ("Tableau lu : ");
	Ecrire (Tab1);
	New_Line;

end Tableau_IO;
