clear all; close all;

n = 300;
bits_transmettre = randi([0 1], n, 1);

F0 = 6000;
F1 = 2000;
Fc = 4000;
Fe = 48000;
Te = 1/Fe;
F_trans = 300;
Ns = floor(Fe/F_trans);
Ts = Ns/Fe;

%Génération du signal NRZ
[N, t] = NRZ(bits_transmettre, Fe, F_trans);
figure(1)
subplot(2,1,1)
plot(t, N, '-o')
xlabel("temps")
ylabel("NRZ(t)")
title('signal NRZ');
%Densité spectrale de puissance du signal NRZ
S = 1/length(N) * abs(fft(N, 2^15)).^2;
f = linspace(0, Fe, size(S,1));
subplot(2,1,2)
semilogy(f, abs(S), 'r-');
xlabel("fréquences")
ylabel("S_x")
title('la densité spectrale de puissance du signal NRZ');


%Génération du signal x
phi0 = rand*2*pi;
phi1 = rand*2*pi;
x = (1-N).*cos(2*pi*F0*t + phi0) + N.*cos(2*pi*F1*t + phi1);
figure(2)
subplot(2,1,1)
plot(t, x)
xlabel("temps")
ylabel("x(t)")
title("Le signal x(t)")
%Densité spectrale de puissance du signal x
S_x = 1/length(N) * abs(fft(x,2^15)).^2;
subplot(2,1,2)
semilogy(f, abs(S_x), 'r-')
xlabel("Fréquences")
ylabel("DSPx")
title('la densité spectrale de puissance du signal x');

%Ajout du bruit
figure(3)
for i=1:4
    subplot(2,2,i)
    SNR_dB = 10 + 10*i;
    x_bruit = bruit(x, SNR_dB);
    plot(t, x_bruit);
    xlabel("temps")
    ylabel("x bruité")
    title("SNR_d_B = " + SNR_dB)
end

ordre = 201;
%Filtre Passe-bas
[x_fb, h_bas, ords] = filtre_bas(x_bruit, Fc, Fe, ordre);
%Tracés du filtre Passe-bas
figure(4)
subplot(2,1,1)
plot(ords, h_bas)
xlabel("temps")
ylabel("h (réponse impulsionnelle)")
title("Réponse impulsionelle du filtre passe bas")
subplot(2,1,2)
S_h_bas = abs(fft(h_bas)).^2;
plot(ords./(Te*(ordre-1)), abs(S_h_bas), 'r-')
xlabel("temps")
ylabel("réponse en fréquence")
title("Réponse frequentielle du filtre passe bas")
    
figure(5)
S_x = 1/length(N) * abs(fft(x,2^15)).^2;
semilogy(f, abs(S_x), 'b-')
hold on
S_h_bas = abs(fft(h_bas,2^15)).^2;
semilogy(f, abs(S_h_bas), 'r-')
xlabel("Fréquences")
title("S_x et réponse frequentielle du filtre passe bas")
legend("DSP_x","Réponse fréquentielle")
    
%Filtre Passe-haut
[x_fh, h_haut, ords] = filtre_haut(x_bruit, Fc, Fe, ordre);    
%Tracés du filtre passe-haut
figure(6)
subplot(2,1,1)
plot(ords, h_haut)
xlabel("temps")
ylabel("h (réponse impulsionnelle)")
title("Réponse impulsionelle du filtre passe haut")
subplot(2,1,2)
S_haut = abs(fft(h_haut)).^2;
plot(ords./(Te*(ordre-1)), abs(S_haut), 'r-')
xlabel("temps")
ylabel("réponse en fréquence")
title("Réponse frequentielle du filtre passe haut")
    
figure(7)
S_x = 1/length(N) * abs(fft(x,2^15)).^2;
semilogy(f, abs(S_x), 'b-')

hold on
S_haut = abs(fft(h_haut, 2^15)).^2;
plot(f, abs(S_haut), 'r-')
xlabel("Fréquences")
title("S_x et réponse frequentielle du filtre passe haut")
legend("DSP_x","Réponse fréquentielle")

    
%Signal en sortie des filtres:
f = linspace(0, Fe, size(t,1));
figure(8)
subplot(2,1,1)
plot(t, x_fb)
xlabel("temps")
ylabel("sortie du passe bas")
title("Signal en sortie du passe bas")
subplot(2,1,2)
S_xfb = abs(fft(x_fb)).^2;
semilogy(f, abs(S_xfb), 'r-')
xlabel("Fréquences")
ylabel("DSP")
title("Densité spectrale de puissance du signal en sortie du passe bas")
figure(9)
subplot(2,1,1)
plot(t, x_fh)
xlabel("temps")
ylabel("sortie du passe haut")
title("Signal en sortie du passe haut")
subplot(2,1,2)
S_xfh = abs(fft(x_fh)).^2;
semilogy(f, abs(S_xfh), 'r-')
xlabel("Fréquences")
ylabel("DSP")
title("Densité spectrale de puissance du signal en sortie du passe haut")

