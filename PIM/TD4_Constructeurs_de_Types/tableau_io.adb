-- Score PIXAL le 07/10/2020 à 14:33 : 100%

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

    procedure Lire_Tableau(Tableau: out T_Tableau) is
    begin
        Put("Nombre d'éléments ? ");
        Get(Tableau.Taille);

        if Tableau.Taille < 0 then
            Tableau.Taille = 0;
        end if;

        for J in 1..Tableau.Taille loop
            if J > Capacite then
                Put_Line("Données tronquées");
            else
                Put("Element ");
                Put(J, 1);
                Put(" ? ");
                Get(Tableau.Elements(J));
            end if;
        end loop;

        if Tableau.Taille > Capacite then
            Tableau.Taille := Capacite;
        end if;

    end Lire_Tableau;

    procedure Ecrire_Tableau (Tableau: in T_Tableau) is
       
    begin
        Put("[");
        for J in 1..Tableau.Taille loop
            if J > 1 then
               Put(", ");
            end if;
            Put(Tableau.Elements(J), 1);
        end loop;
        Put("]");
    end Ecrire_Tableau;


----[ Ne pas changer le code qui suit, sauf pour la question optionnelle  ]----

	Tab1: T_Tableau;	-- Un tableau
begin
	Lire_Tableau (Tab1);

	-- Afficher le tableau lu
	Put ("Tableau lu : ");
	Ecrire_Tableau (Tab1);
	New_Line;

    -- DERNIERE QUESTION:
    -- On peux ne pas modifier l'attribut Taille de T_Tableau (si ce dernier est > Capacite)
    --  et donc, dans le programme principale, si T_Tableau.Taille > Capacite, c'est que les 
    --  données ont été tronquées.

end Tableau_IO;
