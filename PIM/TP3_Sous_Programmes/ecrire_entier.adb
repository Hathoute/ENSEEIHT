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
        if Exposant = 0 then
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
	Put ("Puissance (itérative) : ");
	Put (Puissance_Iteratif (Un_Reel, Un_Entier), Fore => 0, Exp => 0,  Aft => 4);
	New_Line;

	-- Afficher la puissance en version récursive
	Put ("Puissance (récursive) : ");
	Put (Puissance_Recursif (Un_Reel, Un_Entier), Fore => 0, Exp => 0,  Aft => 4);
	New_Line;

    -- Commentaires:
    -- Q1: 1ère execution: exceeding memory limit
    -- Ceci est du au fait que chaque fonction appele l'autre avec les même param et donc une boucle infinie.

    -- Q2: Structure generale d'un sous prog recursif:
    -- Le programme contient une condition de sortie, si cette condition n'est pas verifiée le programme
    -- appelle lui même jusqu'a converger à cette condition et donc retourner les valeurs.

    -- Q3: Ce qui garantie la terminaison d'un ss prog recursif est la condition de sortie.

    -- Q4: Non, les deux fonctions ne sont pas correctes.

end Ecrire_Entier;
