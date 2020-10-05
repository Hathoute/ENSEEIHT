with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

procedure Table_Pythagore is

	Taille: Integer;	-- taille de la table
begin
	-- Demander la taille
	Get (Taille);

	-- Afficher la table de Pythagore
	for I in 0 .. Taille loop
        for J in 0 .. Taille loop
            if I = 0 and J = 0 then
               Put("X");
            elsif I = 0 then
               Put(J, 3);
            elsif J = 0 then
               Put(I, 1);
            else
                Put(I*J, 3);
            end if;
        end loop;

        New_Line;
    end loop;

end Table_Pythagore;
