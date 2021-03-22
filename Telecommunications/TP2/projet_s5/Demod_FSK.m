function [bits_restitue] = Demod_FSK(x, t, F0, F1, Ns, phi0, phi1)

    Taille = length(x);
    x_reshaped = reshape(x, Ns, Taille/Ns);
    t_reshaped = reshape(t, Ns, Taille/Ns);
    x0 = x_reshaped .* cos(2*pi*F0*t_reshaped + phi0);
    x1 = x_reshaped .* cos(2*pi*F1*t_reshaped + phi1);
    H = sum(x0) - sum(x1);
    bits_restitue = H<0;
    
end

