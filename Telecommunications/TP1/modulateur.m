% Mapping
[Symboles, Ns] = mapping(bits, Fe, debit);

% Surechantillonage
Suite_diracs = kron(Symboles, [1 zeros(1,Ns-1)]);
Suite_diracs = Suite_diracs(:,1);

% Filtrage
x = filtrage(Suite_diracs, Ns);

% Traçage
figure(fig_id)
subplot(2,1,1)
title("Signal transmis");
xlabel("Temps en sec");
plot((0:Te:Te*(length(x)-1)), x);
subplot(2,1,2)
pwelch(x,[],[],[],Fe,'twosided');

% Comparaison
figure(5)
hold on;
legend('-DynamicLegend');
PSDx=10*log10(pwelch(x));
x_axis = linspace(0, Fe/2, length(PSDx));
plot(x_axis, PSDx, 'DisplayName', sprintf("Modulateur %d", fig_id));