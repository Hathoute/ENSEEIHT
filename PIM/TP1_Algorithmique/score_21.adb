with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

procedure Score_21 is

	De1, De2 : Integer;	-- les deux dés
	Score: Integer;		-- le score obtenu avec les deux dés
begin
	-- Demander la valeur des dés
	Get (De1);
	Get (De2);

	-- Déterminer le score
	Score := 0;
    if (De1 = 1 and De2 = 2) or (De2 = 1 and De1 = 2) then
        Score := 21;
    elsif De1 = De2 then
        Score := 10 + De1;
    elsif De1 - De2 = 1 or De1 - De2 = -1 then
        Score := De1 + De2;
    end if;

	-- Afficher le score
	Put ("Score : ");
	Put (Score, 1);
	New_Line;

end Score_21;
