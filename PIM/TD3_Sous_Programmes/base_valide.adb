with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

procedure Lire_Entier is

	Base_MAX : constant Integer := 10 + 26;	-- 10 chiffres ('0'..'9') + 26 lettres ('A'..'Z')


	-- Est-ce que la base est valide ?
	function Est_Base_Valide(Base : in Integer) return Boolean is
	begin
		return 2 <= Base and Base <= Base_MAX;
        --return True;
	end Est_Base_Valide;

    -- Transformer indice en nombre entierdans base10
    function Indice_En_Base10(Indice: Character) return Integer is
    begin
        if Indice >= '0' and Indice <= '9' then
            return Character'Pos(Indice) - Character'Pos('0');
        else
            return 10 + Character'Pos(Indice) - Character'Pos('A');
        end if;
    end Indice_En_Base10;


    function Nombre_En_Indice(Nombre: Integer) return Character is
    begin
        if Nombre < 10 then
            return Character'Val(Nombre + Character'Pos('0'));
        else
            return Character'Val(Nombre - 10 + Character'Pos('A'));
        end if;
    end Nombre_En_Indice;


	-- Lire un entier au clavier dans la base considérée.
	procedure Lire (
		Nombre: out Integer ;	-- l'entier lu au clavier
		Base: in Integer := 10	-- la base à utiliser
	) with
		Pre => Est_Base_Valide (Base)
	is
        NbrEnBase: String(1 .. 10);
        Iteration: Integer;
    begin
        Get_Line(NbrEnBase, Iteration);
        
        Nombre := 0;
        for char of NbrEnBase loop
            Iteration := Iteration - 1;
            Nombre := Nombre + Indice_En_Base10(char) * Base**Iteration;
            exit when Iteration = 0;
        end loop;
	end Lire;

	-- Écrire un entier dans une base donnée.
	procedure Ecrire (
		Nombre: in Integer ;	-- l'entier à écrire
		Base : in Integer		-- la base à utliser
	) with
		Pre => Est_Base_Valide (Base)
				and Nombre >= 0
	is
    begin
		if Nombre < Base then
           Put(Nombre_En_Indice(Nombre));
           return;
        end if;
        Ecrire(Nombre/Base, Base);
        Put(Nombre_En_Indice(Nombre mod Base));
	end Ecrire;


	Base_Lecture: Integer;	-- la base de l'entier lu
	Base_Ecriture: Integer;	-- la base de l'entier écrit
	Un_Entier: Integer;	    -- un entier lu au clavier
begin
	-- Demander la base de lecture
	Put ("Base de l'entier lu : ");
	Get (Base_Lecture);
	Skip_Line;

	-- Demander un entier
	Put ("Un entier (base ");
	Put (Base_Lecture, 1);
	Put (") : ");
    if Est_Base_Valide(Base_Lecture) then
	    Lire (Un_Entier, Base_Lecture);
    else
        Skip_Line;
        Un_Entier := 0;
    end if;

	-- Afficher l'entier lu en base 10
	Put ("L'entier lu est (base 10) : ");
	Put (Un_Entier, 1);
	New_Line;

	-- Demander la base d'écriture
	Put ("Base pour écrire l'entier : ");
	Get (Base_Ecriture);
	Skip_Line;

	-- Afficher l'entier lu dans la base d'écriture
    if Est_Base_Valide(Base_Lecture) then
        Put ("L'entier en base ");
        Put (Base_Ecriture, 1);
        Put (" est ");
        Ecrire (Un_Entier, Base_Ecriture);
        New_Line;
    end if;

	-- Remarque : on aurait pu utiliser les sous-programme Lire pour lire
	-- les bases et Ecrire pour les écrire en base 10.  Nous utilisons les
	-- Get et Put d'Ada pour faciliter le test du programme.
end Lire_Entier;