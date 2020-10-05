with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

procedure Ecrire_Entier is

	-- Écrire un entier.
	-- Paramètres :
	--    Nombre : l'entier à écrire
	-- Nécessite : Nombre >= 0	-- Nombre positif
	-- Assure : -- Nombre est écrit
	procedure Ecrire_Recursif (Nombre: in Integer) is
        Chiffre: Integer;
        Char: Character;
    begin
        if Nombre < 10 then
           Put(Character'Val (Character'Pos('0') + Nombre));
           return;
        end if;

        Chiffre := Nombre mod 10;
        Char := Character'Val (Character'Pos('0') + Chiffre);
        Ecrire_Recursif(Nombre / 10);
		Put(Char);
	end Ecrire_Recursif;


	-- Écrire un entier.
	-- Paramètres :
	--    Nombre : l'entier à écrire
	-- Nécessite : Nombre >= 0	-- Nombre positif
	-- Assure : -- Nombre est écrit
	procedure Ecrire_Iteratif (Nombre: in Integer) is
        Iteration: Integer;
        Nbr: Integer;
	begin
        Iteration := 0;
        Nbr := Nombre;

        while (Nombre / 10**Iteration) > 9 loop
            Iteration := Iteration + 1;
        end loop;
        
		for I in reverse 0 .. Iteration loop
            Put(Character'Val (Character'Pos('0') + (Nbr / 10 ** I)));
            Nbr := Nbr mod (10 ** I);
        end loop;
	end Ecrire_Iteratif;


	-- Écrire un entier.
	-- Paramètres :
	--    Nombre : l'entier à écrire
	-- Nécessite : ---
	-- Assure : -- Nombre est écrit
	procedure Ecrire (Nombre: in Integer) is
	begin
		-- Cas special: Integer'FIRST
		if Nombre = Integer'First then
			Put("-2");
			Ecrire_Recursif((-1*Nombre) mod 1000000000);
		elsif Nombre < 0 then
			Put('-');
			Ecrire_Recursif(-1*Nombre);
		else
			Ecrire_Recursif(Nombre);
		end if;
	end Ecrire;


	Un_Entier: Integer;	    -- un entier lu au clavier
	Message: constant String := "L'entier lu est ";
begin
	-- Demander un entier
	Put ("Un entier : ");
	Get (Un_Entier);
	
	-- Afficher l'entier lu avec les différents sous-programmes
	if Un_Entier >= 0 then
		-- L'afficher avec Ecrire_Recursif
		Put (Message & "(Ecrire_Recursif) : ");
		Ecrire_Recursif (Un_Entier);
		New_Line;

		-- L'afficher avec Ecrire_Iteratif
		Put (Message & "(Ecrire_Iteratif) : ");
		Ecrire_Iteratif (Un_Entier);
		New_Line;
	else
		Put_Line ("Le nombre est négatif. "
			& "On ne peut utiliser ni Ecrire_Recursif ni Ecrire_Iteratif.");
	end if;
	--  L'afficher avec Ecrire
	Put (Message & "(Ecrire) : ");
	Ecrire (Un_Entier);
	New_Line;

end Ecrire_Entier;
