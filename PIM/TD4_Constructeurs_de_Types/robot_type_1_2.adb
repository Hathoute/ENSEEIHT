-- Score PIXAL le 07/10/2020 à 17:04 : 100%

with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Integer_Text_IO;     use Ada.Integer_Text_IO;
with Ada.Characters.Handling; use Ada.Characters.Handling;

procedure Robot_Type_1 is

--| Le type T_Direction |---------------------------------------------------

	type T_Direction is (NORD, EST, SUD, OUEST);


	procedure Get_Direction (Direction: out T_Direction ; Consigne: String) is
		Taille_Max: constant Integer := 10;			-- suffisant pour une direction
		Direction_Texte: String (1..Taille_Max);	-- une direction lue au clavier
		Taille: Integer;			-- la taille effective de Direction_Texte
	begin
		-- Demander la direction (String)
		Put (Consigne);
		Get_Line (Direction_Texte, Taille);		--! Lire une chaîne de caractère
			--! Réalise un Skip_Line

		-- Convertir la direction en texte en T_Direction
		Direction := T_Direction'Value (To_Upper (Direction_Texte (1..Taille)));
	end Get_Direction;


--| Le type T_Robot |-------------------------------------------------------

	type T_Robot is
		--    ^ Y
		--    |
		--    |         Robot de coordonnées (4, 2) direction OUEST
		--  2 |      <o
		--  1 |
		--   -+-------------------------------->
		--    | 1 2 3 4                        Y
		record
			Abscisse, Ordonnee: Integer;	-- les coordonnées
			Direction: T_Direction;			-- direction du robot
		end record;


	-- Initialiser un robot à partir se son abscisse, sont ordonnée et sa direction.
	procedure Initialiser (
			Robot : out T_Robot;
			Abscisse, Ordonnee: in Integer;
			Direction: T_Direction
			) with
		Post => Robot.Abscisse = Abscisse
			and Robot.Ordonnee = Ordonnee
			and Robot.Direction = Direction
	is
	begin
		Robot := T_Robot'(Abscisse, Ordonnee, Direction);
	end Initialiser;


	-- Afficher un robot sous la forme "(X, Y)>Direction>".
	procedure Put (Robot: in T_Robot) is
	begin
		Put ("(");
		Put (Robot.Abscisse, 1);
		Put (", ");
		Put (Robot.Ordonnee, 1);
		Put (")>");
		Put (To_Lower (T_Direction'Image(Robot.Direction)));
		Put (">");
	end Put;


	-- Afficher un robot en ajout un retour à la ligne.
	procedure Put_Line (Robot: in T_Robot) is
	begin
		Put (Robot);
		New_Line;
	end Put_Line;


	-- Faire avancer le robot d'une case suivant sa direction courante.
	procedure Avancer (Robot : in out T_Robot) is
	begin
		case Robot.Direction is
			when NORD => Robot.Ordonnee := Robot.Ordonnee + 1;
			when SUD => Robot.Ordonnee := Robot.Ordonnee - 1;
			when EST => Robot.Abscisse := Robot.Abscisse + 1;
			when OUEST => Robot.Abscisse := Robot.Abscisse - 1;
		end case;
	end Avancer;


	-- Faire pivoter le robot dans le sens NORD, EST, SUD, OUEST
	procedure Pivoter (Robot : in out T_Robot) is
	begin
		Robot.Direction := T_Direction'Val((T_Direction'Pos(Robot.Direction) + 1) mod 4);
	end Pivoter;


--| Le type T_Environnement |-----------------------------------------------

	MAX_X: constant Integer := 100;
	MAX_Y: constant Integer := 50;

	type T_Case is (LIBRE, OBSTACLE);
	type T_Environnement is array (-MAX_x..MAX_X, -MAX_Y..MAX_Y) of T_Case;


	-- Faire avancer le robot d'une case suivant sa direction courante dans une
	-- environnement.  On considère qu'il peut y avoir plusieurs robots dans la
	-- même case de l'environnement.  Le robot n'avance pas s'il y a un obstrable.
	-- Il ne peut pas sortir de l'environnement.
	procedure Avancer (Robot : in out T_Robot ; Environnement : T_Environnement) with
		Pre => -MAX_X <= Robot.Abscisse and Robot.Abscisse <= Max_X
			and -MAX_Y <= Robot.Ordonnee and Robot.Ordonnee <= Max_Y
	is
		type T_VecteurDeplacement is array (T_Direction) of Integer;
			-- Invariant : les valeurs sont 0, 1 ou -1

		DX: constant T_VecteurDeplacement := (0, 1, 0, -1);
			-- déplacmeent suivant l'axe des X

		DY: constant T_VecteurDeplacement := (1, 0, -1, 0);
			-- déplacmeent suivant l'axe des Y

		Nouveau_X, Nouveau_Y: Integer; -- nouvelles coordonnées du robot si pas d'obstacle
	begin
		-- Calculer les nouvelles coordonnées théoriques du robot
		Nouveau_X := Robot.Abscisse + DX (Robot.direction);
		Nouveau_Y := Robot.Ordonnee + DY (Robot.direction);

		if (-MAX_X <= Nouveau_X and Nouveau_X <= Max_X
			and -MAX_Y <= Nouveau_Y and Nouveau_Y <= Max_Y)
			and then Environnement (Nouveau_X, Nouveau_Y) = LIBRE
		then
			Robot.Abscisse := Nouveau_X;
			Robot.Ordonnee := Nouveau_Y;
		else
			null;	-- le robot ne bouge pas
		end if;
	end Avancer;


	-- Faire pivoter le robot dans le sens NORD, EST, SUD, OUEST dans
	-- l'environnement considéré.
	-- Remarque : l'environnement n'a pas d'impact sur cette opération.
	procedure Pivoter (Robot : in out T_Robot; Environnement : in T_Environnement) is
	begin
		Pivoter (Robot);
	end Pivoter;


	-- Faire avancer le robot jusqu'à un obstacle ou aux limites de
	-- l'environnement.
	procedure Foncer(Robot : in out T_Robot; Environnement : in T_Environnement) is
		Ancien_X, Ancien_Y: Integer;
	begin
		loop
			Ancien_X := Robot.Abscisse;
			Ancien_Y := Robot.Ordonnee;
		   	Avancer(Robot, Environnement);
			exit when Ancien_X = Robot.Abscisse and Ancien_Y = Robot.Ordonnee;
		end loop;
	end Foncer;

