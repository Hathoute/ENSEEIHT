% Information binaire
n = 12000;
bits = randi([0, 1], [n, 1]);

% Parametres
Fe = 24000;
Te = 1/Fe;
debit = 6000;


% Mapping
[Symboles, Ns] = mapping_moy_nulle(bits, Fe, debit);

% Surechantillonage
Suite_diracs = kron(Symboles, [1 zeros(1,Ns-1)]);
Suite_diracs = Suite_diracs(:,1);

% Filtrage
x = filtrage_rcos(Suite_diracs, Ns);

% Traçage
figure(1);
title("Signal transmis");
x_label = "Temps en sec";
plot((0:Te:Te*(length(x)-1)), x);

figure(2);
pwelch(x,[],[],[],Fe,'twosided');

% Comparaison
mappings = {@(bits, Fe, debit)mapping_moy_nulle(bits, Fe, debit)}

figure(3);
