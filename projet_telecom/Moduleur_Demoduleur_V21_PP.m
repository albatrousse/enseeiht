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

% Démodulation par intégration avec gestion d'erreur de synchronisation de
% la phase porteuse

theta_0 = rand*2*pi; % Desynchronisation de phase avec la porteuse
% On definit d'abord les termes a sommer pour plus de lisibilite
x_cos_0 = x_bruitee .* cos(2 * pi * F0 * temps + theta_0);
x_sin_0 = x_bruitee .* sin(2 * pi * F0 * temps + theta_0);

% Calcul de la somme des integrales du haut
sum_x_0 = 1/Ns*sum(reshape(x_cos_0,Ns,N)).^2 + 1/Ns*sum(reshape(x_sin_0,Ns,N)).^2;

theta_1 = rand*2*pi; % Desynchronisation de phase avec la porteuse
% On definit d'abord les termes a sommer pour plus de lisibilite
x_cos_1 = x_bruitee .* cos(2 * pi * F1 * temps + theta_1);
x_sin_1 = x_bruitee .* sin(2 * pi * F1 * temps + theta_1);

% Calcul de la somme des integrales du bas
sum_x_1 = 1/Ns * sum(reshape(x_cos_1,Ns,N)).^2 + 1/Ns * sum(reshape(x_sin_1,Ns,N)).^2;

