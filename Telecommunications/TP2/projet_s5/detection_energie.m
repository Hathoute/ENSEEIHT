function [bits_restitues] = detection_energie(x_filtre, Ns)
    taille = length(x_filtre);
    K = 5;

    x_m = reshape(x_filtre, Ns, taille/Ns);
    energies = sum(x_m.^2);
    bits_restitues = energies > K;
    bits_restitues = bits_restitues';
    
end