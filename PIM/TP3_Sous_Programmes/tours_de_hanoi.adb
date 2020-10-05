-- Score PIXAL le 05/10/2020 à 17:27 : 100%

with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

procedure Tours_De_Hanoi is

    procedure Afficher_Deplacement(Debut: in Character; Fin: in Character) is
    begin
        Put_Line(Debut & " -> " & Fin);
    end Afficher_Deplacement;

	procedure Resoudre_Hanoi(N: in Integer; Debut: in Character; Interm: in Character; Fin: in Character) --with
        -- Pre => N >= 1
    is
    begin
        if N <= 0 then      -- Joue le rôle de la Precondition (sans jeter une exception)
            return;
        elsif N = 1 then
            Afficher_Deplacement(Debut, Fin);
            return;
        end if;

        -- Déplacer les N-1 premiers disques à l'intermediaire
        Resoudre_Hanoi(N-1, Debut, Fin, Interm);
        -- Déplacer le dernier à la fin
        Afficher_Deplacement(Debut, Fin);
        -- Déplacer le reste à la fin
        Resoudre_Hanoi(N-1, Interm, Debut, Fin);

    end Resoudre_Hanoi;

	Nb: Integer;         -- Nombre de disque du jeu
begin
	-- Demander le réel
	Put ("Nombre de disques : ");
	Get (Nb);

	-- Résoudre Hanoï avec NB disques et les tiges 'A' (départ), 'B' (intermédiaire) et 'C' (arrivée)
	Resoudre_Hanoi(Nb, 'A', 'B', 'C');

    -- Questions:
    -- 1: A -> C
    -- 2: A -> B; A -> C; B -> C
    -- 3: On a N disque, il suffit, puisqu'on sait résoudre le problème pour N-1 disque,
    --      de déplacer les N-1 premières en B et après déplacer le dernier en C.
    --      Or puisque tous les disques sont petits que celui dans C, on se ramène encore
    --      en un problème à N-1 qu'on sait résoudre.
end Tours_De_Hanoi;
