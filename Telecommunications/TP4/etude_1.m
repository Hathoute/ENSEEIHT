
% Mapping
Ns = 2*Fe/debit;
bits_mod = bits;
bits_mod(bits_mod == 0) = -1;
Symboles = bits_mod(1:2:end) + 1i*bits_mod(2:2:end);

% Surechantillonage
Suite_diracs = upsample(Symboles, Ns);

% Filtrage
h=rcosdesign(0.35,8,Ns);
retard = 8*Ns/2;
Suite_diracs = [Suite_diracs; zeros(retard,1)];
x_e = filter(h, 1, Suite_diracs);
x_e = x_e(retard+1:end);

% Transposition
t = [0:Te:(length(x_e)-1)*Te]';
Fp = 2000;
x = real(x_e.*exp(2j*pi*Fp*t));

% Canal de propagation
if avec_bruit > 0
    sigma_carre = (mean(abs(x).^2)*Ns)/(2*log2(Ns)*EbN0);
    x_propage = x + randn(1,length(x))'.*sigma_carre;
else
    x_propage = x;
end

% Retour en bande de base
x_cos = x_propage.*cos(2*pi*Fp*t);
x_sin = x_propage.*sin(2*pi*Fp*t);

x_cpb = filtre_bas(x_cos, 2*Fp, Fe);
x_spb = filtre_bas(x_sin, 2*Fp, Fe);
x_retour = x_cpb + 1j*x_spb;

% Filtrage reception
hr = fliplr(h);
x_retour = [x_retour; zeros(retard,1)];
x_filtre = filter(hr, 1, x_retour);
x_filtre = x_filtre(retard+1:end);

% Echantillonage
x_echantillone = echantillonage(x_filtre, Ns, 1);

% Decision
x_decision = [sign(real(x_echantillone)) sign(imag(x_echantillone))];

% Demapping
bits_transmits = reshape(x_decision', length(bits), 1);
bits_transmits(bits_transmits == -1) = 0;

% Erreurs
erreur = taux_erreur(bits, bits_transmits);