package code;
import javax.swing.*;
import javax.swing.border.EmptyBorder;

import java.awt.*;
import java.awt.event.*;


public class ChoixHumain implements InterfaceMenu {
	
	public static int joueur1;
	public static int joueur2;
	public static int niveauIA;
	
	JFrame fenetre = new JFrame();
	JButton boutonRetour = new JButton("Retour");
	JButton boutonNormal = new JButton("Commencer une nouvelle partie");
	JButton boutonReprise = new JButton("Reprendre une partie en cours");
	
	
	public ChoixHumain(int joueurUN, int joueurDEUX, int niveauORDI){
		
		// Mise à jour des caractéristiques des joueurs
		joueur1 = joueurUN;
		joueur2 = joueurDEUX;
		niveauIA  = niveauORDI;
		
		// Conteneur de la fenêtre de ChoixHumain
		fenetre.setTitle("Jeu d'échecs");
		Container contenu = this.fenetre.getContentPane();
		contenu.setLayout(new BorderLayout());
		
		// Consigne pour l'utilisateur, affichage noir sur blanc, bordure noire
		JPanel paneltitre = new JPanel();
		paneltitre.setLayout(new FlowLayout(FlowLayout.CENTER));
		JLabel titre = new JLabel("Veuillez sélectionner le type de jeu souhaité");
		Font policeTitre = new Font("Arial", 0, 20);
		titre.setFont(policeTitre);
		titre.setBackground(blanc);
		ImageIcon iconeLogo = new ImageIcon(new ImageIcon(getClass().getResource("images/Cavalier_N.png")).getImage().getScaledInstance(40, 40, Image.SCALE_SMOOTH));
		titre.setIcon(iconeLogo);
		paneltitre.add(titre);
		paneltitre.setBackground(blanc);
		paneltitre.setBorder(new EmptyBorder(new Insets(150, 200, 10, 200)));
		
		// Organisation générale de la fenêtre
		JPanel choix = new JPanel();
		choix.setLayout(new BoxLayout(choix, BoxLayout.Y_AXIS));
		choix.setBackground(blanc);
		choix.add(paneltitre);
		
		
		// Choix disponibles à l'utilisateur, affichage noir sur blanc, bordure noire
		Dimension DimensionBouton = new Dimension(largeur_bouton+50, hauteur_bouton);
		
		// Option de jeu normal
		JPanel caseHumainNormal = new JPanel();
		caseHumainNormal.setBackground(blanc);
		caseHumainNormal.add(this.boutonNormal);
		boutonNormal.setPreferredSize(DimensionBouton);
		boutonNormal.setBackground(blanc);
		boutonNormal.setBorder(BordureNoire);
		boutonNormal.addActionListener(new ActionNormal());
		
		// Option de jeu reprise
		JPanel caseReprise = new JPanel();
		caseReprise.setBackground(blanc);
		caseReprise.add(this.boutonReprise);
		boutonReprise.setPreferredSize(DimensionBouton);
		boutonReprise.setBackground(blanc);
		boutonReprise.setBorder(BordureNoire);
		boutonReprise.addActionListener(new ActionReprise());
		
		// Retour au menu MenuJouer
		JPanel caseRetour = new JPanel();
		caseRetour.setBackground(blanc);
		caseRetour.add(this.boutonRetour);
		boutonRetour.setPreferredSize(DimensionBouton);
		boutonRetour.setBackground(blanc);
		boutonRetour.setBorder(BordureNoire);
		boutonRetour.addActionListener(new ActionRetour());
		
		
		// Boîte des options de jeu disponibles à l'utilisateur
		JPanel options = new JPanel();
		options.setLayout(new BoxLayout(options, BoxLayout.X_AXIS));
		options.add(caseHumainNormal);
		options.add(Box.createHorizontalStrut(20));
		options.add(caseReprise);
		options.setBackground(blanc);
		
		// Construction de la fenêtre
		choix.add(options);
		choix.add(Box.createVerticalStrut(20));
		choix.add(caseRetour);
		
		// Ajout des composants à la fenêtre
		contenu.add(choix, BorderLayout.CENTER);
		
		this.fenetre.setPreferredSize(dimensionFenetre);
		this.fenetre.setLocation(x,y);
		this.fenetre.pack();
		this.fenetre.setVisible(true);
		
	}
	
	class ActionRetour implements ActionListener {
		public void actionPerformed(ActionEvent retour) {
			new MenuJouer();
			fenetre.dispose();
		}
	}
	
	class ActionNormal implements ActionListener {
		public void actionPerformed(ActionEvent normal) {
			try {
				new App(joueur1, joueur2, niveauIA, Menu.chrono, Menu.coms);
				fenetre.dispose();
			} catch (CodeIncorrectException CIE) {
    	}

		}
	}
	
	class ActionReprise implements ActionListener {
		public void actionPerformed(ActionEvent reprise) {
			new CodeJeu(joueur1,joueur2,niveauIA);
			fenetre.dispose();
		}
	}

}
