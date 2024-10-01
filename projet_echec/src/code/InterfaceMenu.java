package code;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Toolkit;

import javax.swing.BorderFactory;
import javax.swing.border.Border;

public interface InterfaceMenu {
	
	// Adaptation à la taille de l'écran
	Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
	double largeur = screenSize.getWidth();
	double hauteur = screenSize.getHeight();
	int size = (int) (Math.sqrt(largeur * hauteur) / 1.5);
	final Dimension dimensionFenetre = new Dimension(size, size);
	final int x = (int) ((largeur - dimensionFenetre.getWidth()) / 2);
	final int y = (int) ((hauteur - dimensionFenetre.getHeight()) / 2);
	
	// Couleurs 
	Color blanc = Color.WHITE;
	Color noir = Color.BLACK;
	Border BordureNoire = BorderFactory.createLineBorder(noir,1);
	
	// Taille des boutons
	final int largeur_bouton = 150;
	final int hauteur_bouton = 25;
	Dimension DimensionBouton = new Dimension(largeur_bouton, hauteur_bouton);
	

}
