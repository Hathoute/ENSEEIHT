clear;
close all;

% Methode de filtrage
filtrage = @(x, Ns)filtrage_rcos(x, Ns);

% Information binaire
n = 4000;
bits = randi([0, 1], [n, 1]);

% Parametres
Fe = 24000;
Te = 1/Fe;
debit = 3000;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Etude 3.1:
fprintf("---- ETUDE 3.1 -----\n");
fprintf("---- Etude sans canal de propagation -----\n");

etude_1

figure(1)
h = ones(1, Ns);
g = conv(h, h);
plot(g);
title("3.1.2: Réponse impulsionnelle de la chaine de transmission g");

figure(2)
plot(reshape(x_filtre,Ns,length(x_filtre)/Ns));
title("3.1.4: Diagramme de l'oeil");

ech = echantillonage(x_filtre, Ns, 8);
dec = sign(ech);
bts = (dec+1)./2;
err = taux_erreur(bits, bts);
fprintf("Erreur pour n0 = 8: %f\n", err);

ech = echantillonage(x_filtre, Ns, 3);
dec = sign(ech);
bts = (dec+1)./2;
err = taux_erreur(bits, bts);
fprintf("Erreur pour n0 = 3: %f\n", err);

ech = echantillonage(x_filtre, Ns, 6);
dec = sign(ech);
bts = (dec+1)./2;
err = taux_erreur(bits, bts);
fprintf("Erreur pour n0 = 6: %f\n\n", err);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Etude 3.2:
fprintf("---- ETUDE 3.2 -----\n");

Fc = 4000;
etude_2

figure(3)
subplot(2,1,1);
x_axis = linspace(-Fe/2, Fe/2, ordre);
plot(x_axis, fftshift(H1));
hold on;
plot(x_axis, fftshift(H2));
hold off;
title("Etude 2-1: |H(f)Hr(f)| et |Hc(f)|");
legend("|H(f)Hr(f)|", "|Hc(f)|");

subplot(2,1,2);
plot(reshape(x_filtre,Ns,length(x_filtre)/Ns));
title("Etude 2-1: Diagramme de l'oeil");

fprintf("Erreur pour Fc = 4000: %f\n", erreur);


Fc = 1000;
etude_2

figure(4)
subplot(2,1,1);
x_axis = linspace(-Fe/2, Fe/2, ordre);
plot(x_axis, fftshift(H1));
hold on;
plot(x_axis, fftshift(H2));
hold off;
title("Etude 2-2: |H(f)Hr(f)| et |Hc(f)|");
legend("|H(f)Hr(f)|", "|Hc(f)|");

subplot(2,1,2);
plot(reshape(x_filtre,Ns,length(x_filtre)/Ns));
title("Etude 2-2: Diagramme de l'oeil");

fprintf("Erreur pour Fc = 1000: %f\n", erreur);