%% Modem par filtrage %%

clear;
close all;
clc;

%% Modulation du signal %%

% Génération d'un signal binaire (N bits) aléatoirement
N = 300;
Signal_Binaire = randi(2, 1, N) -1;

% Signal NRZ
Fe = 48000;         % Fréquence d'échantillonnage
Fs = 300;           % Débit de bits par seconde demandé
Ts =  1 / Fs;       % Période par niveau
Te =  1 / Fe;       % Période d'échantillonnage 
Ns = Fe / Fs;       % Nombre d'échantillons par niveau

NRZ = kron(Signal_Binaire, ones(1, Ns)); % Signal NRZ

% Affichage du Signal NRZ
figure(1)
temps = (0:N*Ns-1)*Te; % Intervalle de temps
subplot(2,2,1)
plot(temps,NRZ)
title('NRZ en fonction du temps');
xlabel('Temps en s');
ylabel('NRZ(t)');

% Densité spectrale de NRZ
DSP_estime = pwelch (NRZ, [], [], [], Fe, 'twosided');  % Calcul de la DSP de NRZ par la fonction pwelch
taille = length(DSP_estime);                            % Nombre de ligne dans DSP_estime
frequence = linspace(0,Fe,taille);                      % Intervalle de fréquence
% Affichage de la densité de puissance estimée de NRZ 
figure(1)
subplot(2,2,2)
plot(frequence, DSP_estime','LineWidth',1)
hold on

DSP_theorique = (1/4) * Ts * (sinc(pi * Ts * frequence)).^2 + (1/4)*dirac(frequence); % Formule donnée par le sujet
% Affichage de la densité de puissance théorique de NRZ (sur la même que
% celle estimée)
plot(frequence, DSP_theorique,'LineWidth', 2)
title('Densité spectrale de puissance de NRZ');
xlabel('Frequence en Hz');
ylabel('Amplitude');
hold off
legend('DSP estimée','DSP théorique')

% Création du signal modulé nommé x
Fc = 4000;                  % Fréquence de coupure
DeltaF = 2000;              % Delta de fréquence
F0 = Fc + DeltaF;           % Fréquence pour le signal sinusoidal des 1 de NRZ
F1 = Fc - DeltaF;           % Fréquence pour le signal sinusoidal des 0 de NRZ
psi0 = rand*2*pi;           % Phase tiré aléatoirement pour le signal sinusoidal des 0 de NRZ
psi1 =  rand*2*pi;          % Phase tiré aléatoirement pour le signal sinusoidal des 1 de NRZ
x = (1-NRZ) .* cos(2*pi*F0*temps + psi0) + NRZ .* cos(2*pi*F1*temps + psi1); % Par définition

% Affichage du signal modulé x
figure(1)
subplot(2,2,3)
plot(temps,x)
title('Signal x en fonction du temps');
xlabel('Temps en s');
ylabel('x(t)');

% DSP Theorique du signal modulé x
DSP_estime_X = pwelch(x, [], [], [], 1/Te, 'twosided');  % Calcul de la DSP de x par la fonction pwelch
figure(1)
subplot(2,2,4)
plot(frequence, DSP_estime_X)
title('Densité spectrale de puissance de X')
xlabel('Frequence en Hz');
ylabel('Amplitude');

% Canal de transmission (ajout d'un bruit blanc et Gaussien)
SNR = 50;                           % Sound to Noise Ratio
Px = mean(abs(x).^2);               % Puissance du signal
Pb = Px * 10 ^ (-SNR / 10);         % Puissance du bruit
bruit = sqrt(Pb) * randn(1,N*Ns);   % Génération d'un bruit blanc gaussien     
x_bruitee = x + bruit;              % Signal modulé et bruité

%% Démodulation par filtrage %%

Fe = 48000;                              % Fréquence d'échantillonnage 
Ord = 61;                               % Ordre du filtre
Nbr_Echant_Retard = (Ord - 1) / 2;       % Nombre d'échantillons en retard dû à l'ordre du filtre   

% Synthèse du filtre passe-bas
x_bruitee = x + bruit;

% On utilise un filtre passe-bas idéal de fréquence de coupure F0
b_bas = (2 * Fc/Fe) * sinc(2 * (Fc/Fe) * (-(Ord-1)/2:1:(Ord-1)/2) ); 
x_bruitee_decaler = [x_bruitee , zeros(1, Nbr_Echant_Retard)];       % Décalage du signal modulé pour ne pas garder les zéros
y_bas = filter(b_bas, 1, x_bruitee_decaler);                         % Signal en sortie du filtre passe bas nommé y_bas
y_bas = y_bas(1, Nbr_Echant_Retard+1:end);                           % On ne garde que les valeurs non nuls   

% Decommenter ce qui suit pour voir le problème d'ordre du filtre 
%y_bas = filter(b_bas, 1, x_bruitee);

% Synthèse du filtre passe-haut
dirac1 = zeros(1,Ord);
dirac1((Ord-1)/2 + 1 ) = 1;
b_haut =  dirac1 - b_bas;
y_haut = filter(b_haut, 1, x_bruitee_decaler);  
y_haut = y_haut(1, Nbr_Echant_Retard+1:end);


% 5.4 Tracés à réaliser 

%5.4.1

% Affichage de la réponse impulsionnelle du filtre PB
figure(2)
subplot(2,2,1)
plot((-(Ord-1)/2:1:(Ord-1)/2),b_bas)
title('Réponse impulsionnelle du filtre passe-bas')
xlabel('Temps en s');
ylabel('hPB(t)');

% Affichage de la réponse en fréquence du filtre PB
figure(2)
subplot(2,2,2)
plot((-(Ord-1)/2:1:(Ord-1)/2),abs(fftshift (fft(b_bas)) ) )
title('Réponse en fréquence du filtre passe-bas')
xlabel('Frequence en Hz');
ylabel('HPB(f)');

% Affichage de la réponse impulsionnelle du filtre PH
figure(2)
subplot(2,2,3)
plot((-(Ord-1)/2:1:(Ord-1)/2),b_haut)
title('Réponse impulsionnelle du filtre passe-haut')
xlabel('Temps en s');
ylabel('hPH(t)');

% Affichage de la réponse impulsionnelle du filtre PH
figure(2)
subplot(2,2,4)
plot((-(Ord-1)/2:1:(Ord-1)/2),abs(fftshift (fft(b_haut)) ) )
title('Réponse en fréquence du filtre passe-haut')
xlabel('Frequence en Hz');
ylabel('HPH(f)');

%5.4.2
figure(3)
subplot(1,2,1)
semilogy(frequence, DSP_estime_X)
title('Filtre passe-bas & DSP du signal X')
hold on 
semilogy(frequence,abs( (fft(b_bas,length(DSP_estime_X))) ) )
hold off
legend('Réponse fréquentille du PB','DSP de x')

subplot(1,2,2)
semilogy(frequence, DSP_estime_X)
title('Filtre passe-haut & DSP du signal X')
hold on 
semilogy(frequence,abs( (fft(b_haut, length(DSP_estime_X))) ) )
hold off
legend('Réponse fréquentille du PH','DSP de x')

%5.4.3

% Affichage du signal en sortie du filtre passe-bas
figure(4)
subplot(2,2,1)
plot(temps, y_bas)
title('Signal en sortie du filtre passe-bas')
xlabel('Temps en s');
ylabel('ypb(t)');

% Affichage du signal en sortie de la DSP du signal filtré par un passe-bas
DSP_y_bas = pwelch(y_bas, [], [], [], 1/Te, 'twosided');
subplot(2,2,2)
plot(frequence, DSP_y_bas)
title('DSP du signal filtré par un passe-bas')
xlabel('Frequence en Hz');
ylabel('YPB(f)');

% Affichage du signal en sortie du filtre passe-haut
subplot(2,2,3)
plot(temps, y_haut)
title('Signal en sortie du filtre passe-haut')
xlabel('Temps en s');
ylabel('ypb(t)');

% Affichage du signal en sortie de la DSP du signal filtré par un
% passe-haut
DSP_y_haut = pwelch(y_haut, [], [], [], 1/Te, 'twosided');
subplot(2,2,4)
plot(frequence, DSP_y_haut)
title('DSP du signal filtré par un passe-haut')
xlabel('Frequence en Hz');
ylabel('YPB(f)');


%5.5.1

% Calcul de l'energie sur les differentes periodes
somme_energie_bas = sum(reshape(y_bas, Ns, N)'.^2,2);
% Determination de K
K_bas = mean(somme_energie_bas);
% Determination des bits suivant la regle erigee
bits_reconstitues_bas = somme_energie_bas > K_bas;

%5.5.2

% Taux d'erreur binaire
Erreur_Filtre_Bas = 1 - sum(bits_reconstitues_bas' == Signal_Binaire) / N

%5.6.1

%Si on augmente l'ordre des filtres il y a du retard donc des erreur de
%demodulation
%On décale le signal de (Ord-1)/2 échantillons.

%5.6.2

%Avec F0 = 1180Hz et F1 = 980Hz sans bruit, on retrouve un taux d'erreur
%binaire non nul. Il faut un démoduleur plus performant vu que les
%fréquences sont trop proches pour pouvoir être sélectionné pa avec un filtre.
%Pour pouvoir le tester, veuillez modifier Fc = 1080 et DeltaF = 100