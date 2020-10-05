with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

-- Afficher le nombre de jours d'un mois pour une année qui n'est pas bissextile.
-- Contrainte : le modulo est interdit (reste de la division entière).
procedure Afficher_Nombre_Jours_Mois is

	Mois: Integer;	    -- le mois saisi au clavier
	Nb_Jours: Integer;	-- le nombre de jours de Mois
begin
	-- Demander le mois
	Get (Mois);

	-- Déterminer le nombre de jours du mois
	case Mois is
       when 1|3|5|7|8|10|12 => Nb_Jours := 31;
       when 2 => Nb_Jours := 28;
       when others => Nb_Jours := 30;
    end case;

	-- Afficher le nombre de jours
	Put (Nb_Jours, 1);
	New_Line;

end Afficher_Nombre_Jours_Mois;
