with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Float_Text_IO;    use Ada.Float_Text_IO;

-- Afficher une valeur approchée de la racine carréé d'un nombre réel
procedure Racine_Carree_Rang is

	Epsilon: constant Float := 1.0e-6;	-- précision souhaitée

	A: Float;  		-- le nombre dont on veut calculer la racine carrée
	Racine: Float;	-- valeur approchée de la racine carrée de A
    Ancien: Float;  -- valeur du terme precedent de la racine
begin
	-- Demander la valeur (sans contrôle)
	Get (A);

	-- Déterminer la valeur approchée de la racine carrée
    Racine := A;
	loop
        exit when Racine <= 0.0;
        Ancien := Racine;
       	Racine := (Racine + A/Racine)/2.0;
        exit when Abs(Racine - Ancien) < Epsilon;
    end loop;

	-- Afficher la valeur approchée de la racine carrée
	Put (Racine, Exp => 0, Aft => 4);
	New_Line;

end Racine_Carree_Rang;
