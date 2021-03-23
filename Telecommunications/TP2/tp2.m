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

%%%%%%%%%% Réponses aux questions:
fprintf("\n---- Réponses aux questions ----\n");
fprintf("1-1: 1ere méthode: à partir du tracé de g : on prend n0 = abscisse max(g) \n");
fprintf("     2eme méthode: à partir du diagrame de l'oeil : on prend le Ts qui correspond au min des intersections verticales avec le diagramme de l'oeil. \n");

fprintf("1-2: Si on prend n0 = 3, on aura des interférences entre les signaux. Donc le taux d'erreur augmente.\n");

fprintf("2-1: Sur le tracé, on remarque que pour 4000Hz, module(Hc) a une largeur plus grande que celle de module(H*Hr). On en déduit alors que le critère de Nyquist est bien vérifié. Ce qui n'est pas le cas pour 1000Hz.\n");

fprintf("2-2: Sur le diagramme de l'oeil, on remarque qu'on ne trouve pas l'indice de l'échantillon optimal n0 pour 1000Hz contrairement à celui de 4000Hz où on peut repérer facilement l'indice n0 optimal pour lequel le critère de Nyquist est vérifié.\n");