with Ada.Unchecked_Deallocation;

package body Vecteur is

    procedure Free is
		new Ada.Unchecked_Deallocation (Object => T_Vecteur_Array, Name => T_Vecteur_Access);

    procedure Initialiser(Vecteur: out T_Vecteur; Capacite: in Natural) is
    begin
        Vecteur.Elements := new T_Vecteur_Array(0..Capacite-1);
        Vecteur.Taille := 0;
    end Initialiser;

    procedure Copier(Vecteur: out T_Vecteur; Original: in T_Vecteur) is
    begin
        Initialiser(Vecteur, Original.Elements'Length);
        for I in 0..Original.Taille-1 loop
            Ajouter(Vecteur, Original.Elements(I));
        end loop;
    end Copier;

	function Est_Vide (Vecteur: in T_Vecteur) return Boolean is
	begin
		return Vecteur.Taille = 0;
	end Est_Vide;

	function Taille (Vecteur: in T_Vecteur) return Integer is
	begin
		return Vecteur.Taille;
	end Taille;


	procedure Ajouter (Vecteur : in out T_Vecteur ; Valeur : in T_Type) is
	begin
        Vecteur.Elements.all(Vecteur.Taille) := Valeur;
        Vecteur.Taille := Vecteur.Taille + 1;
	end Ajouter;

	procedure Modifier (Vecteur : in out T_Vecteur ; Indice: in Integer; Valeur : in T_Type) is
	begin
        Vecteur.Elements.all(Indice) := Valeur;
	end Modifier;

    function Valeur(Vecteur: in T_Vecteur; Indice: in Integer) return T_Type is
    begin   
        return Vecteur.Elements.all(Indice);
    end Valeur;

	procedure Vider (Vecteur : in out T_Vecteur) is
	begin
        Free(Vecteur.Elements);
		Vecteur.Taille := 0;
	end Vider;

    procedure Intervertir(Vecteur: in T_Vecteur; I: integer; J: Integer) is
        Temp: T_Type;
    begin
        Temp := Vecteur.Elements.all(I);
        Vecteur.Elements.all(I) := Vecteur.Elements.all(J);
        Vecteur.Elements.all(J) := Temp;
    end Intervertir;


    procedure Trier (Vecteur: in out T_Vecteur) is

        procedure Tri_Rapide(Vecteur: in out T_Vecteur; Inf: in Integer; Sup: in Integer) is
            I : Integer := Inf;
        begin
            if Inf >= Sup then
                return;
            end if;

            for J in Inf+1..Sup loop
                if Vecteur.Elements.all(I) < Vecteur.Elements.all(J) then
                    Intervertir(Vecteur, I, J);
                    Intervertir(Vecteur, I+1, J);
                    I := I+1;
                end if;
            end loop;

            Tri_Rapide(Vecteur, Inf, I-1);
            Tri_Rapide(Vecteur, I+1, Sup);
        end Tri_Rapide;

    begin
        Tri_Rapide(Vecteur, 0, Vecteur.Taille-1);
    end Trier;

    procedure Pour_Chaque(Vecteur : in T_Vecteur) is
    begin
        for J in 0..Vecteur.Taille-1 loop
            Traiter(Vecteur.Elements.all(J));
        end loop;
    end Pour_Chaque;

end Vecteur;
