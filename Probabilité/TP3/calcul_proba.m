function [x_min,x_max,probabilite] = calcul_proba(E_nouveau_repere,p)
    
    x_min = min(E_nouveau_repere(:,1));
    x_max = max(E_nouveau_repere(:,1));
    y_min = min(E_nouveau_repere(:,2));
    y_max = max(E_nouveau_repere(:,2));
    
    N = round((x_max-x_min+1)*(y_max-y_min+1));
    
    probabilite = 1;
    n = size(E_nouveau_repere,1);
    for k=0:n-1
        probabilite = probabilite - nchoosek(N,k)*p^k*(1-p)^(N-k);
    end
    
end