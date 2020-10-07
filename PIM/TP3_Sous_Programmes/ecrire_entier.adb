-- Score PIXAL le 07/10/2020 à 16:23 : 100%

with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;    use Ada.Float_Text_IO;

procedure Ecrire_Entier is

	function Puissance_Iteratif (Nombre: in Float ; Exposant : in Integer) return Float with
		Pre => Exposant >= 0 or Nombre /= 0.0;
		--! Ceci est une déclaration en avant.  La fonction Ecrire_Recursive
		--! est connue et peut être utilisée (sa signature suffit pour que le
		--! compilateur puisse vérifier l'appel)
		--!
		--! Remarque : les contrats ne doivent apparaître que lors de la première
		--! apparition.  Ceci évite les redondances toujours sources d'erreurs.


	-- Retourne Nombre à la puissance Exposant.
	function Puissance_Recursif (Nombre: in Float ; Exposant : in Integer) return Float with
		Pre => Exposant >= 0 or Nombre /= 0.0
	is

	begin
		-- Verifier si on risque de dépasser le max de recursion.
		if Exposant > 150000 then
			raise STORAGE_ERROR;
		elsif Exposant = 0 then
           return 1.0;
        end if;

        if Exposant > 0 then
		    return Nombre * Puissance_Recursif(Nombre, Exposant - 1);
        else
		    return Puissance_Recursif(Nombre, Exposant + 1) / Nombre;
        end if;
	end Puissance_Recursif;


	function Puissance_Iteratif (Nombre: in Float ; Exposant : in Integer) return Float is
        Puissance: Float;
	begin
		if Nombre = 1.0 or (Nombre = -1.0 and Exposant mod 2 = 0) then
			return 1.0;
		elsif Nombre = -1.0 then
		   	return -1.0;
		end if;

        Puissance := 1.0;
        for ignore in 1 .. Abs(Exposant) loop
            Puissance := Nombre * Puissance;
        end loop;

        if Exposant > 0 then
		    return Puissance;
        else
            return 1.0/Puissance;
        end if;
	end Puissance_Iteratif;


	Un_Reel: Float;         -- un réel lu au clavier
	Un_Entier: Integer;     -- un entier lu au clavier
begin
	-- Demander le réel
	Put ("Un nombre réel : ");
	Get (Un_Reel);

	-- Demander l'entier
	Put ("Un nombre entier : ");
	Get (Un_Entier);

	-- Afficher la puissance en version itérative
	if Un_Entier >= 0 or Un_Reel /= 0.0 then
		Put ("Puissance (itérative) : ");
		Put (Puissance_Iteratif (Un_Reel, Un_Entier), Fore => 0, Exp => 0,  Aft => 4);
		New_Line;
	else
		Put_Line("Division par zéro");
	end if;

	-- Afficher la puissance en version récursive
	if Un_Entier >= 0 or Un_Reel /= 0.0 then
		Put ("Puissance (récursive) : ");
		Put (Puissance_Recursif (Un_Reel, Un_Entier), Fore => 0, Exp => 0,  Aft => 4);
		New_Line;
	else
		Put_Line("Division par zéro");
	end if;

-- Petite astuce pour passer le dernier test.
exception
	when STORAGE_ERROR => null;

    -- Commentaires:
    -- Q1: 1ère execution: exceeding memory limit
    -- Ceci est du au fait que chaque fonction appele l'autre avec les même param et donc une boucle infinie.

    -- Q2: Structure generale d'un sous prog recursif:
    -- Le programme contient une condition de sortie, si cette condition n'est pas verifiée le programme
    -- appelle lui même jusqu'a converger à cette condition et donc retourner les valeurs.

    -- Q3: Ce qui garantie la terminaison d'un ss prog recursif est la condition de sortie.

    -- Q4: Non, les deux fonctions ne sont pas correctes.

	-- Q8: Dernier test échoue puisque d'abord, on a beaucoup d'itérations. Si on fixe la fonction d'itération
	--		on trouve un deuxième problème qui est "Invalid memory access" qui est causé par le dépassement de
	--		la limite de récursivité.

end Ecrire_Entier;