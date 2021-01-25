
-- Définition de la classe
generic
    type T_Type is private;

package Vecteur is

	type T_Vecteur is limited private;
	
	-- Initialiser un vecteur.  Le vecteur est vide.
	procedure Initialiser(Vecteur: out T_Vecteur; Capacite: in Natural) with
		Post => Est_Vide (Vecteur);

	-- Copier le contenu d'un vecteur dans un autre.
	procedure Copier(Vecteur: out T_Vecteur; Original: in T_Vecteur);

	-- Est-ce qu'un vecteur est vide ?
	function Est_Vide (Vecteur : in T_Vecteur) return Boolean;


	-- Obtenir le nombre d'éléments d'un vecteur. 
	function Taille (Vecteur : in T_Vecteur) return Integer with
		Post => Taille'Result >= 0;


	-- Ajoute une valeur à un vecteur.
	procedure Ajouter (Vecteur : in out T_Vecteur ; Valeur : in T_Type);

	-- Modifier la valeur d'un indice.
	procedure Modifier (Vecteur : in out T_Vecteur ; Indice: in Integer; Valeur : in T_Type) with
		Pre => Indice >= 0 and Indice < Taille(Vecteur);

	-- Retourner la valeur de l'indice passé.
	function Valeur(Vecteur: in T_Vecteur; Indice: in Integer) return T_Type;

	-- Supprimer tous les éléments du vecteur.
	procedure Vider (Vecteur : in out T_Vecteur) with
		Post => Est_Vide (Vecteur);


	-- Applique un Tri des valeurs du vecteur.
	generic
		with function "<" (Gauche, Droite : in T_Type) return Boolean;
	procedure Trier (Vecteur : in out T_Vecteur);

    -- Appliquer un traitement (Traiter) pour chaque element du vecteur.
	generic
		with procedure Traiter (Valeur: T_Type);
	procedure Pour_Chaque (Vecteur : in T_Vecteur);

private 

	type T_Vecteur_Array is array(Integer range <>) of T_Type;

	type T_Vecteur_Access is access T_Vecteur_Array;

	type T_Vecteur is record 
		Elements: T_Vecteur_Access;
		Taille: Integer;
	end record;


end Vecteur;
