with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Unchecked_Deallocation;

package body LC is

	procedure Free is
		new Ada.Unchecked_Deallocation (Object => T_Cellule, Name => T_LC);


	procedure Initialiser(Sda: out T_LC) is
	begin
		Sda := null;
	end Initialiser;


	function Est_Vide (Sda : T_LC) return Boolean is
	begin
		return Sda = null;
	end Est_Vide;

	function Taille (Sda : in T_LC) return Integer is
	begin
		if Est_Vide(Sda) then
		   	return 0;
		end if;

		return Taille(Sda.all.Suivant) + 1;
	end Taille;


	procedure Ajouter (Sda : in out T_LC ; Cle : in T_Cle ; Donnee : in T_Donnee) is
		Temp: T_LC;
	begin
        Temp := Sda;
        Sda := new T_Cellule;
        Sda.all.Cle := Cle;
        Sda.all.Donnee := Donnee;
        Sda.all.Suivant := Temp;
	end Ajouter;

	procedure Vider (Sda : in out T_LC) is
		Temp: T_LC;
	begin
		while not Est_Vide(Sda) loop
			Temp := Sda;
			Sda := Sda.all.Suivant;
			Free(Temp);
		end loop;
	end Vider;


	procedure Pour_Chaque (Sda : in T_LC) is
		Temp: T_LC;
	begin
		Temp := Sda;
		while not Est_Vide(Temp) loop
			begin
		   		Traiter(Temp.all.Cle, Temp.all.Donnee);
			exception
				when others => null;
			end;
			Temp := Temp.all.Suivant;
		end loop;
	end Pour_Chaque;



end LC;
