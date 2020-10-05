with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;

procedure Maximum is

    -- On peut renommer Max2 et Max3 en Max car les deux fonctions ont des paramètres differents
	-- Le plus grand de 2 entiers.
	function Max (N1, N2 : in Integer) return Integer with
		Post => Max'Result >= N1 and Max'Result >= N2
    is
	begin
		return Integer(Float(N1 + N2)/2.0 + Abs(Float(N1 - N2)/2.0));
	end Max;


	procedure Tester_Max2 is
	begin
        pragma Assert (Max(9, 6) = 9);
        pragma Assert (Max(9, 6) = 9);
        pragma Assert (Max(-5, -5) = -5);
	end Tester_Max2;


	-- Le plus grand de 3 entiers.
	function Max (N1, N2, N3 : in Integer) return Integer with
		Post => Max'Result >= N1 and Max'Result >= N2 and Max'Result >= N3
    is
	begin
		return Max(Max(N1, N2), N3);	-- TODO à remplacer
	end Max;

	procedure Tester_Max3 is
	begin
		pragma Assert (Max(1, 2, 3) = 3);
		pragma Assert (Max(3, 2, 1) = 3);
		pragma Assert (Max(2, 1, 3) = 3);
		pragma Assert (Max(2, 3, 1) = 3);
		pragma Assert (Max(0, 0, 0) = 0);
	end Tester_Max3;

-- Test PIXAL ------------------------------------------------------------------

	A, B, C, D, E: Integer;	-- 5 entiers lu au clavier
begin
	Tester_Max2;
	Tester_Max3;

	-- Demander les entiers
	Put("Donner 5 entiers : ");
	Get(A);
	Get(B);
	Get(C);
	Get(D);
	Get(E);

	-- Afficher le Max de A et B
	Put ("Max (");
	Put (A, 1);
	Put (", ");
	Put (B, 1);
	Put (") = ");
	Put (Max (A, B), 1);
	New_Line;

	-- Afficher le Max de C, D et E
	Put ("Max (");
	Put (C, 1);
	Put (", ");
	Put (D, 1);
	Put (", ");
	Put (E, 1);
	Put (") = ");
	Put (Max (C, D, E), 1);
	New_Line;

end Maximum;
