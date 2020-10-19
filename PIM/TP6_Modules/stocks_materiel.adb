with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

-- Auteur: 
-- Gérer un stock de matériel informatique.
--
package body Stocks_Materiel is

    -- Helpers

    function Indice(Stock: in T_Stock; Numero_Serie: in Integer) return Integer is
    begin
        for J in 1..Stock.Nombre loop
            if Stock.Materiels(J).Numero_Serie = Numero_Serie then
                return J;
            end if;
        end loop;
        return -1;      -- Non trouvé, on retourne -1
    end;

    procedure Afficher_Materiel(Materiel: in T_Materiel) is
    begin
        Put("Matériel de numéro ");
        Put(Materiel.Numero_Serie, 1);
        Put_Line(":");
        Put_Line("Type: " & T_Nature'Image(Materiel.Nature));
        Put("Année: ");
        Put(Materiel.Annee_Achat, 1);
        New_Line;
        if Materiel.Est_Fonctionnel then
            Put_Line("Ce matériel est fonctionnel!");
        else
            Put_Line("Ce matériel est défectueux!");
        end if;
    end;

    -- Sous Programmes du Module.

    procedure Creer (Stock : out T_Stock) is
    begin
        Stock.Nombre := 0;
    end Creer;


    function Nb_Materiels (Stock: in T_Stock) return Integer is
    begin
        return Stock.Nombre;
    end;


    procedure Enregistrer (
            Stock        : in out T_Stock;
            Numero_Serie : in     Integer;
            Nature       : in     T_Nature;
            Annee_Achat  : in     Integer
        ) is
    begin
        Stock.Nombre := Stock.Nombre + 1;
        Stock.Materiels(Stock.Nombre).Numero_Serie := Numero_Serie;
        Stock.Materiels(Stock.Nombre).Nature := Nature;
        Stock.Materiels(Stock.Nombre).Annee_Achat := Annee_Achat;
        Stock.Materiels(Stock.Nombre).Est_Fonctionnel := True;
    end;


    function Nb_Defectueux (Stock: in T_Stock) return Integer is
        Nbr: Integer := 0;
    begin
        for J in 1..Stock.Nombre loop
            if not Stock.Materiels(J).Est_Fonctionnel then
                Nbr := Nbr + 1;
            end if;
        end loop;
        return Nbr;
    end;

    procedure Mettre_A_Jour (
            Stock: in out T_Stock;
            Numero_Serie: in Integer;
            Est_Fonctionnel: in Boolean
        ) is
        Position: Integer;
    begin
        Position := Indice(Stock, Numero_Serie);
        Stock.Materiels(Position).Est_Fonctionnel := Est_Fonctionnel;
    end;

    procedure Supprimer (
            Stock: in out T_Stock;
            Numero_Serie: in Integer
        ) is
        Position: Integer;
    begin
        Position := Indice(Stock, Numero_Serie);
        for J in Position..Nb_Materiels(Stock) loop
            Stock.Materiels(J) := Stock.Materiels(J+1);
        end loop;
        Stock.Nombre := Stock.Nombre - 1;
    end;

    function Existe(Stock: in T_Stock; Numero_Serie: in Integer) return Boolean is
    begin
        return Indice(Stock, Numero_Serie) > 0;
    end;

    procedure Afficher (Stock: in T_Stock) is
    begin
        for J in 1..Nb_Materiels(Stock) loop
            Afficher_Materiel(Stock.Materiels(J));
            New_Line;
        end loop;
    end;

    procedure Nettoyer(Stock: in out T_Stock) is
        Index: Integer;
    begin
        if Nb_Defectueux(Stock) = 0 then
            return;
        end if;

        Index := 1;
        while Index <= Nb_Materiels(Stock) loop
            if not Stock.Materiels(Index).Est_Fonctionnel then
                Supprimer(Stock, Stock.Materiels(Index).Numero_Serie);
            else
                Index := Index + 1;
            end if;
        end loop;
    end;

end Stocks_Materiel;
