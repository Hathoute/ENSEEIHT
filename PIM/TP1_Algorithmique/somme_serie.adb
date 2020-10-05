with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

-- Afficher la somme des valeurs d'un série dont les valeurs sont lues au clavier.
-- Pour marquer la fin de la série, la dernière valeur est doublée.
procedure Somme_Serie is

	Somme: Integer;	    	-- Somme des valeurs de la série
    Valeur: Integer;        -- Valeur lu au clavier
    Valeur_Prec: Integer;   -- Valeur precedente;

begin
    Somme := 0;

	-- Déterminer la somme des valeurs d'une série lue un clavier
	Get(Valeur);
    Valeur_Prec := Valeur + 1;
    while Valeur /= Valeur_Prec loop
       Somme := Somme + Valeur;
       Valeur_Prec := Valeur;
       Get(Valeur);
    end loop;

	-- Afficher la longueur
	Put ("Somme : ");
	Put (Somme, 1);
	New_Line;

end Somme_Serie;
