with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

procedure Compte_Jules is

	Objectif: Integer;	-- Somme souhaitée sur le compte de Jules
	Age: Integer;		-- Age de Jules
	Solde: Integer;		-- Solde du compte de Jules

begin
	-- Demander la somme souhaitée
	Get (Objectif);
    Age := 0;
    Solde := 0;

	-- Déterminer l'âge de Jules pour avoir au moins somme sur son compte
    while Objectif > Solde loop
        Solde := Solde + 100 + Age * 2;
        Age := Age + 1;
    end loop;
    Age := Age - 1;

	-- Afficher l'âge que doit avoir Jule
	Put ("Age : ");
	Put (Age, 1);
	New_Line;

end Compte_Jules;
