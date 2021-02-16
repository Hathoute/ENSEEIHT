clear;
close all;

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
plot((0:Te:Te*(length(x)-1)), x);

figure(2);
pwelch(x,[],[],[],Fe,'twosided');

% Comparaison
mappings = {@(bits, Fe, debit)mapping_moy_nulle(bits, Fe, debit);
            @(bits, Fe, debit)mapping_4aires(bits, Fe, debit);
            @(bits, Fe, debit)mapping_moy_nulle(bits, Fe, debit);
            @(bits, Fe, debit)mapping_moy_nulle(bits, Fe, debit)};
filtres = {@(suite_diracs, Ns_m)filtrage_rect(suite_diracs, Ns_m);
           @(suite_diracs, Ns_m)filtrage_rect(suite_diracs, Ns_m);
           @(suite_diracs, Ns_m)filtrage_front(suite_diracs, Ns_m);
           @(suite_diracs, Ns_m)filtrage_rcos(suite_diracs, Ns_m)};        

figure(3);
for i=1:4
    [Symboles, Ns] = mappings{i,1}(bits, Fe, debit);
    Suite_diracs = kron(Symboles, [1 zeros(1,Ns-1)]);
    Suite_diracs = Suite_diracs(:,1);
    x = filtres{i,1}(Suite_diracs, Ns);
    PSDx = 10*log10(pwelch(x));
    plot(PSDx);
    if i == 1
        hold;
    end
end
       
