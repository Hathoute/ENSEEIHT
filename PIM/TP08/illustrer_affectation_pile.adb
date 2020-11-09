with Piles;
with Ada.Text_IO;            use Ada.Text_IO;

-- Montrer le risque d'autoriser l'affectation entre variables dont le type
-- est une structure chaînée.
procedure Illustrer_Affectation_Pile is
	package Pile is
		new Piles (Character);
	use Pile;

	procedure Afficher is
		new Pile.Afficher (Put);

	P1, P2 : T_Pile;
begin
	-- construire la pile P1
	Initialiser (P1);
	Empiler (P1, 'A');
	Empiler (P1, 'B');
	Afficher (P1); New_Line;   -- XXX Qu'est ce qui s'affiche ? A, B

	P2 := P1;                  -- XXX Conseillé ? Non, voir Illustrer_Memoire_Dynamique_Erreur
	pragma Assert (P1 = P2);

	Depiler (P2);              -- XXX Quel effet ?	Depiler 'B' de P2 (et P1)
	Afficher (P2); New_Line;   -- XXX Qu'est ce qui s'affiche ? A
	Afficher (P1); New_Line;   -- XXX Qu'est ce qui s'affiche ? A, Le charactère de code 0x0
	-- XXX Que donne l'exécution avec valkyrie ?
	--	Valkyrie doit donner un erreur de read illégal car on essaie de lire la valeur de
	--	P1.Element qui est déja libérée en Dépilant P2.

	Depiler (P1);	-- XXX correct ? Non
end Illustrer_Affectation_Pile;
