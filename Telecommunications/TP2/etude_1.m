
% Mapping
[Symboles, Ns] = mapping_moy_nulle(bits, Fe, debit);

% Surechantillonage
Suite_diracs = kron(Symboles, [1 zeros(1,Ns-1)])';
Suite_diracs = Suite_diracs(:);

% Filtrage
x = filtrage(Suite_diracs, Ns);

% Canal de propagation
x_propage = x;

% Filtrage reception
x_filtre = filtrage(x_propage, Ns);

% Echantillonage
x_echantillone = echantillonage(x_filtre, Ns);

% Decision
x_decision = sign(x_echantillone);

% Demapping
bits_transmits = (x_decision+1)./2;

% Erreurs
erreur = taux_erreur(bits, bits_transmits);