function x_echantillone = echantillonage(x_filtre, Ns, n0)
    if nargin < 3
        [~, n0] = max(abs(x_filtre(1:Ns,1)));
    end
    ech = reshape(x_filtre, Ns, length(x_filtre)/Ns);
    x_echantillone = ech(n0, :)';
    
end