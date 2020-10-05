-- Auteurs : HATHOUTE Hamza, GUEMIL Walid
-- Equipe  : 
-- Mini-projet 1 : Le jeu du devin

with Ada.Text_Io;          use Ada.Text_Io;
with Ada.Integer_Text_Io;  use Ada.Integer_Text_Io;

-- TODO: à compléter...
procedure Jeu_Devin is

	Min : constant Integer := 1;
	Max : constant Integer := 999;
		-- les nombres à trouver sont entre Min et Max

	-- TODO: Mettre le bon commentaire !
	procedure  Faire_deviner_un_nombre is	-- TODO: Donner un nom significatif !
		-- TODO: Déclarer ici les variables nécessaires pour cet exercice
        a: Integer;
        x: Integer;
        compteur: Integer;
	begin
		Put ("J'ai choisi ");
         Get (a);
    
        compteur := 0;
    
        loop
            Put ("Proposez un nombre : ");
            Get (x);
        
            if x>a then
                Put_Line ("Le nombre proposé est trop grand.");
            elsif x<a then
                Put_Line("Le nombre proposé est trop petit.");
            else
                Put_Line ("Trouvé !");
            end if;
        
            compteur := compteur + 1;
        
        exit when x=a;
        end loop;
        Put ("Bravo !  Vous avez trouvé en ");
        Put (Compteur,1);
        Put_Line (" essai(s).");
    
	end Faire_deviner_un_nombre;	-- TODO: à changer



	-- TODO: Mettre le bon commentaire !
	procedure Deviner_un_nombre is	-- TODO: Donner un nom significatif !
		-- TODO: Déclarer ici les variables nécessaires pour cet exercice
        BorneMin: Integer;      -- la borne minimale.
        BorneMax: Integer;      -- la borne maximale.
        Nombre: Integer;        -- le nombre que l'ordinateur devine
        Essaies: Integer;       -- le nombre d'essaies
        Choix: Character;       -- le choix de l'utilisateur
	begin
		loop
		    Put("Avez-vous choisi un nombre compris entre 1 et 999 (o/n) ? ");
            Get(Choix);
            exit when Choix = 'o';
            Put_Line("J'attends...");
        end loop;

        -- Initialiser les variables
        BorneMin := Min;
        BorneMax := Max;
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
	end Deviner_un_nombre;
	
choix: Integer;


	-- TODO: Déclarer ici les variables pour le programme principal
begin

    loop
        New_Line;
        Put_Line ("1- L'ordinateur choisit un nombre et vous le devinez");
        Put_Line ("2- Vous choisissez un nombre et l'ordinateur le devine");
        Put_Line ("0- Quitter");
        Put("Votre choix :");
        Get (choix);
        New_Line;
        case choix is 
            when 1 => Faire_deviner_un_nombre;  
            when 2 => Deviner_un_nombre;    
            when others => null;
        end case;
    exit when choix = 0;
    end loop;


	
end Jeu_Devin;