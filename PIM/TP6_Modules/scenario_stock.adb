with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Stocks_Materiel;      use Stocks_Materiel;

-- Auteur: 
-- Gérer un stock de matériel informatique.
--
procedure Scenario_Stock is

    Mon_Stock : T_Stock;
begin
    -- Créer un stock vide
    Creer (Mon_Stock);
    pragma Assert (Nb_Materiels (Mon_Stock) = 0);

    -- Enregistrer quelques matériels
    Enregistrer (Mon_Stock, 1012, UNITE_CENTRALE, 2016);
    pragma Assert (Nb_Materiels (Mon_Stock) = 1);

    Enregistrer (Mon_Stock, 2143, ECRAN, 2016);
    pragma Assert (Nb_Materiels (Mon_Stock) = 2);

    Enregistrer (Mon_Stock, 3001, IMPRIMANTE, 2017);
    pragma Assert (Nb_Materiels (Mon_Stock) = 3);

    Enregistrer (Mon_Stock, 3012, UNITE_CENTRALE, 2017);
    pragma Assert (Nb_Materiels (Mon_Stock) = 4);

    -- Nb_Defectueux & Mettre à jour tests.
    pragma Assert(Nb_Defectueux(Mon_Stock) = 0);

    Mettre_A_Jour(Mon_Stock, 1012, False);
    pragma Assert(Nb_Defectueux(Mon_Stock) = 1);

    Mettre_A_Jour(Mon_Stock, 3001, False);
    pragma Assert(Nb_Defectueux(Mon_Stock) = 2);

    Mettre_A_Jour(Mon_Stock, 1012, True);
    pragma Assert(Nb_Defectueux(Mon_Stock) = 1);

    -- Supprimer tests.
    Supprimer(Mon_Stock, 3012);
    pragma Assert(Nb_Defectueux(Mon_Stock) = 1);
    pragma Assert (Nb_Materiels (Mon_Stock) = 3);

    Supprimer(Mon_Stock, 3001);
    pragma Assert(Nb_Defectueux(Mon_Stock) = 0);
    pragma Assert (Nb_Materiels (Mon_Stock) = 2);

    -- Afficher test.
    Afficher(Mon_Stock);

    -- Nettoyer tests.
    Enregistrer (Mon_Stock, 1234, UNITE_CENTRALE, 2017);
    Enregistrer (Mon_Stock, 3312, IMPRIMANTE, 2016);
    Mettre_A_Jour(Mon_Stock, 3312, False);
    Mettre_A_Jour(Mon_Stock, 1012, False);
    pragma Assert (Nb_Materiels (Mon_Stock) = 4);
    pragma Assert(Nb_Defectueux(Mon_Stock) = 2);

    Nettoyer(Mon_Stock);
    pragma Assert (Nb_Materiels (Mon_Stock) = 2);
    pragma Assert(Nb_Defectueux(Mon_Stock) = 0);

end Scenario_Stock;
