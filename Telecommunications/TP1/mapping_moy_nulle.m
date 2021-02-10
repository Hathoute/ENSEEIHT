function [symboles, Ns] = mapping_moy_nulle(bits, Fe, debit)

    Ns = Fe/debit;
    symboles = 2*bits - 1;

end