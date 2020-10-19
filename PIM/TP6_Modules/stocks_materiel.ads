
-- Auteur: 
-- Gérer un stock de matériel informatique.

package Stocks_Materiel is


    CAPACITE : constant Integer := 10;      -- nombre maximum de matériels dans un stock

    type T_Nature is (UNITE_CENTRALE, DISQUE, ECRAN, CLAVIER, IMPRIMANTE);

    type T_Materiel is private;

    type T_Stock is limited private;


    -- Créer un stock vide.
    --
    -- paramètres
    --     Stock : le stock à créer
    --
    -- Assure
    --     Nb_Materiels (Stock) = 0
    --
    procedure Creer (Stock : out T_Stock) with
        Post => Nb_Materiels (Stock) = 0;


    -- Obtenir le nombre de matériels dans le stock Stock.
    --
    -- Paramètres
    --    Stock : le stock dont ont veut obtenir la taille
    --
    -- Nécessite
    --     Vrai
    --
    -- Assure
    --     Résultat >= 0 Et Résultat <= CAPACITE
    --
    function Nb_Materiels (Stock: in T_Stock) return Integer with
        Post => Nb_Materiels'Result >= 0 and Nb_Materiels'Result <= CAPACITE;

    -- Obtenir le nombre de matériels non fonctionnel dans le stock Stock.
    --
    -- Paramètres
    --    Stock : le stock dont ont veut obtenir la taille
    --
    -- Nécessite
    --     Vrai
    --
    -- Assure
    --     Résultat >= 0 Et Résultat <= CAPACITE
    --
    function Nb_Defectueux (Stock: in T_Stock) return Integer with
        Post => Nb_Defectueux'Result >= 0 and Nb_Defectueux'Result <= CAPACITE;

    -- Modifie l'état d'un matériel à l'aide de son numéro de série.
    -- 
    -- Paramètres
    --    Stock : le stock à compléter
    --    Numero_Serie : le numéro de série du matériel
    --    Est_Fonctionnel  : le nouveau état du matériel
    -- 
    -- Nécessite
    --    Nb_Materiels (Stock) > 0
    --    Un matériel de numéro de serie = Numero_Serie est déja présent.
    --
    -- Assure
    --    Matériel de numéro de serie = Numero_Serie à bien l'état Est_Fonctionnel
    procedure Mettre_A_Jour (
            Stock: in out T_Stock;
            Numero_Serie: in Integer;
            Est_Fonctionnel: in Boolean
        ) with 
            Pre => Nb_Materiels(Stock) > 0 and Existe(Stock, Numero_Serie);

    -- Supprime un matériel du stock à l'aide de son numéro de série.
    -- 
    -- Paramètres
    --    Stock : le stock à compléter
    --    Numero_Serie : le numéro de série du matériel
    -- 
    -- Nécessite
    --    Nb_Materiels (Stock) > 0
    --    Un matériel de numéro de serie = Numero_Serie est déja présent.
    --
    -- Assure
    --    Nb_Materiels (Stock) = Nb_Materiels (Stock)'Avant - 1;
    procedure Supprimer (
            Stock: in out T_Stock;
            Numero_Serie: in Integer
        ) with 
            Pre => Nb_Materiels(Stock) > 0 and Existe(Stock, Numero_Serie),
            Post => Nb_Materiels (Stock) = Nb_Materiels (Stock)'Old - 1;

    -- Enregistrer un nouveau métériel dans le stock.  Il est en
    -- fonctionnement.  Le stock ne doit pas être plein.
    -- 
    -- Paramètres
    --    Stock : le stock à compléter
    --    Numero_Serie : le numéro de série du nouveau matériel
    --    Nature       : la nature du nouveau matériel
    --    Annee_Achat  : l'année d'achat du nouveau matériel
    -- 
    -- Nécessite
    --    Nb_Materiels (Stock) < CAPACITE
    -- 
    -- Assure
    --    Nouveau matériel ajouté
    --    Nb_Materiels (Stock) = Nb_Materiels (Stock)'Avant + 1
    procedure Enregistrer (
            Stock        : in out T_Stock;
            Numero_Serie : in     Integer;
            Nature       : in     T_Nature;
            Annee_Achat  : in     Integer
        ) with
            Pre => Nb_Materiels (Stock) < CAPACITE,
            Post => Nb_Materiels (Stock) = Nb_Materiels (Stock)'Old + 1;

    -- Existence d'un matériel avec le numéro de serie donné.
    -- 
    -- Paramètres
    --    Stock : le stock à compléter
    --    Numero_Serie : le numéro de série du matériel
    -- 
    -- Nécessite
    --    Vrai
    -- 
    -- Assure
    --    Vrai
    function Existe (Stock: in T_Stock; Numero_Serie: in Integer) return Boolean;

    -- Afficher le stock au terminal.
    -- 
    -- Paramètres
    --    Stock : le stock à compléter
    -- 
    -- Nécessite
    --    Vrai
    --
    -- Assure
    --    Vrai
    procedure Afficher (Stock: in T_Stock);

    -- Supprimer tous les matériels qui ne sont pas en état de fonctionnement.
    -- 
    -- Paramètres
    --    Stock : le stock à compléter
    -- 
    -- Nécessite
    --    Vrai
    --
    -- Assure
    --    Nb_Defectueux(Stock) = 0 et Nb_Materials(Stock) = Nb_Materials(Stock)'Avant - Nb_Defectueux(Stock)'Avant
    procedure Nettoyer (Stock: in out T_Stock) with
        Post => Nb_Defectueux(Stock) = 0 and Nb_Materiels(Stock) = Nb_Materiels(Stock)'Old - Nb_Defectueux(Stock)'Old;

private

    type T_Materiel is record
       Numero_Serie:    Integer;
       Nature:          T_Nature;
       Annee_Achat:     Integer;
       Est_Fonctionnel: Boolean;
    end record;
    
    type T_Materiels is array(1..CAPACITE) of T_Materiel;

    type T_Stock is record
       Materiels:       T_Materiels;
       Nombre:          Integer;
    end record;

end Stocks_Materiel;
