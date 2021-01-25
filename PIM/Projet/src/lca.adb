with Ada.Unchecked_Deallocation;
with SDA_Exceptions; use SDA_Exceptions;

package body LCA is

	procedure Free is
		new Ada.Unchecked_Deallocation (Object => T_Cellule, Name => T_LCA);


	procedure Initialiser(Sda: out T_LCA) is
	begin
		Sda := null;
	end Initialiser;

	function Est_Vide (Sda : T_LCA) return Boolean is
	begin
		return Sda = null;
	end Est_Vide;

	function Cellule(Sda: in T_LCA; Cle: in T_Cle) return T_LCA is
		Temp: T_LCA;
	begin
		Temp := Sda;
		while not Est_Vide(Temp) loop
			if Temp.all.Cle = Cle then
				return Temp;
			end if;

			Temp := Temp.Suivant;
		end loop;

		return null;
	end Cellule;

	function Taille (Sda : in T_LCA) return Integer is
	begin
		if Est_Vide(Sda) then
		   	return 0;
		end if;

		return Taille(Sda.all.Suivant) + 1;
	end Taille;


	procedure Enregistrer (Sda : in out T_LCA ; Cle : in T_Cle ; Donnee : in T_Donnee) is
		Temp: T_LCA;
	begin
		Temp := Cellule(Sda, Cle);
		if Temp /= null then
		   	Temp.all.Donnee := Donnee;
		else
			Temp := Sda;
			Sda := new T_Cellule;
			Sda.all.Cle := Cle;
			Sda.all.Donnee := Donnee;
			Sda.all.Suivant := Temp;
		end if;

	end Enregistrer;


	function Cle_Presente (Sda : in T_LCA ; Cle : in T_Cle) return Boolean is
	begin
		return Cellule(Sda, Cle) /= null;
	end Cle_Presente;


	function La_Donnee (Sda : in T_LCA ; Cle : in T_Cle) return T_Donnee is
		Temp: T_LCA;
	begin
		Temp := Cellule(Sda, Cle);
		if Temp = null then
		   	raise Cle_Absente_Exception;
		end if;

		return Temp.all.Donnee;
	end La_Donnee;

	procedure Supprimer (Sda : in out T_LCA ; Cle : in T_Cle) is
		Temp: T_LCA;
	begin
		if Est_Vide(Sda) then
		   	raise Cle_Absente_Exception;
		elsif Sda.all.Cle = Cle then
			Temp := Sda;
			Sda := Sda.all.Suivant;
			Free(Temp);
		else
			Supprimer(Sda.all.Suivant, Cle);
		end if;
	end Supprimer;


	procedure Vider (Sda : in out T_LCA) is
		Temp: T_LCA;
	begin
		while not Est_Vide(Sda) loop
			Temp := Sda;
			Sda := Sda.all.Suivant;
			Free(Temp);
		end loop;
	end Vider;


	procedure Pour_Chaque (Sda : in T_LCA) is
	begin
		if not Est_Vide(Sda) then
			begin
		   		Traiter(Sda.all.Cle, Sda.all.Donnee);
			exception
				when others => null;
			end;
			Pour_Chaque(Sda.all.Suivant);
		end if;
	end Pour_Chaque;



end LCA;
