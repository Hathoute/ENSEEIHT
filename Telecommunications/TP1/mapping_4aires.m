function [symboles, Ns] = mapping_4aires(bits, Fe, debit)

    Ns = 2*Fe/debit;

    if mod(length(bits), 2) > 0
        bits = [bits 0];
    end

    br = reshape(bits, 2, length(bits)/2);
    
    symboles = -3 + 2*sum(br)';
    indices = sum((br == [1;0])) == 2;
    symboles(indices) = 3;
    
end