with TH;
with Ada.Text_IO;  use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure TH_Sujet is

    package TH_str_int is
        new TH (Capacite => 11, T_Cle => Unbounded_String, T_Donnee => Integer, Hachage => Length);
    use TH_str_int;

    Donnees : T_TH;

    procedure Afficher_Element(Cle: Unbounded_String; Donnee: Integer) is
    begin
        Put(To_String(Cle) & " -> ");
        Put(Donnee, 1);
        New_Line;
    end Afficher_Element;

    procedure Afficher_Elements is
            new Pour_Chaque(Afficher_Element);

begin

    Initialiser(Donnees);

    Enregistrer(Donnees, To_Unbounded_String("un"), 1);
    Enregistrer(Donnees, To_Unbounded_String("deux"), 2);
    Enregistrer(Donnees, To_Unbounded_String("trois"), 3);
    Enregistrer(Donnees, To_Unbounded_String("quatre"), 4);
    Enregistrer(Donnees, To_Unbounded_String("cinq"), 5);
    Enregistrer(Donnees, To_Unbounded_String("quatre-vingt-dix-neuf"), 99);
    Enregistrer(Donnees, To_Unbounded_String("vingt-et-un"), 21);

    Put("Elements de la table de hachage.");
    Afficher_Elements(Donnees);
    
    Vider(Donnees);

end TH_Sujet;