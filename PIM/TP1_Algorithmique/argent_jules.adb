-- Demander l'age de Jules
with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

procedure Argent_Jules is

	Age: Integer;			-- Age de Jules
	Versements: Integer;	-- Versements réalisés sur le compte de Jules
begin
	-- Demander l'age de Jules
	Get (Age);

	-- Déterminer la somme des versements réalisés par les parents de Jules
	Versements := 100 + 100 * Age + Age * (Age + 1);

	-- Afficher la somme des versements
	Put (Versements, 1);
	New_Line;
end Argent_Jules;
