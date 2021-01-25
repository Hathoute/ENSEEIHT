
-- Définition de structures de données sous forme d'une liste chaînée  (LC).
generic
	type T_Cle is private;
	type T_Donnee is private;

package LC is

	type T_LC is limited private;

	-- Initialiser une Sda.  La Sda est vide.
	procedure Initialiser(Sda: out T_LC) with
		Post => Est_Vide (Sda);


	-- Est-ce qu'une Sda est vide ?
	function Est_Vide (Sda : T_LC) return Boolean;


	-- Obtenir le nombre d'éléments d'une Sda. 
	function Taille (Sda : in T_LC) return Integer with
		Post => Taille'Result >= 0
			and (Taille'Result = 0) = Est_Vide (Sda);


	-- Ajoute une Donnée associée à une Clé dans une Sda.
	procedure Ajouter (Sda : in out T_LC ; Cle : in T_Cle ; Donnee : in T_Donnee);


	-- Supprimer tous les éléments d'une Sda.
	procedure Vider (Sda : in out T_LC) with
		Post => Est_Vide (Sda);


	-- Appliquer un traitement (Traiter) pour chaque couple d'une Sda.
	generic
		with procedure Traiter (Cle : in T_Cle; Donnee: in T_Donnee);
	procedure Pour_Chaque (Sda : in T_LC);

private

	type T_Cellule;

	type T_LC is access T_Cellule;

	type T_Cellule is record
			Cle : T_Cle;
			Donnee : T_Donnee;
			Suivant : T_LC;
		end record;

end LC;
