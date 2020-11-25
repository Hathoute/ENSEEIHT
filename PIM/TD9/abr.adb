with SDA_Exceptions;         use SDA_Exceptions;
with Ada.Unchecked_Deallocation;

package body ABR is

	procedure Free is
		new Ada.Unchecked_Deallocation (Object => T_Noeud, Name => T_ABR);


	procedure Initialiser(Sda: out T_ABR) is
	begin
		Sda := null;
	end Initialiser;


	function Est_Vide (Sda : T_ABR) return Boolean is
	begin
		return Sda = null;
	end Est_Vide;


	function Taille (Sda : in T_ABR) return Integer is
	begin
		if Est_Vide(Sda) then
		   	return 0;
		end if;

		return Taille(Sda.all.Sous_Arbre_Gauche) + Taille(Sda.all.Sous_Arbre_Droit) + 1;
	end Taille;

	procedure Enregistrer (Sda : in out T_ABR ; Cle : in T_Cle ; Donnee : in T_Donnee) is
	begin
		if Est_Vide(Sda) then
			Sda := new T_Noeud;
			Sda.all.Cle := Cle;
			Sda.all.Donnee := Donnee;

		elsif Sda.all.Cle < Cle then
			Enregistrer(Sda.all.Sous_Arbre_Droit, Cle, Donnee);
		elsif Cle < Sda.all.Cle then
			Enregistrer(Sda.all.Sous_Arbre_Gauche, Cle, Donnee);
		else
			Sda.all.Donnee := Donnee;
		end if;
	end Enregistrer;

	function La_Donnee (Sda : in T_ABR ; Cle : in T_Cle) return T_Donnee is
	begin
		if Est_Vide(Sda) then
		   	raise Cle_Absente_Exception;
		end if;

		if Sda.all.Cle = Cle then
		   	return Sda.all.Donnee;
		elsif Sda.all.Cle < Cle then
		   	return La_Donnee(Sda.all.Sous_Arbre_Droit,Cle);
		else
		   	return La_Donnee(Sda.all.Sous_Arbre_Gauche,Cle);
		end if;
	end La_Donnee;

	procedure Decrocher_Min (Sda: in out T_ABR; Min: out T_ABR) with
		Pre => not Est_Vide(Sda)
	is	
	begin
		if Est_Vide(Sda.all.Sous_Arbre_Gauche) then
		   	Min := Sda;
			Sda := Sda.all.Sous_Arbre_Droit;
		else
			Decrocher_Min(Sda.all.Sous_Arbre_Gauche, Min);
		end if;
	end Decrocher_Min;

	procedure Supprimer (Sda : in out T_ABR ; Cle : in T_Cle) is
		A_Supprimer: T_ABR;
		Min: T_ABR;
	begin
		if Est_Vide(Sda) then
		   	raise Cle_Absente_Exception;
		end if;

		if Sda.all.Cle = Cle then
			A_Supprimer := Sda;
			if Est_Vide(Sda.all.Sous_Arbre_Droit) then
				Sda := Sda.all.Sous_Arbre_Gauche;
			elsif Est_Vide(Sda.all.Sous_Arbre_Gauche) then
				Sda := Sda.all.Sous_Arbre_Droit;
			else
				Decrocher_Min(Sda.all.Sous_Arbre_Droit, Min);
				Min.all.Sous_Arbre_Gauche := Sda.all.Sous_Arbre_Gauche;
				Min.all.Sous_Arbre_Droit := Sda.all.Sous_Arbre_Droit;
				Sda := Min;
			end if;

			Free(A_Supprimer);
		elsif Sda.all.Cle < Cle then
		   	Supprimer(Sda.all.Sous_Arbre_Droit, Cle);
		else
		   	Supprimer(Sda.all.Sous_Arbre_Gauche, Cle);
		end if;
	end Supprimer;


	procedure Vider (Sda : in out T_ABR) is
	begin
		if Est_Vide(Sda) then
		   	return;
		end if;

		Vider(Sda.all.Sous_Arbre_Gauche);
		Vider(Sda.all.Sous_Arbre_Droit);
		Free(Sda);
	end Vider;


	procedure Pour_Chaque (Sda : in T_ABR) is
	begin
		if Est_Vide(Sda) then
		   	return;
		end if;

		Pour_Chaque(Sda.all.Sous_Arbre_Gauche);
		begin
			Traiter(Sda.all.Cle, Sda.all.Donnee);
		exception
			when others => null;
		end;
		Pour_Chaque(Sda.all.Sous_Arbre_Droit);
	end Pour_Chaque;

--	procedure Affichage_Indente(Sda: in T_ABR; Niv: in Integer) is
--	begin
--		if Est_Vide(Sda) then
--		   	Put("[]", Niv);
--		else
--			Put("", Niv);
--			Afficher(Sda.all.Cle, Sda.all.Donnee);
--			Put("Gauche -> ", Niv);
--			Affichage_Indente(Sda.all.Sous_Arbre_Gauche, Niv+1);
--			Put("Droit -> ", Niv);
--			Affichage_Indente(Sda.all.Sous_Arbre_Droit, Niv+1);
--		end if;
--
--		New_Line;
--	end Affichage_Indente;
--
--	procedure Afficher(Sda: in T_ABR) is
--	begin
--		Affichage_Indente(Sda, 0);
--	end Afficher_Arbre;

end ABR;
