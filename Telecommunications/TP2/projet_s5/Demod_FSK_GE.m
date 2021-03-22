function bits_res_GE = Demod_FSK_GE(x, t, F0, F1, Ns)

    Taille = length(x);
    x_reshaped = reshape(x, Ns, Taille/Ns);
    t_reshaped = reshape(t, Ns, Taille/Ns);
    x0_cos = x_reshaped .* cos(2*pi*F0*t_reshaped);
    x0_sin = x_reshaped .* sin(2*pi*F0*t_reshaped);
    x1_cos = x_reshaped .* cos(2*pi*F1*t_reshaped);
    x1_sin = x_reshaped .* sin(2*pi*F1*t_reshaped);
    x0 = sum(x0_cos).^2 + sum(x0_sin).^2;
    x1 = sum(x1_cos).^2 + sum(x1_sin).^2;
    H = x0 - x1;
    bits_res_GE = H<0;

end

