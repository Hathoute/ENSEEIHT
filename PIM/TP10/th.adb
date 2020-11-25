with Ada.Text_IO;            use Ada.Text_IO;
with SDA_Exceptions; use SDA_Exceptions;

package body TH is

	procedure Initialiser(Sda: out T_TH) is
	begin
		for i in 1..Capacite loop
            T_LCA_C.Initialiser(Sda.Elements(i));
        end loop;
	end Initialiser;


	function Est_Vide (Sda : T_TH) return Boolean is
	begin
		for i in 1..Capacite loop
            if not T_LCA_C.Est_Vide(Sda.Elements(i)) then
                return False;
            end if;
        end loop;

        return True;
	end Est_Vide;

	function Block(Cle: in T_Cle) return Integer is
	begin
		return (Hachage(Cle) - 1) mod Capacite + 1;
	end Block;

	function Taille (Sda : in T_TH) return Integer is
        Length: Integer;
	begin
        Length := 0;

		for i in 1..Capacite loop
           Length := Length + T_LCA_C.Taille(Sda.Elements(i));
        end loop;

        return Length;
	end Taille;


	procedure Enregistrer (Sda : in out T_TH ; Cle : in T_Cle ; Donnee : in T_Donnee) is
	begin
        T_LCA_C.Enregistrer(Sda.Elements(Block(Cle)), Cle, Donnee);
	end Enregistrer;


	function Cle_Presente (Sda : in T_TH ; Cle : in T_Cle) return Boolean is
	begin
		return T_LCA_C.Cle_Presente(Sda.Elements(Block(Cle)), Cle);
	end Cle_Presente;


	function La_Donnee (Sda : in T_TH ; Cle : in T_Cle) return T_Donnee is
	begin
		return T_LCA_C.La_Donnee(Sda.Elements(Block(Cle)), Cle);
	end La_Donnee;

	procedure Supprimer (Sda : in out T_TH ; Cle : in T_Cle) is
	begin
		T_LCA_C.Supprimer(Sda.Elements(Block(Cle)), Cle);
	end Supprimer;


	procedure Vider (Sda : in out T_TH) is
	begin
        for i in 1..Capacite loop
		    T_LCA_C.Vider(Sda.Elements(i));
        end loop;
	end Vider;


	procedure Pour_Chaque (Sda : in T_TH) is
        procedure LCA_Pour_Chaque is
			    new T_LCA_C.Pour_Chaque (Traiter);
	begin
		for i in 1..Capacite loop
            LCA_Pour_Chaque(Sda.Elements(i));
        end loop;
	end Pour_Chaque;

end TH;
