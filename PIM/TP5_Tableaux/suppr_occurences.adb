-- Score PIXAL le 07/10/2020 à 15:24 : 100%

with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

-- Supprimer toutes les occurences
procedure Suppr_Occurences is

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

    procedure Supprimer_Indice (Tableau: in out T_Tableau; Indice: in Integer) with
        Pre => Indice > 0 and Indice <= Tableau.Taille
    is
    begin
        for J in Indice..(Tableau.Taille-1) loop
            Tableau.Elements(J) := Tableau.Elements(J+1);
        end loop;

        Tableau.Taille := Tableau.Taille-1;
    end Supprimer_Indice;

    procedure Supprimer_Element(Tableau: in out T_Tableau; Element: in Integer) is
    begin
        for J in reverse 1..Tableau.Taille loop
           if Tableau.Elements(J) = Element then
                Supprimer_Indice(Tableau, J);
           end if;
        end loop;
    end Supprimer_Element;



----[ Ne pas changer le code qui suit, sauf pour la question optionnelle  ]----


	Tab1: T_Tableau;	-- Un tableau
	A_Supprimer: Integer;	-- l'élément à supprimer
begin
	-- Saisir le tableau
	Lire (Tab1);

	-- Afficher le tableau lu
	Put ("Tableau lu : ");
	Ecrire (Tab1);
	New_Line;

	-- Demander l'élément cherché
	Put ("À supprimer ? ");
	Get (A_Supprimer);

	-- Déterminer la fréquence de Cherche dans Tab1
	Supprimer_Element(Tab1, A_Supprimer);

	-- Afficher la fréquence
	Put ("Tableau après : ");
	Ecrire (Tab1);
	New_Line;

end Suppr_Occurences;
