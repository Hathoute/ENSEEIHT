-- Demander l'age de Jules
with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

-- Afficher si une personne est majeure
procedure Majorite is
    Age_Majorite: CONSTANT Integer := 18; -- Age de majorite

	Age: Integer;			-- Age de la personne
	Est_Majeure: Boolean;	-- Vrai si la personne est majeure
begin
	-- Deman16der l'age de la personne
	Get (Age);

	-- Déterminer la majorité de cette personne
	Est_Majeure := Age >= Age_Majorite;

	-- Afficher la somme des versements
	if Est_Majeure then
		Put ("Oui");
	else
		Put ("Non");
	end if;
	New_Line;
end Majorite;
