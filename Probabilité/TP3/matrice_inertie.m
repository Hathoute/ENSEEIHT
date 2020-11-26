function [C_x,C_y,M] = matrice_inertie(E_x,E_y,G_norme_E)

    PI = sum(G_norme_E);
    C_x = sum(E_x.*G_norme_E)/PI;
    C_y = sum(E_y.*G_norme_E)/PI;
    
    M = zeros(2);
    M(1,1) = sum(G_norme_E.*((E_x-C_x).^2))/PI;
    M(2,2) = sum(G_norme_E.*((E_y-C_y).^2))/PI;
    M(1,2) = sum(G_norme_E.*(E_y-C_y).*(E_x-C_x))/PI;
    M(2,1) = M(1,2);
    
end