% On calcul la difference des sommes d'integrales
diff_sum = sum_x_1' - sum_x_0';
% On reconstruit le signal binaire
bit_reconstruit_V21 = diff_sum > 0;
% Taux d'erreur binaire
Erreur_FSK_2 = 1 - sum(bit_reconstruit_V21' == Signal_Binaire,2)/N

%% Reconstitution des images %% 
% On applique la méthode de demodulation précédente à chaque fichieri.mat
% pour i allant de 1 à 6.

%% fichier1.mat %%
load fichier1.mat            % On importe l'image 1

N = length(signal);          % On recupere la taille du signal de l'image
temps_image = 0:Te:(N-1)*Te; % On redefinit l'intervalle de temps par rapport a la taille de l'image

% On definit d'abord les termes a sommer pour plus de lisibilite 
x_cos_0 = signal .* cos(2 * pi * F0 * temps_image + theta_0);
x_sin_0 = signal .* sin(2 * pi * F0 * temps_image + theta_0);
sum_x_cos_0 = 1/Ns * sum( reshape(x_cos_0,Ns,[])).^2;
sum_x_sin_0 = 1/Ns * sum( reshape(x_sin_0,Ns,[])).^2;

% Calcul de la somme des integrales hauts
sum_x_0 = sum_x_cos_0 + sum_x_sin_0;

% On definit d'abord les termes a sommer pour plus de lisibilite 
x_cos_1 = signal .* cos(2 * pi * F1 * temps_image + theta_1);
x_sin_1 = signal .* sin(2 * pi * F1 * temps_image + theta_1);
sum_x_cos_1 = 1/Ns * sum( reshape(x_cos_1,Ns,[])).^2;
sum_x_sin_1 = 1/Ns * sum( reshape(x_sin_1,Ns,[])).^2;

% Calcul de la somme des integrales hauts
sum_x_1 = sum_x_cos_1 + sum_x_sin_1;

% On calcul la difference des sommes d'integrales
diff_sum = sum_x_1 - sum_x_0;
% On reconstruit le signal binaire
bit_reconstruit_image1 = diff_sum > 0;
image1 = reconstitution_image(bit_reconstruit_image1); % Fonction pour reconstruire l'image a partir du signal

%% fichier2.mat %%
load fichier2.mat

N = length(signal);
temps_image = 0:Te:(N-1)*Te;

x_cos_0 = signal .* cos(2 * pi * F0 * temps_image + theta_0);
x_sin_0 = signal .* sin(2 * pi * F0 * temps_image + theta_0);
sum_x_cos_0 = 1/Ns * sum( reshape(x_cos_0,Ns,[])).^2;
sum_x_sin_0 = 1/Ns * sum( reshape(x_sin_0,Ns,[])).^2;
sum_x_0 = sum_x_cos_0 + sum_x_sin_0;

x_cos_1 = signal .* cos(2 * pi * F1 * temps_image + theta_1);
x_sin_1 = signal .* sin(2 * pi * F1 * temps_image + theta_1);
sum_x_cos_1 = 1/Ns * sum( reshape(x_cos_1,Ns,[])).^2;
sum_x_sin_1 = 1/Ns * sum( reshape(x_sin_1,Ns,[])).^2;
sum_x_1 = sum_x_cos_1 + sum_x_sin_1;

diff_sum = sum_x_1 - sum_x_0;
bit_reconstruit_image2 = diff_sum > 0;
image2 = reconstitution_image(bit_reconstruit_image2);

%% fichier3.mat %%
load fichier3.mat

N = length(signal);
temps_image = 0:Te:(N-1)*Te;

x_cos_0 = signal .* cos(2 * pi * F0 * temps_image + theta_0);
x_sin_0 = signal .* sin(2 * pi * F0 * temps_image + theta_0);
sum_x_cos_0 = 1/Ns * sum( reshape(x_cos_0,Ns,[])).^2;
sum_x_sin_0 = 1/Ns * sum( reshape(x_sin_0,Ns,[])).^2;
sum_x_0 = sum_x_cos_0 + sum_x_sin_0;

x_cos_1 = signal .* cos(2 * pi * F1 * temps_image + theta_1);
x_sin_1 = signal .* sin(2 * pi * F1 * temps_image + theta_1);
sum_x_cos_1 = 1/Ns * sum( reshape(x_cos_1,Ns,[])).^2;
sum_x_sin_1 = 1/Ns * sum( reshape(x_sin_1,Ns,[])).^2;
sum_x_1 = sum_x_cos_1 + sum_x_sin_1;

diff_sum = sum_x_1 - sum_x_0;
bit_reconstruit_image3 = diff_sum > 0;
image3 = reconstitution_image(bit_reconstruit_image3);

%% fichier4.mat %%
load fichier4.mat

N = length(signal);
temps_image = 0:Te:(N-1)*Te;

x_cos_0 = signal .* cos(2 * pi * F0 * temps_image + theta_0);
x_sin_0 = signal .* sin(2 * pi * F0 * temps_image + theta_0);
sum_x_cos_0 = 1/Ns * sum( reshape(x_cos_0,Ns,[])).^2;
sum_x_sin_0 = 1/Ns * sum( reshape(x_sin_0,Ns,[])).^2;
sum_x_0 = sum_x_cos_0 + sum_x_sin_0;

x_cos_1 = signal .* cos(2 * pi * F1 * temps_image + theta_1);
x_sin_1 = signal .* sin(2 * pi * F1 * temps_image + theta_1);
sum_x_cos_1 = 1/Ns * sum( reshape(x_cos_1,Ns,[])).^2;
sum_x_sin_1 = 1/Ns * sum( reshape(x_sin_1,Ns,[])).^2;
sum_x_1 = sum_x_cos_1 + sum_x_sin_1;

diff_sum = sum_x_1 - sum_x_0;
bit_reconstruit_image4 = diff_sum > 0;
image4 = reconstitution_image(bit_reconstruit_image4);

%% fichier5.mat %%
load fichier5.mat

N = length(signal);
temps_image = 0:Te:(N-1)*Te;

x_cos_0 = signal .* cos(2 * pi * F0 * temps_image + theta_0);
x_sin_0 = signal .* sin(2 * pi * F0 * temps_image + theta_0);
sum_x_cos_0 = 1/Ns * sum( reshape(x_cos_0,Ns,[])).^2;
sum_x_sin_0 = 1/Ns * sum( reshape(x_sin_0,Ns,[])).^2;
sum_x_0 = sum_x_cos_0 + sum_x_sin_0;

x_cos_1 = signal .* cos(2 * pi * F1 * temps_image + theta_1);
x_sin_1 = signal .* sin(2 * pi * F1 * temps_image + theta_1);
sum_x_cos_1 = 1/Ns * sum( reshape(x_cos_1,Ns,[])).^2;
sum_x_sin_1 = 1/Ns * sum( reshape(x_sin_1,Ns,[])).^2;
sum_x_1 = sum_x_cos_1 + sum_x_sin_1;

diff_sum = sum_x_1 - sum_x_0;
bit_reconstruit_image5 = diff_sum > 0;
image5 = reconstitution_image(bit_reconstruit_image5);

%% fichier6.mat %%
load fichier6.mat

N = length(signal);
temps_image = 0:Te:(N-1)*Te;

x_cos_0 = signal .* cos(2 * pi * F0 * temps_image + theta_0);
x_sin_0 = signal .* sin(2 * pi * F0 * temps_image + theta_0);
sum_x_cos_0 = 1/Ns * sum( reshape(x_cos_0,Ns,[])).^2;
sum_x_sin_0 = 1/Ns * sum( reshape(x_sin_0,Ns,[])).^2;
sum_x_0 = sum_x_cos_0 + sum_x_sin_0;

x_cos_1 = signal .* cos(2 * pi * F1 * temps_image + theta_1);
x_sin_1 = signal .* sin(2 * pi * F1 * temps_image + theta_1);
sum_x_cos_1 = 1/Ns * sum( reshape(x_cos_1,Ns,[])).^2;
sum_x_sin_1 = 1/Ns * sum( reshape(x_sin_1,Ns,[])).^2;
sum_x_1 = sum_x_cos_1 + sum_x_sin_1;

diff_sum = sum_x_1 - sum_x_0;
bit_reconstruit_image6 = diff_sum > 0;
image6 = reconstitution_image(bit_reconstruit_image6);

% On remet les images dans le bon ordre
image_entiere = [image6 image1 image5;
                 image2 image4 image3];
% On afficher l'image
image(image_entiere)