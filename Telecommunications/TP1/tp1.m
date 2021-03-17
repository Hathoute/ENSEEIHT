close all;
clear;

% Information binaire
n = 12000;
bits = randi([0, 1], [n, 1]);

% Parametres
Fe = 24000;
Te = 1/Fe;
debit = 6000;

% Comparaison
mapping = @(bits, Fe, debit)mapping_moy_nulle(bits, Fe, debit);
filtrage = @(x, Ns)filtrage_rect(x, Ns);
fig_id = 1;
modulateur

mapping = @(bits, Fe, debit)mapping_4aires(bits, Fe, debit);
filtrage = @(x, Ns)filtrage_rect(x, Ns);
fig_id = 2;
modulateur

mapping = @(bits, Fe, debit)mapping_moy_nulle(bits, Fe, debit);
filtrage = @(x, Ns)filtrage_front(x, Ns);
fig_id = 3;
modulateur

mapping = @(bits, Fe, debit)mapping_moy_nulle(bits, Fe, debit);
filtrage = @(x, Ns)filtrage_rcos(x, Ns);
fig_id = 4;
modulateur

% Efficacité spectrale
fprintf("--- Efficacités spectales ---\n");

e1 = 6000;
fprintf("Efficacité spectrale du 1er: %f\n", debit/e1);

e2 = 4000;
fprintf("Efficacité spectrale du 2ème: %f\n", debit/e2);

e3 = 12000;
fprintf("Efficacité spectrale du 3ème: %f\n", debit/e3);

e4 = 5000;
fprintf("Efficacité spectrale du 4ème: %f\n", debit/e4);
