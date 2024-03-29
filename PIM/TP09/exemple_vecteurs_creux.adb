with Ada.Text_IO;       use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Vecteurs_Creux;    use Vecteurs_Creux;

-- Exemple d'utilisation des vecteurs creux.
procedure Exemple_Vecteurs_Creux is

	V : T_Vecteur_Creux;
	Epsilon: constant Float := 1.0e-5;
begin
	Put_Line ("Début du scénario");
	
	-- Initialiser V ne marchera pas car on n'a encore modifié Est_Nul.
	Initialiser(V);
	Afficher(V);
	New_Line;

	pragma Assert(Est_Nul(V) = True);

	Detruire(V);

	pragma Assert(Composante_Recursif(V, 18) = 0.0);
	pragma Assert(Composante_Iteratif(V, 18) = 0.0);

	Modifier(V, 18, 1.0);
	Modifier(V, 2, 3.0);
	Modifier(V, 5, 11.0);

	Afficher(V);

	pragma Assert(Composante_Recursif(V, 18) = 1.0);
	pragma Assert(Composante_Iteratif(V, 2) = 3.0);


	Put_Line ("Fin du scénario");
end Exemple_Vecteurs_Creux;
