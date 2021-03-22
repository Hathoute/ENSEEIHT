function [x_filtre, h_haut, ords] = filtre_haut(x, Fc, Fe, ordre)

    ordre = 201;
    fc_norm = Fc/Fe;
    Te = 1/Fe;
    ords = [-(ordre-1)/2*Te:Te:(ordre-1)/2*Te];
    h_haut = -(2*fc_norm)*sinc(2*Fc*ords);
    h_haut((ordre+1)/2) = 1-2*fc_norm;
    x_padded = [x; zeros((ordre-1)/2, 1)];
    x_filtre = filter(h_haut, 1, x_padded);
    x_filtre = x_filtre((ordre+1)/2:end);
    
end