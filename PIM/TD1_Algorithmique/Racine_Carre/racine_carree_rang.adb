with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;    use Ada.Float_Text_IO;

-- Afficher une valeur approchée de la racine carréé d'un nombre réel
procedure Racine_Carree_Rang is

	A: Float;  		-- le nombre dont on veut calculer la racine carrée
	Rang: Integer;	-- le rang souhaité
	Racine: Float;	-- valeur approchée de la racine carrée de A
begin
	-- Demander la valeur (sans contrôle)
	Get (A);

	-- Déterminer la valeur approchée de la racine carrée
	--     Demander le rang (sans contrôle)
	Get (Rang);

	--     Calculer le terme de rang Rang de la suite
    Racine := A;
	for I in 1 .. Rang loop
		exit when Racine = 0.0;
       	Racine := (Racine + A/Racine)/2.0;
    end loop;

	-- Afficher la valeur approchée de la racine carrée
	Put (Racine, Exp => 0, Aft => 4);
	New_Line;

end Racine_Carree_Rang;
