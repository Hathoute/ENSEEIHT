with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

procedure Pour_TantQue is
    Debut: Integer;
    Fin: Integer;
begin
	-- Demander les valeurs de Debut et Fin
	Get (Debut);
	Get (Fin);

	-- Afficher les entiers de Début à Fin
    while Debut <= Fin loop
        Put(Debut);
		New_Line;
        Debut := Debut + 1;
    end loop;

end Pour_TantQue;
