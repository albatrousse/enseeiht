clear;
close all;
clc;

% Parametres pour l'affichage des donnees :
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

load donnees_train_3caracteristiques;

% Donnees non filtrees :
X = X_train;
Y = Y_train;

% Parametres d'affichage :
pas = 0.002;
marge = 0.005;
valeurs_carac_1 = min(min(X(:,1)))-marge:pas:max(max(X(:,1)))+marge;
valeurs_carac_2 = min(min(X(:,2)))-marge:pas:max(max(X(:,2)))+marge;
valeurs_carac_3 = min(min(X(:,3)))-marge:pas:max(max(X(:,3)))+marge;
limites_affichage = [valeurs_carac_1(1) valeurs_carac_1(end) ...
                     valeurs_carac_2(1) valeurs_carac_2(end) ...
                     valeurs_carac_3(1) valeurs_carac_3(end)];
nom_carac_1 = 'Compacite';
nom_carac_2 = 'Contraste';
nom_carac_3 = 'Texture';

% Estimation du SVM avec noyau gaussien :
matrice_pourcentages = [];
inter_sigma = 0.0025:0.0025:0.9;
inter_lambda = 100:50:1000;

for lambda = inter_lambda

    pourcentages = [];
    for sigma = inter_sigma                              % start boucle


    [X_VS,Y_VS,Alpha_VS,c,code_retour] = SVM_3_souple(X,Y,sigma,lambda);
    
    % Si l'optimisation n'a pas converge :
    if code_retour ~= 1
	    return;
    end
    
    % Regle de decision du SVM :
    nb_1 = length(valeurs_carac_1);
    nb_2 = length(valeurs_carac_2);
    nb_3 = length(valeurs_carac_3);
    SVM_predict = zeros(nb_3,nb_2,nb_1);
    for i = 1:nb_1
	    for j = 1:nb_2
            for k = 1:nb_3
		        x_ijk = [valeurs_carac_1(i) ; valeurs_carac_2(j) ; valeurs_carac_3(k)];
		        SVM_predict(k,j,i) = sign(exp(-sum((X_VS-x_ijk').^2,2)/(2*sigma^2))'*diag(Y_VS)*Alpha_VS-c);
            end
	    end
    end

    % Pourcentage de bonnes classifications des donnees de test :
    load donnees_test_3caracteristiques;
    nb_donnees_test = size(X_test,1);
    nb_classif_OK = 0;
    for i = 1:nb_donnees_test
	    x_i = X_test(i,:);
	    prediction = sign(exp(-sum((X_VS-x_i).^2,2)/(2*sigma^2))'*diag(Y_VS)*Alpha_VS-c);
	    if prediction==Y_test(i)
		    nb_classif_OK = nb_classif_OK+1;
	    end
    end
    pourcentage = nb_classif_OK/nb_donnees_test*100;
    pourcentages = [pourcentages, double(pourcentage)];

    end % boucle sigma

matrice_pourcentages = [matrice_pourcentages; pourcentages];
end % boucle lambda


figure
s = surf(inter_sigma, inter_lambda, matrice_pourcentages);
s.EdgeColor = 'none';
colorbar
colormap winter;
title("Pourcentage de bonne classifications en fonction de sigma")
xlabel("Sigma");
ylabel("Lambda");
zlabel("Pourcentage de bonne classifications des donnes de test");                  
