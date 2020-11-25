with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Ada.Command_Line;     use Ada.Command_Line;
with SDA_Exceptions;       use SDA_Exceptions;
with Alea;
with TH;

-- Évaluer la qualité du générateur aléatoire et les SDA.
procedure Evaluer_Alea_TH is
	
	-- Fonction Identité
	function Identity(Nombre: in Integer) return Integer is 
	begin
		return Nombre;
	end Identity;

	package TH_int_int is
        new TH (Capacite => 1000, T_Cle => Integer, T_Donnee => Integer, Hachage => Identity);
    use TH_int_int;

	-- Afficher l'usage.
	procedure Afficher_Usage is
	begin
		New_Line;
		Put_Line ("Usage : " & Command_Name & " Borne Taille");
		New_Line;
		Put_Line ("   Borne  : les nombres sont tirés dans l'intervalle 1..Borne");
		Put_Line ("   Taille : la taille de l'échantillon");
		New_Line;
	end Afficher_Usage;


	-- Afficher le Nom et la Valeur d'une variable.
	-- La Valeur est affichée sur la Largeur_Valeur précisée.
	procedure Afficher_Variable (Nom: String; Valeur: in Integer; Largeur_Valeur: in Integer := 1) is
	begin
		Put (Nom);
		Put (" : ");
		Put (Valeur, Largeur_Valeur);
		New_Line;
	end Afficher_Variable;

	-- Évaluer la qualité du générateur de nombre aléatoire Alea sur un
	-- intervalle donné en calculant les fréquences absolues minimales et
	-- maximales des entiers obtenus lors de plusieurs tirages aléatoires.
	--
	-- Paramètres :
	-- 	  Borne: in Entier	-- le nombre aléatoire est dans 1..Borne
	-- 	  Taille: in Entier -- nombre de tirages (taille de l'échantillon)
	-- 	  Min, Max: out Entier -- fréquence minimale et maximale
	--
	-- Nécessite :
	--    Borne > 1
	--    Taille > 1
	--
	-- Assure : -- poscondition peu intéressante !
	--    0 <= Min Et Min <= Taille
	--    0 <= Max Et Max <= Taille
	--    Min + Max <= Taille
	--    Min <= Moyenne Et Moyenne <= Max
	--
	-- Remarque : On ne peut ni formaliser les 'vraies' postconditions,
	-- ni écrire de programme de test car on ne maîtrise par le générateur
	-- aléatoire.  Pour écrire un programme de test, on pourrait remplacer
	-- le générateur par un générateur qui fournit une séquence connue
	-- d'entiers et pour laquelle on pourrait déterminer les données
	-- statistiques demandées.
	-- Ici, pour tester on peut afficher les nombres aléatoires et refaire
	-- les calculs par ailleurs pour vérifier que le résultat produit est
	-- le bon.
	procedure Calculer_Statistiques (
		Borne    : in Integer;  -- Borne supérieur de l'intervalle de recherche
		Taille   : in Integer;  -- Taille de l'échantillon
		Min, Max : out Integer  -- min et max des fréquences de l'échantillon
	) with
		Pre => Borne > 1 and Taille > 1,
		Post => 0 <= Min and Min <= Taille
			and 0 <= Max and Max <= Taille
			and Min + Max <= Taille
	is

		-- Sous procedure mettant à jour le Max et Min.
		procedure MAJ_Max_Min(Cle: Integer; Donnee: Integer) is
		begin
			if Max < Donnee then
				Max := Donnee;
			end if;
			if Min > Donnee then
				Min := Donnee;
			end if;
		end MAJ_Max_Min;

		procedure Determiner_Max_Min is
				new Pour_Chaque(MAJ_Max_Min);

		package Mon_Alea is
			new Alea (1, Borne);
		use Mon_Alea;

		SDA : T_TH;
		Rand : Integer;
	begin
		-- Initialiser la TH.
		Initialiser(SDA);
		Min := Taille;
		Max := 0;

		for i in 1..Taille loop
			Get_Random_Number(Rand);
			begin
				Enregistrer(SDA, Rand, La_Donnee(SDA, Rand)+1);
			exception
				when Cle_Absente_Exception =>
					Enregistrer(SDA, Rand, 1);
			end;
		end loop;

		Determiner_Max_Min(SDA);

	end Calculer_Statistiques;


	Min, Max: Integer; -- fréquence minimale et maximale d'un échantillon
	Borne: Integer;    -- les nombres aléatoire sont tirés dans 1..Borne
	Taille: integer;   -- nombre de tirages aléatoires
begin
	if Argument_Count /= 2 then
		Afficher_Usage;
	else
		-- Récupérer les arguments de la ligne de commande
		begin
			Borne := Integer'Value (Argument (1));
			Taille := Integer'Value (Argument (2));
			if Borne < 2 or Taille < 2 then
				raise CONSTRAINT_ERROR;
			end if;
		exception
			when CONSTRAINT_ERROR => 
					Put_Line("Erreur d'entrée, vous devez entrer des nombres positifs >= 2.");
					Afficher_Usage;
					return;
		end;
		-- Afficher les valeur de Borne et Taille
		Afficher_Variable ("Borne ", Borne);
		Afficher_Variable ("Taille", Taille);

		Calculer_Statistiques (Borne, Taille, Min, Max);

		-- Afficher les fréquence Min et Max
		Afficher_Variable ("Min", Min);
		Afficher_Variable ("Max", Max);
	end if;

end Evaluer_Alea_TH;
