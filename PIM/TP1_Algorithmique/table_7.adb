with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

-- Afficher la table de multiplication de 7
procedure Table_7 is
begin
	
    for J in 1 .. 9 loop
       Put(J, 1);
       Put(" x 7 = ");
       Put(7*J, 1);
       New_Line;
    end loop;

end Table_7;
