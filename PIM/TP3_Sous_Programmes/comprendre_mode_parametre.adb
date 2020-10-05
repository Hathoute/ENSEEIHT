with Ada.Text_IO;
use Ada.Text_IO;

-- Dans ce programme, les commentaires de spécification
-- ont **volontairement** été omis !

procedure Comprendre_Mode_Parametre is

	function Double (N : in Integer) return Integer is
	begin
		return 2 * N;
	end Double;

	procedure Incrementer (N : in out Integer) is
	begin
		N := N + 1;
	end Incrementer;

	procedure Mettre_A_Zero (N : out Integer) is
	begin
		N := 0;
	end Mettre_A_Zero;

	procedure Comprendre_Les_Contraintes_Sur_L_Appelant is
		A, B, R : Integer;
	begin
		A := 5;
		-- Indiquer pour chacune des instructions suivantes si elles sont
		-- acceptées par le compilateur.  Si elles sont refusées, expliquer
		-- pourquoi dans un commentaire sur la ligne.
		R := Double (A);            -- Accepté: Double est une fonction qui admet un 'in integer' et retourne un integer
		R := Double (10);           -- De même, même si 10 est une valeur mais le 'in' autorise ça
		R := Double (10 * A);       -- De même
		R := Double (B);            -- Accepté même si B n'est pas initialisé, B prend la valeur des bits déja presents dans son emplacement dans la memoire.

		Incrementer (A);            -- Accepté: A est une variable Integer et la fonction demande un parametre Integer
		--Incrementer (10);           -- Refusé: Le out de 'Incrementer' refuse qu'une valeur soit passée.
		--Incrementer (10 * A);       -- De même refusé: 10*A est une valeur non pas variable.
		Incrementer (B);            -- Accepté: Même si B n'est pas initialisée mais elle a une valeur aléatoire des bits déja présents dans son emplacement.

		Mettre_A_Zero (A);          -- Accepté: A variable de type Integer et la fonction demande un Integer
		--Mettre_A_Zero (10);         -- Refusé: 10 n'est pas une variable.
		--Mettre_A_Zero (10 * A);     -- Refusé: 10*A n'est pas une variable.
		Mettre_A_Zero (B);          -- Accepté: B variable de type Integer et la fonction demande un Integer
	end Comprendre_Les_Contraintes_Sur_L_Appelant;


	procedure Comprendre_Les_Contrainte_Dans_Le_Corps (
			A      : in Integer;
			B1, B2 : in out Integer;
			C1, C2 : out Integer)
	is
		L: Integer;
	begin
		-- pour chaque affectation suivante indiquer si elle est autorisée
		L := A;     -- Autorisé
		--A := 1;     -- Non autorisé (A en mode in)

		B1 := 5;    -- Autorisé (B1 en mode in out)

		L := B2;    -- Autorisé
		B2 := B2 + 1;       -- Autorisé (mode in ET out)

		C1 := L;    -- Autorisé

		L := C2;    -- Autorisé à partir d'une certaine version de ADA

		C2 := A;    -- Autorisé car C2 en 'out'
		C2 := C2 + 1;   -- Autorisé à partir d'une certaine version de ADA (la lecture de C2 pose ce problème)
	end Comprendre_Les_Contrainte_Dans_Le_Corps;


begin
	--Comprendre_Mode_Parametre;
	Comprendre_Les_Contraintes_Sur_L_Appelant;
	--Put_Line ("Fin");
end Comprendre_Mode_Parametre;
