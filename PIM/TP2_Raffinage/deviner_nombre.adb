-- Auteurs : 
-- Equipe  : 
-- Mini-projet 1 : Le jeu du devin

with Ada.Text_Io;          use Ada.Text_Io;
with Ada.Integer_Text_Io;  use Ada.Integer_Text_Io;

	-- Deviner le nombre de l'utilisateur en interagissant avec lui.
	procedure Deviner_Nombre is
		--! declarations des variables du programme principal
        BorneMin: Integer;      -- la borne minimale.
        BorneMax: Integer;      -- la borne maximale.
        Nombre: Integer;        -- le nombre que l'ordinateur devine
        Essaies: Integer;       -- le nombre d'essaies
        Choix: Character;       -- le choix de l'utilisateur

	begin
        -- Demander à l'utilisateur de deviner le nombre.
        loop
		    Put("Avez-vous choisi un nombre compris entre 1 et 999 (o/n) ? ");
            Get(Choix);
            if Choix = 'n' then
                Put_Line("J'attends...");
            end if;
            exit when Choix = 'o';
        end loop;

        -- Initialiser les variables
        BorneMin := 1;
        BorneMax := 999;
        Nombre := 500;
        Essaies := 0;

        -- Chercher le nombre deviné
        loop
            -- Mettre à jour les variables
            if Choix = 'g' then
                BorneMax := Nombre - 1;
            elsif Choix = 'p' then
                BorneMin := Nombre + 1;
            end if;

            -- Verifier si l'utilisateur ne triche pas
            if BorneMax < BorneMin then
                Put_Line("Vous trichez.  J'arrête cette partie.");
                return;
            end if;

            -- Calculer le nombre
            Nombre := (BorneMin + BorneMax)/2;    -- Valeur médiane

            -- Incrementer les essaies
            Essaies := Essaies + 1;

            -- Afficher la proposition
            Put ("Je propose ");
            Put (Item => Nombre, Width => 1);
            Put_Line("");

            -- Saisir l'indice
            loop
                Put("Votre indice (t/p/g) ? ");
                Get(Choix);
                exit when Choix = 't' or Choix = 'p' or Choix = 'g';
            end loop;
            exit when Choix = 't';
        end loop;

        -- Afficher le nombre trouvé
        Put ("J'ai trouvé ");
        Put (Item => Nombre, Width => 1);
        Put(" en ");
        Put (Item => Essaies, Width => 1);
        Put(" essai(s).");
	end Deviner_Nombre;
