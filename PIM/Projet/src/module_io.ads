with Types;                 use Types;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

generic
    type T_Element is digits <>;
package Module_IO is

	-- Lire l'intégralité du fichier.
	procedure Lire(Fichier: in Unbounded_String; PagesNum: out Integer; Liens: out LC_Integer_Integer.T_LC);

    -- Ecrire les PageRank et les Poids.
    procedure Ecrire(Fichier: in Unbounded_String; PagesNum: in Integer; MaxIterations: in Integer; Alpha: in T_Digits; Rangs: in Vecteur_Poids.T_Vecteur);

end Module_IO;
