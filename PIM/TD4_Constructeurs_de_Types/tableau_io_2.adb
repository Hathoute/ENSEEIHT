-- Score PIXAL le 07/10/2020 à 17:18 : 100%

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

	procedure Lire (Tableau: out T_Tableau; Depassement: out Boolean) is
        Element: Integer;
    begin
        Depassement := False;
        Tableau.Taille := 0;
        Get(Element);

        while Element /= -1 loop
            if Tableau.Taille = 10 then
                Depassement := True;
            else
                Tableau.Taille := Tableau.Taille + 1;
                Tableau.Elements(Tableau.Taille) := Element;
            end if;

            Get(Element);
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


	Tab1: T_Tableau;		-- Un tableau
	Depassement: Boolean;	-- Y-a-t-il dépassemnt pendant la saisie ?
begin
	Lire (Tab1, Depassement);
	if Depassement then
		Put_Line ("Données tronquées");
	else
		null;
	end if;

	-- Afficher le tableau lu
	Put ("Tableau lu : ");
	Ecrire (Tab1);
	New_Line;

end Tableau_IO;

