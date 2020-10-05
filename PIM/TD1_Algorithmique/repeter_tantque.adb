with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

procedure Repeter_TantQue is

	--------------------------------------------------------------------------------
	--  Cette partie définit l'expression Condition et l'instruction Séquence     --
	--  INUTILE DE LIRE CETTE PARTIE                                              --
	--------------------------------------------------------------------------------
                                                                                  --
	package Instrumentation is                                                    --
		function Condition return Boolean;                                        --
		procedure Sequence;                                                       --
	private                                                                       --
		Dernier: Integer := 0;                                                    --
	end Instrumentation;                                                          --
                                                                                  --
	package body Instrumentation is                                               --
                                                                                  --
		function Condition return Boolean is                                      --
				Valeur: Integer;                                                  --
			begin                                                                 --
				Get (Valeur);                                                     --
				return Valeur > 0;                                                --
			end;                                                                  --
																				  --
		procedure Sequence is                                                     --
			begin                                                                 --
				Dernier := Dernier + 1;                                           --
				Put (Dernier);                                                    --
				New_Line;                                                         --
			end;                                                                  --
                                                                                  --
	end Instrumentation;                                                          --
                                                                                  --
	use Instrumentation;                                                          --
                                                                                  --
	--------------------------------------------------------------------------------


begin
	-- Voici le TantQue à réécrire avec un Répéter
    loop
        exit when Condition = False;
        Sequence;
    end loop;
end Repeter_TantQue;
