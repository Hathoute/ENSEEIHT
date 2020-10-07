-- Score PIXAL le 07/10/2020 à 17:48 : 100%

with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

-- Afficher le PGCD de deux entiers positifs.
procedure PGCD is
    A, B: Integer;
    n_A, n_B: Integer;
    pgcd: Integer;
begin
    
    -- Demander deux entiers A et B
    Put("A et B ? ");
    Get(A);
    Get(B);

    -- Determiner le PGCD de A et B
    n_A := A;
    n_B := B;
    while n_A /= n_B loop   -- Tant que n_A different de n_B
        -- Soustraire au plus grande le plus petit
        if n_A > n_B then
            n_A := n_A - n_B;
        else
            n_B := n_B - n_A;
        end if;
    end loop;
    pgcd := n_A;

    -- Afficher le PGCD
    Put("pgcd = ");
    Put(pgcd);

end PGCD;