%Retitution par detection d'énergie
[bits_restitues] = detection_energie(x_fb, Ns);

NRZ_sortie = repelem(bits_restitues, Ns);
figure(10)
subplot(2,1,1)
plot(t, N);
xlabel("temps")
ylabel("NRZ(t) en entrée")
title("NRZ à l'entrée");
subplot(2,1,2)
plot(t, NRZ_sortie)
xlabel("temps")
ylabel("NRZ(t) en sortie")
title("NRZ en sortie (Démodulation par filtrage)");
    
%Calculer le taux d'erreur
erreurs = n - sum(bits_transmettre == bits_restitues);
taux_erreur = erreurs/n;


%Reconstitution d'image :

load('DonneesBinome1.mat');
[NR, temps] = NRZ(bits', Fe, F_trans);
x = (1-NR).*cos(2*pi*F0*temps + phi0) + NR.*cos(2*pi*F1*temps + phi1);
x_bruit = bruit(x, 15);
ordre = 201;
[x_filtre, ~, ~] = filtre_bas(x_bruit, Fc, Fe, ordre);
[bits_restitues] = detection_energie(x_filtre, Ns);
reconstitution_image(bits_restitues);
which reconstitution_image;


%Application à la recommendation V21
F0 = 1180;
F1 = 980;
x_V21 = (1-N).*cos(2*pi*F0*t + phi0) + N.*cos(2*pi*F1*t + phi1);
%Filtrage
[x_filtreV21, ~, ~] = filtre_bas(x_V21, Fc, Fe, ordre)
%Restitution
bits_restitueV21 = detection_energie(x_filtreV21, Ns)
%Taux d'erreur sans bruit
erreursV21 = n - sum(bits_transmettre == bits_restitueV21);
taux_erreurV21 = erreursV21/n;

NRZ_sortie = repelem(bits_restitueV21, Ns);
figure(10)
subplot(2,1,1)
plot(t, N);
xlabel("temps")
ylabel("NRZ(t) en entrée")
title("NRZ à l'entrée");
subplot(2,1,2)
plot(t, NRZ_sortie)
xlabel("temps")
ylabel("NRZ(t) en sortie")
title("NRZ en sortie (Démodulation par filtrage V21)avec taux d'erreur = " + taux_erreurV21);

%Demodulation FSK
F0 = 1180;
F1 = 980;
[N, t] = NRZ(bits_transmettre, Fe, F_trans);
x = (1-N).*cos(2*pi*F0*t + phi0) + N.*cos(2*pi*F1*t + phi1);
bits_res_FSK = Demod_FSK(x, t, F0, F1, Ns, phi0, phi1);
erreurs_synch = sum(bits_res_FSK' ~= bits_transmettre)


%Reconstitution d'image :

load('DonneesBinome1.mat');
[NR, temps] = NRZ(bits', Fe, F_trans);
xImage = (1-NR).*cos(2*pi*F0*temps + phi0) + NR.*cos(2*pi*F1*temps + phi1);
x_bruit = bruit(xImage, SNR_dB);
bits_res_FSK_image = Demod_FSK(x_bruit, temps, F0, F1, Ns, phi0, phi1);

reconstitution_image(bits_res_FSK_image) ;
which reconstitution_image ;
 
%Problème de synchronisation

phi2 = rand*2*pi;
phi3 = rand*2*pi;
[N, t] = NRZ(bits_transmettre, Fe, F_trans);
x = (1-N).*cos(2*pi*F0*t + phi0) + N.*cos(2*pi*F1*t + phi1);
Bits_non_synch = Demod_FSK(x, t, F0, F1, Ns, phi2, phi3);

erreurs_sans_synch = sum(Bits_non_synch' ~= bits_transmettre)

%Gestion d'une erreur de phase porteuse

bits_res_GE = Demod_FSK_GE(x, t, F0, F1, Ns);
erreurs_gestion_erreur = sum(bits_res_GE' ~= bits_transmettre)