--| Sous-programmes qui manipulent les sous-programmes précédents |---------

	-- Lire les informations d'un robot.
	procedure Lire_Robot (Robot : out T_Robot) is
		Abscisse, Ordonnee: Integer;   -- les coordonnées initiales du robot
		Direction: T_Direction;        -- la direction initiale du robot
	begin
		-- Demander l'abscisse
		Put ("Abscisse : ");
		Get (Abscisse);
		Skip_Line;

		-- Demander l'ordonnée
		Put ("Ordonnée : ");
		Get (Ordonnee);
		Skip_Line;

		-- Demander la direction
		Get_Direction (direction, "Direction : ");

		Initialiser (Robot, Abscisse, Ordonnee, Direction);
	end Lire_Robot;

	-- programme de test PIXAL pour le robot et ses sous-programmes
	procedure Exemple_Robot is
		Robot1 : T_Robot;
	begin
		Lire_Robot (Robot1);
		Put ("Robot lu : ");
		Put_Line (Robot1);
		for i in 1..4 loop
			Put ("Avancer : ");
			Avancer (Robot1);
			Put_Line (Robot1);

			Put ("Pivoter : ");
			Pivoter (Robot1);
			Put_Line (Robot1);
		end loop;
	end Exemple_Robot;


	procedure Exemple_Robot_Dans_Environnment is
		Robot1 : T_Robot;
		Environnement : T_Environnement;  -- un exemple d'environnement
	begin
		-- Saisir le robot
		Lire_Robot (Robot1);
		Put ("Robot lu : ");
		Put_Line (Robot1);

		-- Initialiser l'environnement
		Environnement := (others => (others => LIBRE)); -- environnement vide
		Environnement ((Robot1.Abscisse + 20) mod MAX_X, Robot1.Ordonnee) := OBSTACLE;

		-- Faire foncer le robot
		Put_Line ("Le robot fonce...");
		Foncer (Robot1, environnement);

		-- Afficher le robot
		Put ("Le robot s'arrête en : ");
		Put_Line (Robot1);

	end Exemple_Robot_Dans_Environnment;


--| Le programme principal |------------------------------------------------

	Type_Test: Character;
begin
	-- Choisir le type de test
	Put ("Type de test : ");
	Get (Type_Test);
	Skip_Line;

	-- Lancer le test choisi
	case To_Lower (Type_Test) is
		when 'r' => 
			Exemple_Robot;
		when 'e' => 
			Exemple_Robot_Dans_Environnment;
		when others =>
			Put ("Test inconnu");
	end case;

    -- QUESTIONS
    -- 1:   a: Elles ont été déclarés dans cet ordre pour simplifier l'affectation
    --          ex: NORD+1 = EST qui est bien un pivotage de 90deg.
	-- 1:	b: L'utilisateur saisie une direction en ecrivant son nom
	-- 1:	c: La procédure Get_Direction n'est pas robuste car si l'utilisateur entre une direction
	--			inconnue, la fonction jete un erreur.
	-- 1:	d: Oui, car Get n'a pas de signature identique à Get_Direction 
	--			(vu que T_Direction est definie par l'utilisateur).
	--
	-- 3:	a: T_Case admet deux valeurs (LIBRE, OCCUPE), Boolean admet aussi deux valeurs (True, False)
	--			donc on peux prendre le type Boolean au lieu de T_Case. (mais si Case = True, on veut dire quoi?)
	-- 3:	b: DX et DY correspondent aux changements de position en relation avec la Direction
	--			ex: DX(NORD) = 0 car en direction nord on ne fait pas de déplacements sur l'axe X
end Robot_Type_1;
