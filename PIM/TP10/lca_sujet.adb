with LCA;
with Ada.Text_IO;  use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure LCA_Sujet is

    package LCA_str_int is
        new LCA (T_Cle => Unbounded_String, T_Donnee => Integer);
    use LCA_str_int;

    Donnees : T_LCA;

begin

    Initialiser(Donnees);
    Enregistrer(Donnees, To_Unbounded_String("un"), 1);
    Enregistrer(Donnees, To_Unbounded_String("deux"), 2);

    Put("un -> ");
    Put(La_Donnee(Donnees, To_Unbounded_String("un")), 1);
    New_Line;
    Put("deux -> ");
    Put(La_Donnee(Donnees, To_Unbounded_String("deux")), 1);
    New_Line;
   
end LCA_Sujet;