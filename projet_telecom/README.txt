+-------------------------------------------------------------------------------------------------+
|									  			  |
|                             Comment utiliser les différents codes fournis 			  |
|								          			  |
+-------------------------------------------------------------------------------------------------+

Fichiers fournis :
------------------
	(1) - Moduleur_Demoduleur_Filtrage.m
	(2) - Moduleur_Demoduleur_V21.m
	(3) - Moduleur_Demoluleur_V21_PP.m
	(4) - Rapport_TDS_Wu_Malinge.pdf

Utilisation des fichiers : 
--------------------------

(1) - Fichier Matlab contenant le code pour créer une signal modulé et le démoduler à partir
d'un filtre passe bas et un passe-haut. 
Le fichier est par défaut dans les configurations suivantes : 

		N = 300 (Nombre de bits du signal émis), Fs = 300 (Débit binaire bits/s) 
				F0 = 6000 Hz, F1 = 2000 Hz, Fc = 4000 Hz
		Ord = 61 (Ordre des filtres) et SNR = 50 (Sound to Noise Ratio)

Pour les changer, il suffit simplement de les modifier sur les variables associées.
Il y a une ligne de code mis en commentaire à décommenté pour pouvoir voir l'effet du retard dû à
l'ordre du filtre.
Pour pouvoir afficher les différents graphiques voulus, il faut simplement lancer le code Matlab et
tous s'affichera directement sur les différentes figures. De plus, dans la console s'affichera le
taux d'erreur binaire nommé Erreur_Filtre_Bas.

(2) - Fichier Matlab contenant le code pour créer un signal modulé et le démoduler à partir
d'un démodulateur FSK pour une synchronisation supposée idéale dans la recommandation V21.
Le fichier est par défaut dans les configurations suivantes :
	
		N = 300 (Nombre de bits du signal émis), Fs = 300 (Débit binaire bits/s)
			F0 = 1180 Hz, F1 = 980 Hz et SNR = 50 (Sound to Noise Ratio)

Il faut simplement lancer le code Matlab dans la configuration voulue (en changeant les variables 
pertinentes) et le programme affichera dans la console le taux d'erreur binaire nommé 
Erreur_FSK_1.

(3) - Fichier Matlab contenant le code pour créer un signal modulé et le démoduler à partir
d'un démodulateur FSK qui gère les problèmes de synchronisation de phase porteuse dans 
la recommandation V21. Il contient aussi le code pour pouvoir démoduler les 6 signaux contenant
une image qu'il faut reconstituer.
Le fichier est par défaut dans les configurations suivantes :

		N = 300 (Nombre de bits du signal émis), Fs = 300 (Débit binaire bits/s)
			F0 = 1180 Hz, F1 = 980 Hz et SNR = 50 (Sound to Noise Ratio)

Il faut simplement lancer le code Matlab dans la configuration voulue (en changeant les variables 
pertinentes) et le programme affichera dans la console le taux d'erreur binaire nommé 
Erreur_FSK_2. De plus, il affichera sur une figure les 6 images reconstituées et placées dans 
le bon ordre. 

PS : Il faut avoir les fichiers fichieri.m pour i allant de 1 à 6 et la fonction matlab 
reconstitution_image dans le même dossier que Moduleur_Demoluleur_V21_PP.m

(4) - Fichier PDF contenant le rapport du projet. 

