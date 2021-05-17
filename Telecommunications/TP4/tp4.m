clear;
close all;


% Methode de filtrage
filtrage = @(x, Ns)filtrage_rect(x, Ns);

% Information binaire
n = 12000;
bits = randi([0, 1], [n, 1]);

% Parametres
Fe = 10000;
Te = 1/Fe;
debit = 2000;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Etude 3.1
fprintf("\nEtude 3.1 ----------------\n");
avec_bruit = 0;
etude_1

erreurs = zeros(1,9);
erreurs_th = zeros(1,9);
avec_bruit = 1;
for i=0:8
    EbN0 = 10^(i/20);
    etude_1
    erreurs(1,i+1) = erreur;
    erreurs_th(1,i+1) = qfunc(sqrt(2*EbN0));
end

figure(1);
x_axis = 0:1:8;
semilogy(x_axis, erreurs, "DisplayName", "TEB simulé");
hold on
semilogy(x_axis, erreurs_th, "DisplayName", "TEB théorique");
legend;
title("2-3: Erreurs pour chaine avec bruit");


return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Etude 2.3
fprintf("\nEtude 2.3 ----------------\n");
erreurs = zeros(1,9);
erreurs_th = zeros(1,9);
for i=0:8
    EbN0 = 10^(i/20);
    etude_1
    erreurs(1,i+1) = erreur;
    erreurs_th(1,i+1) = qfunc(sqrt(2*EbN0));
end

figure(1);
x_axis = 0:1:8;
semilogy(x_axis, erreurs, "DisplayName", "TEB simulé");
hold on
semilogy(x_axis, erreurs_th, "DisplayName", "TEB théorique");
legend;
title("2-3: Erreurs pour chaine avec bruit");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Etude 3.2
fprintf("\nEtude 3.2 ----------------\n");

avec_bruit = 0;
etude_2

figure(2)
plot(reshape(x_filtre,Ns,length(x_filtre)/Ns));
title("3-2-1: Diagramme de l'oeil");
fprintf("Taux d'erreur binaire: %f \n", erreur);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Etude 3.3
fprintf("\nEtude 3.3 ----------------\n");

erreurs = zeros(1,9);
for i=0:8
    EbN0 = 10^(i/10);
    avec_bruit = 1;
    etude_2
    erreurs(1,i+1) = erreur;
    erreurs_th(1,i+1) = qfunc(sqrt(2*EbN0));
end

figure(3);
x_axis = 0:1:8;
semilogy(x_axis, erreurs, "DisplayName", "TEB simulé");
hold on
semilogy(x_axis, erreurs_th, "DisplayName", "TEB théorique");
title("3-3: Erreurs pour chaine avec bruit");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Etude 4.2
fprintf("\nEtude 4.2 ----------------\n");

Fe = 24000;
debit = 6000;

avec_bruit = 0;
etude_3;

figure(4)
plot(reshape(x_filtre,Ns,length(x_filtre)/Ns));
title("4-2-1: Diagramme de l'oeil");
fprintf("Taux d'erreur binaire: %f \n", erreur);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Etude 4.3
fprintf("\nEtude 4.3 ----------------\n");

tes = zeros(1,9);
tes_th = zeros(1,9);
for i=0:8
    EbN0 = 10^(i/10);
    avec_bruit = 1;
    etude_3;
    tes(1,i+1) = 1-sum(x_decision == Symboles)/length(Symboles);
    tes_th(1,i+1) = 3/2*qfunc(sqrt(4/5*EbN0));
    erreurs(1,i+1) = erreur;
    erreurs_th(1,i+1) = 3/4*qfunc(sqrt(4/5*EbN0));
end

figure(5);
x_axis = 0:1:8;
semilogy(x_axis, tes, "DisplayName", "TES simulé");
hold on;
semilogy(x_axis, tes_th, "DisplayName", "TES théorique");
title("4-3: TES pour chaine avec bruit");
legend;

figure(6);
semilogy(x_axis, erreurs, "DisplayName", "TEB simulé");
hold on;
semilogy(x_axis, erreurs_th, "DisplayName", "TEB théorique");
title("4-3: TEB pour chaine avec bruit");

