package body Types is

    function "<"(Gauche: T_Rank; Droit: T_Rank) return Boolean is
    begin
        return Gauche.Poid < Droit.Poid;
    end "<";

    function Hachage(Indice: in T_Indice) return Integer is
    begin
        return Indice.X;
    end Hachage;

end Types;