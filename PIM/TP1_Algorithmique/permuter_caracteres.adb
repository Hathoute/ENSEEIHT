with Ada.Text_IO;          use Ada.Text_IO;

-- Permuter deux caractères lus au clavier
procedure Permuter_Caracteres is

    C1, C2: Character;  -- Entier lu au clavier dont on veut connaître le signe
    Temp: Character;    -- Charactere utilisé pour la permutation

begin
    -- Demander les deux caractères C1 et C2
    Get (C1);
	Skip_Line;
    Get (C2);
	Skip_Line;

	-- Afficher C1
	Put_Line ("C1 = '" & C1 & "'");

	-- Afficher C2
	Put_Line ("C2 = '" & C2 & "'");

	-- Permuter C1 et C2
    Temp := C1;
    C1 := C2;
    C2 := Temp;

	-- Afficher C1
	Put_Line ("C1 = '" & C1 & "'");

	-- Afficher C2
	Put_Line ("C2 = '" & C2 & "'");

end Permuter_Caracteres;
