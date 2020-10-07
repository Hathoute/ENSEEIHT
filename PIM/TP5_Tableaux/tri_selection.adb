-- Score PIXAL le 07/10/2020 à 15:00 : 100%

with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

--Tri par sélection
procedure Tri_Selection is

	Capacite: constant Integer := 10;	-- Cette taille est arbitraire

	type T_TableauBrut is array (1..Capacite) of Integer;

	type T_Tableau is
		record
			Elements: T_TableauBrut;
			Taille: Integer;
			-- Invariant: 0 <= Taille and Taille <= Capacite;
		end record;


	-- Initialiser un tableau Tab à partir d'éléments lus au clavier.
	-- La nombre d'éléments est d'abord demandée, suivi des éléments.
	-- Les éléments en surnombre par rapport à la capacité du tableau
	-- sont ignorés et le message "Données tronquées" est affiché.
	procedure Lire (Tab: out T_Tableau) is
		Taille_Souhaitee: Integer;
		Nb_Elements: Integer;	-- Nombre d'éléments à lire
	begin
		-- Demander la taille
		Put ("Nombre d'éléments ? ");
		Get (Taille_Souhaitee);
		if Taille_Souhaitee > Capacite then
			Nb_Elements := Capacite;
		elsif Taille_Souhaitee < 0 then
			Nb_Elements := 0;
		else
			Nb_Elements := Taille_Souhaitee;
		end if;

		-- Demander les éléments du tableau
		for N in 1..Nb_Elements loop
			Put ("Element ");
			Put (N, 1);
			Put (" ? ");
			Get (Tab.Elements (N));
		end loop;
		Tab.Taille := Nb_Elements;

		if Nb_Elements < Taille_Souhaitee then
			Put_Line ("Données tronquées");
		else
			null;
		end if;
	end Lire;


	-- Afficher le tableau.  Les éléments sont affichés entre crochets, séparés
	-- par des virgules.
	procedure Ecrire(Tab: in T_Tableau) is
	begin
		Put ('[');
		if Tab.Taille > 0 then
			-- Écrire le premier élément
			Put (Tab.Elements (1), 1);

			-- Écrire les autres éléments précédés d'une virgule
			for I in 2..Tab.Taille loop
				Put (", ");
				Put (Tab.Elements (I), 1);
			end loop;
		else
			null;
		end if;
		Put (']');
	end Ecrire;


--------------------[ Ne pas changer le code qui précède ]---------------------

    procedure Swap (Tableau: in out T_Tableau; Indice1: in Integer; Indice2: in Integer) is
        Temp: Integer;
    begin
        Temp := Tableau.Elements(Indice1);
        Tableau.Elements(Indice1) := Tableau.Elements(Indice2);
        Tableau.Elements(Indice2) := Temp;
    end Swap;

    procedure Selection_Etape (Tableau: in out T_Tableau; Etape: in Integer) is
        Min_Indice: Integer;
    begin
        Min_Indice := Etape;
        for J in (Etape+1)..Tableau.Taille loop
            if Tableau.Elements(Min_Indice) > Tableau.Elements(J) then
                Min_Indice := J;
            end if;
        end loop;

        Swap(Tableau, Min_Indice, Etape);

        Ecrire(Tableau);
        New_Line;
    end Selection_Etape;

    procedure Trier (Tableau: in out T_Tableau) is
    begin

        for J in 1..(Tableau.Taille-1) loop
            Selection_Etape(Tableau, J);
        end loop;
    end Trier;


----[ Ne pas changer le code qui suit, sauf pour la question optionnelle  ]----


	Tab1: T_Tableau;	-- Un tableau
begin
	Lire (Tab1);

	-- Afficher le tableau lu
	Put ("Tableau lu : ");
	Ecrire (Tab1);
	New_Line;

	Trier (Tab1);

	-- Afficher le tableau trié
	Put ("Tableau trié : ");
	Ecrire (Tab1);
	New_Line;

end Tri_Selection;
