with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;

-- Piloter un drone au moyen d'un menu textuel.
procedure Drone is
    Demarrage: Boolean;         -- True si le drone est demarré
    Altitude: Integer;          -- Valeur de l'altitude
    Choix: Character;           -- Choix de l'utilisateur

begin
	Altitude := 0;

    loop
        Put("Altitude : ");
        Put(Altitude, 1);
        New_Line;
        New_Line;
        Put_Line("Que faire ?");
        Put_Line("    d -- Démarrer");
        Put_Line("    m -- Monter");
        Put_Line("    s -- Descendre");
        Put_Line("    q -- Quitter");
        Put("Votre choix : ");

        Get(Choix);
        if Choix = 'd' or Choix = 'D' then
            Demarrage := True;
        elsif Choix = 'm' or Choix = 'M' then
            if Demarrage then
                Altitude := Altitude + 1;
            else
                Put_Line("Le drone n'est pas démarré.");
            end if;
        elsif Choix = 's' or Choix = 'S' then
            if Demarrage then
                if Altitude = 0 then
                    Put_Line("Le drone est déjà posé.");
                else
                    Altitude := Altitude - 1;
                end if;
            else
                Put_Line("Le drone n'est pas démarré.");
            end if;
        elsif Choix = 'q' or Choix = 'Q' then
            exit;
        else
            Put_Line("Je n'ai pas compris !");
        end if;

        if Altitude > 4 then
            New_Line;
            Put_Line("Le drone est hors de portée... et donc perdu !");
            return;
        end if;

        New_Line;
    end loop;

    New_Line;
    if Demarrage then
        Put_Line("Au revoir...");
    else
        Put_Line("Vous n'avez pas réussi à le mettre en route ?");
    end if;

end Drone;
