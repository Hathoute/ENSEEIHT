with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;           use Ada.Float_Text_IO;
with Ada.Unchecked_Deallocation;

package body Vecteurs_Creux is


	procedure Free is
		new Ada.Unchecked_Deallocation (T_Cellule, T_Vecteur_Creux);


	procedure Initialiser (V : out T_Vecteur_Creux) is
	begin
		V := Null;
	end Initialiser;


	procedure Detruire (V: in out T_Vecteur_Creux) is
	begin
		Free(V);
	end Detruire;


	function Est_Nul (V : in T_Vecteur_Creux) return Boolean is
	begin
		return V = Null;
	end Est_Nul;


	function Composante_Recursif (V : in T_Vecteur_Creux ; Indice : in Integer) return Float is
	begin
		if Est_Nul(V) then
			return 0.0;
		else
			if Indice = V.all.Indice then
			   	return V.all.Valeur;
			else
				return Composante_Recursif(V.all.Suivant, Indice);
			end if;
		end if;
	end Composante_Recursif;


	function Composante_Iteratif (V : in T_Vecteur_Creux ; Indice : in Integer) return Float is
		Current: T_Vecteur_Creux;
	begin
		Current := V;
		while Not Est_Nul(Current) and then Current.all.Indice <= Indice loop
		   	if Current.all.Indice = Indice then
				return Current.all.Valeur;
			else
				Current := Current.all.Suivant;
			end if;
		end loop;

		return 0.0;
	end Composante_Iteratif;


	procedure Modifier (V : in out T_Vecteur_Creux ;
				       Indice : in Integer ;
					   Valeur : in Float ) is
		Temp: T_Vecteur_Creux;
	begin

		if Est_Nul(V) then
		   	V := new T_Cellule;
			V.all.Indice := Indice;
			V.all.Valeur := Valeur;
		else
			if V.all.Indice < Indice then
				if Est_Nul(V.all.Suivant) then
				   	Temp := new T_Cellule;
					Temp.all.Indice := Indice;
					Temp.all.Valeur := Valeur;
					V.all.Suivant := Temp;
				else
					Modifier(V.all.Suivant, Indice, Valeur);
				end if;
			elsif V.all.Indice = Indice then
			   V.all.Valeur := Valeur;
			else
				Temp := V;
				V := new T_Cellule;
				V.all.Indice := Indice;
				V.all.Valeur := Valeur;
				V.all.Suivant := Temp;
			end if;
		end if;
	end Modifier;


	function Sont_Egaux_Recursif (V1, V2 : in T_Vecteur_Creux) return Boolean is
	begin
		if Est_Nul(V1) and Est_Nul(V2) then
		   	return True;
		elsif not Est_Nul(V1) and then not Est_Nul(V2) then
		   	return Sont_Egaux_Recursif(V1.all.Suivant, V2.all.Suivant);
		end if;

		return False;
	end Sont_Egaux_Recursif;


	function Sont_Egaux_Iteratif (V1, V2 : in T_Vecteur_Creux) return Boolean is
		Temp1: T_Vecteur_Creux;
		Temp2: T_Vecteur_Creux;
	begin
		Temp1 := V1;
		Temp2 := V2;

		while not Est_Nul(Temp1) and then not Est_Nul(Temp2) loop
			if not (Temp1.all.Indice = Temp2.all.Indice and Temp1.all.Valeur = Temp2.all.Valeur) then
			   	Temp1 := Null;
			else
				Temp1 := Temp1.all.Suivant;
				Temp2 := Temp2.all.Suivant;
			end if;
		end loop;

		return Est_Nul(Temp1) and Est_Nul(Temp2);
	end Sont_Egaux_Iteratif;


	procedure Additionner (V1 : in out T_Vecteur_Creux; V2 : in T_Vecteur_Creux) is
	begin
		Null;	-- TODO : à changer
	end Additionner;


	function Norme2 (V : in T_Vecteur_Creux) return Float is
	begin
		return 0.0;	-- TODO : à changer
	end Norme2;


	Function Produit_Scalaire (V1, V2: in T_Vecteur_Creux) return Float is
	begin
		return 0.0;	-- TODO : à changer
	end Produit_Scalaire;


	procedure Afficher (V : T_Vecteur_Creux) is
	begin
		if V = Null then
			Put ("--E");
		else
			-- Afficher la composante V.all
			Put ("-->[ ");
			Put (V.all.Indice, 0);
			Put (" | ");
			Put (V.all.Valeur, Fore => 0, Aft => 1, Exp => 0);
			Put (" ]");

			-- Afficher les autres composantes
			Afficher (V.all.Suivant);
		end if;
	end Afficher;


	function Nombre_Composantes_Non_Nulles (V: in T_Vecteur_Creux) return Integer is
	begin
		if V = Null then
			return 0;
		else
			return 1 + Nombre_Composantes_Non_Nulles (V.all.Suivant);
		end if;
	end Nombre_Composantes_Non_Nulles;


end Vecteurs_Creux;
