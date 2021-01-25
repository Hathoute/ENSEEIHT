with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

package body Module_IO is

	procedure Lire(Fichier: in Unbounded_String; PagesNum: out Integer; Liens: out LC_Integer_Integer.T_LC) is
        File: Ada.Text_IO.File_Type;
        From, To: Integer;
    begin
        LC_Integer_Integer.Initialiser(Liens);

        Open(File, In_File, To_String(Fichier) & ".net");
        Get(File, PagesNum);
        while not End_Of_File(File) loop
            Get(File, From);
            Get(File, To);
            LC_Integer_Integer.Ajouter(Liens, From, To);
        end loop;

        Close(File);
    end Lire;

    procedure Ecrire(Fichier: in Unbounded_String; PagesNum: in Integer; MaxIterations: in Integer; Alpha: in T_Digits; Rangs: in Vecteur_Poids.T_Vecteur) is
        RangFile: Ada.Text_IO.File_Type;
        PoidFile: Ada.Text_IO.File_Type;

        procedure Ecrire_Poids_Header is
        begin
            Put(PoidFile, PagesNum, 1);
            Put(PoidFile, " ");
            Put(PoidFile, Float(Alpha), Fore=>1, Aft=>10);
            Put(PoidFile, " ");
            Put(PoidFile, MaxIterations, 1);
            New_Line(PoidFile);
        end Ecrire_Poids_Header;

        procedure Ecrire_Rank (Rank: in T_Rank) is
        begin
            Put(RangFile, Rank.Rang, 1);
            Put(PoidFile, Float(Rank.Poid), Fore=>1, Aft=>10);
            New_Line(RangFile);
            New_Line(PoidFile);
        end Ecrire_Rank;
        procedure Ecrire_Tout is
                new Vecteur_Poids.Pour_Chaque(Ecrire_Rank);
    begin
        Create(RangFile, Out_File, To_String (Fichier) & ".ord");
        Create(PoidFile, Out_File, To_String (Fichier) & ".p");

        Ecrire_Poids_Header;
        Ecrire_Tout(Rangs);

        Close(RangFile);
        Close(PoidFile);
    end Ecrire;


end Module_IO;
