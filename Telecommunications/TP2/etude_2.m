
% Mapping
[Symboles, Ns] = mapping_moy_nulle(bits, Fe, debit);

% Surechantillonage
Suite_diracs = kron(Symboles, [1 zeros(1,Ns-1)])';
Suite_diracs = Suite_diracs(:);

% Filtrage
x = filtrage(Suite_diracs, Ns);

% Canal de propagation
x_propage = filtre_bas(x, Fc, Fe);

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

% --------- Réponses -----------:
ordre = 51;
ords = [-(ordre-1)/2*Te:Te:(ordre-1)/2*Te];
h_bas = 2*Fc/Fe*sinc(2*Fc*ords);
h_mef = ones(1, Ns);
h_rec = ones(1, Ns);

H1 = abs(fft(h_mef, ordre).*fft(h_rec, ordre));
H2 = abs(fft(h_bas));