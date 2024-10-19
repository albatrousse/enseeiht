%% Modem V21 sans problème de synchronisation de la phase porteuse %%

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

NRZ = kron(Signal_Binaire, ones(1, Ns));    % Signal NRZ
temps = (0:N*Ns-1)*Te;                      % Intervalle de temps
frequence = linspace(0,Fe,taille);          % Intervalle de fréquence

% Création du signal modulé nommé x
Fc = 1080;                  % Fréquence de coupure
DeltaF = 100;               % Delta de fréquence
F0 = Fc + DeltaF;           % Fréquence pour le signal sinusoidal des 1 de NRZ
F1 = Fc - DeltaF;           % Fréquence pour le signal sinusoidal des 0 de NRZ
psi0 = rand*2*pi;           % Phase tiré aléatoirement pour le signal sinusoidal des 0 de NRZ
psi1 =  rand*2*pi;          % Phase tiré aléatoirement pour le signal sinusoidal des 1 de NRZ
x = (1-NRZ) .* cos(2*pi*F0*temps + psi0) + NRZ .* cos(2*pi*F1*temps + psi1); % Par définition

% Canal de transmission (ajout d'un bruit blanc et Gaussien)
SNR = 50;                           % Sound to Noise Ratio
Px = mean(abs(x).^2);               % Puissance du signal
Pb = Px * 10 ^ (-SNR / 10);         % Puissance du bruit
bruit = sqrt(Pb) * randn(1,N*Ns);   % Génération d'un bruit blanc gaussien     
x_bruitee = x + bruit;              % Signal modulé et bruité

%% Demodulation V21 %%

% On definit d'abord le terme a integrer pour plus de lisibilite
x_cos_0 = x_bruitee .* cos(2 * pi * F0 * temps + psi0);
x_cos_1 = x_bruitee .* cos(2 * pi * F1 * temps + psi1);

% On somme les echantillons par paquets de Ns echantillons
int_x_0 = sum(reshape(x_cos_0,Ns,N)) * 1/Ns;
int_x_1 = sum(reshape(x_cos_1,Ns,N)) * 1/Ns;

% On calcul la difference des integrales
diff_int = int_x_1 - int_x_0;

% On reconstruit le signal binaire
bit_reconstruit_V21 = diff_int > 0;

% Calcul du taux d'erreur binaire
Erreur_FSK_1 = 1 - sum(bit_reconstruit_V21 == Signal_Binaire) / N