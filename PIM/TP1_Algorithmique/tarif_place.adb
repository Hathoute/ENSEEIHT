with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;    use Ada.Float_Text_IO;

-- Afficher le tarif d'une place
procedure Tarif_Place is

	Age: Integer;  -- l'âge de la personne
	Tarif: Float;  -- le tarif à appliquer
begin
	-- Demander l'age
	Get (Age);

	-- Déterminer le tarif de la place
	Tarif := 12.60;
    if Age < 14 then
       Tarif := 7.0;
    elsif Age >= 65 then
       Tarif := 10.30;
    end if;

	-- Afficher le tarif
	Put ("Le tarif pour ");
	Put (Age, 1);
	Put (" ans est ");
	Put (Tarif, Exp => 0, Aft => 2, Fore => 1);
	Put (" euros.");
	New_Line;

end Tarif_Place;
