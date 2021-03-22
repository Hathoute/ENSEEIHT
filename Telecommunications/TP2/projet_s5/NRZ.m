function [N, t] = NRZ(bits, Fe, F_trans)
    n = size(bits, 1);
    Ns = max(floor(Fe/F_trans), 1);
    Te = 1/Fe;
    t = [0:Te:(n*Ns-1)*Te]';
    
    N = repelem(bits, Ns);
end

