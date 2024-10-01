package code;

import javax.swing.*;
import javax.swing.border.EmptyBorder;

import java.awt.*;

import java.awt.event.*;

public class NiveauOrdi implements InterfaceMenu {

	JFrame fenetre = new JFrame();
	JButton boutonRetour = new JButton("Retour");
	JButton boutonFacile = new JButton("Facile");
	JButton boutonMoyen = new JButton("Moyen");
	JButton boutonDifficile = new JButton("Difficile");
	JButton boutonCouleur = new JButton("Couleur de l'IA: noir");

	public static int couleurIA = 1;

	public NiveauOrdi() {

		// Conteneur de la fenêtre du NiveauOrdi
		fenetre.setTitle("Jeu d'échecs");
		Container contenu = this.fenetre.getContentPane();
		contenu.setLayout(new BorderLayout());

		// Consigne pour l'utilisateur, affichage noir sur blanc, bordure noire
		JPanel paneltitre = new JPanel();
		paneltitre.setLayout(new FlowLayout(FlowLayout.CENTER));
		JLabel titre = new JLabel("Veuillez sélectionner le niveau de votre adversaire");
		Font policeTitre = new Font("Arial", 0, 20);
		titre.setFont(policeTitre);
		titre.setBackground(blanc);
		ImageIcon iconeLogo = new ImageIcon(new ImageIcon(getClass().getResource("images/Cavalier_N.png")).getImage().getScaledInstance(40, 40, Image.SCALE_SMOOTH));
		titre.setIcon(iconeLogo);
		paneltitre.setBorder(new EmptyBorder(new Insets(150, 200, 150, 200)));
		paneltitre.add(titre);
		paneltitre.setBackground(blanc);

		// Boîte contenant tous les choix disponibles pour l'utilisateur
		JPanel choix = new JPanel();
		choix.setLayout(new BoxLayout(choix, BoxLayout.Y_AXIS));
		choix.setBackground(blanc);
		choix.add(paneltitre);
	

		// Choix disponibles à l'utilisateur, affichage noir sur blanc, bordure noire

		// Choix facile, l'utilisateur lance App avec une IA de niveau facile
		JPanel caseFacile = new JPanel();
		caseFacile.add(boutonFacile);
		caseFacile.setBackground(blanc);
		boutonFacile.setPreferredSize(DimensionBouton);
		boutonFacile.setBackground(blanc);
		boutonFacile.setBorder(BordureNoire);
		boutonFacile.addActionListener(new ActionFacile());

		// Choix moyen, l'utilisateur lance App avec une IA de niveau moyen
		JPanel caseMoyen = new JPanel();
		caseMoyen.add(boutonMoyen);
		caseMoyen.setBackground(blanc);
		boutonMoyen.setPreferredSize(DimensionBouton);
		boutonMoyen.setBackground(blanc);
		boutonMoyen.setBorder(BordureNoire);
		boutonMoyen.addActionListener(new ActionMoyen());

		// Choix difficile, l'utilisateur lance App avec une IA de niveau difficile
		JPanel caseDifficile = new JPanel();
		caseDifficile.add(boutonDifficile);
		caseDifficile.setBackground(blanc);
		boutonDifficile.setPreferredSize(DimensionBouton);
		boutonDifficile.setBackground(blanc);
		boutonDifficile.setBorder(BordureNoire);
		boutonDifficile.addActionListener(new ActionDifficile());

		// Choix Couleur, l'utilisateur choisi la couleur de l'IA
		JPanel caseCouleur = new JPanel();
		caseCouleur.setBackground(blanc);
		caseCouleur.add(boutonCouleur);
		boutonCouleur.setPreferredSize(DimensionBouton);
		boutonCouleur.setBackground(blanc);
		boutonCouleur.setBorder(BordureNoire);
		boutonCouleur.addActionListener(new ActionCouleur());

		// Choix retour, l'utilisateur retourne au MenuJouer
		JPanel caseRetour = new JPanel();
		caseRetour.add(this.boutonRetour);
		caseRetour.setBackground(blanc);
		boutonRetour.setPreferredSize(DimensionBouton);
		boutonRetour.setBackground(blanc);
		boutonRetour.setBorder(BordureNoire);
		boutonRetour.addActionListener(new ActionRetour());

		// Organisation du centre de la fenêtre avec les options de jeu : facile, moyen,
		// difficile et choix couleur
		JPanel options = new JPanel();
		options.setBackground(blanc);
		options.setLayout(new BoxLayout(options, BoxLayout.X_AXIS));
		options.add(caseFacile);
		//options.add(Box.createHorizontalStrut(20));
		options.add(caseMoyen);
		//options.add(Box.createHorizontalStrut(20));
		options.add(caseDifficile);
		options.setBackground(blanc);

		// Organisation générale de la fenêtre
		choix.add(options);
		choix.add(caseCouleur);
		choix.add(Box.createVerticalStrut(20));
		choix.add(caseRetour);

		// Ajout de l'ensemble de la boîte au contenu de la fenêtre
		contenu.add(choix, BorderLayout.CENTER);

		// Paramètres d'affichage de la fenêtre
		this.fenetre.setPreferredSize(dimensionFenetre);
		this.fenetre.setLocation(x, y);
		this.fenetre.setVisible(true);
		this.fenetre.pack();
	}

	class ActionRetour implements ActionListener {
		public void actionPerformed(ActionEvent retour) {
			new MenuJouer();
			fenetre.dispose();
		}
	}

	class ActionCouleur implements ActionListener {
		public void actionPerformed(ActionEvent retour) {

			couleurIA = couleurIA == 0 ? 1 : 0;
			String couleur = couleurIA == 0 ? "blanc" : "noir";
			boutonCouleur.setText("Couleur de l'IA: " + couleur);
		}
	}

	class ActionFacile implements ActionListener {
		public void actionPerformed(ActionEvent quitter) {
			if (couleurIA == 1) {
				new ChoixHumain(0, 1, 0);
			} else {
				new ChoixHumain(1, 0, 0);
			}
		}
	}

	class ActionMoyen implements ActionListener {
		public void actionPerformed(ActionEvent quitter) {
			if (couleurIA == 1) {
				new ChoixHumain(0, 1, 1);
			} else {
				new ChoixHumain(1, 0, 1);
			}
		}
	}

	class ActionDifficile implements ActionListener {
		public void actionPerformed(ActionEvent quitter) {
			if (couleurIA == 1) {
				new ChoixHumain(0, 1, 2);
			} else {
				new ChoixHumain(1, 0, 2);
			}
		}
	}
}
