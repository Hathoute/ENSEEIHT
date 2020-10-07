-- Score PIXAL le 07/10/2020 à 14:33 : 100%

with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Integer_Text_IO;     use Ada.Integer_Text_IO;

procedure Robot_Type_1 is

	-- Direction
    type T_Direction is (NORD, EST, SUD, OUEST);

    -- Robot type 1
    type T_Robot_1 is record
        Absc: Integer;           -- Abscisse du robot
        Ord: Integer;           -- Ordonnée du robot
        Orientation: T_Direction;   -- Orientation du robot
    end record;

    -- Environnement:
    MAX_X: constant Integer := 10;
    MAX_Y: constant Integer := 10;
    type T_Environnement is array (-MAX_X..MAX_X, -MAX_Y..MAX_Y) of Boolean;


--| Le programme principal |------------------------------------------------

    R1: T_Robot_1;              -- Robot 1
    R2: T_Robot_1;              -- Robot 2
	
    E1: T_Environnement;        -- L'Environnement
    
begin
	-- Initialisation de R1 pour que son abscisse soit 4, son ordonnée 2 et sa direction ouest
    R1 := (Absc => 4, Ord => 2, Orientation => OUEST);
	-- Initialisation de R2 avec R1
    R2 := R1;
	-- Modification de l'abscisse de R1 pour qu'elle devienne 3
    R1.Absc := 3;

	-- Afficher l'abscisse de R1. La valeur affichée sera 3
	Put ("Abscisse de R1 : ");
	Put (R1.Absc, 1);
	New_Line;

	-- Afficher l'abscisse de R2. La valeur affichée sera 4
	Put ("Abscisse de R2 : ");
	Put (R2.Absc, 1);
	New_Line;

	-- Modifier l'environnement pour que la case de coordonnées (4,2) soit libre.
    E1(4, 2) := True;

	-- Afficher "OK" si le robot R1 est sur une case libre, "ERREUR" sinon
	if E1(R1.Absc, R1.Ord) then
		Put_Line ("OK");
	else
		Put_Line ("ERREUR");
	end if;

    --! Résponses aux questions:
    -- 1: T_Direction est Enum (NORD, EST, SUD, OUEST)
    --      T_Robot_1 est Enregistrement: X is Integer, Y is Integer, Direction is T_Direction.
    --
    -- 2: T_Environnement est Matrice (minX..maxX, minY..maxY) de type Boolean
    --
    -- 3: Obtenir son abscisse: x := robot.X
    --      robot.Direction := NORD
    --      environnement(robot.x, robot.y) (retourne un boolean)
    --
    -- 4: Les sous-programmes à ajouter: Tourner_Droite, Avancer.

end Robot_Type_1;
