package code;

import javax.swing.*;
import javax.swing.border.EmptyBorder;

import java.awt.*;
import java.awt.event.*;

public class MenuJouer implements InterfaceMenu {

	JFrame fenetre = new JFrame();
	JButton boutonRetour = new JButton("Retour");
	JButton boutonHumain = new JButton("Humain");
	JButton boutonOrdinateur = new JButton("Ordinateur");

	public MenuJouer() {

		// Conteneur de la fenêtre du MenuJouer
		fenetre.setTitle("Jeu d'échecs");
		Container contenu = this.fenetre.getContentPane();
		contenu.setLayout(new BorderLayout());

		// Consigne pour l'utilisateur, affichage noir sur blanc, bordure noire
		JPanel paneltitre = new JPanel();
		paneltitre.setLayout(new FlowLayout(FlowLayout.CENTER));
		JLabel titre = new JLabel("Veuillez sélectionner votre adversaire");
		Font policeTitre = new Font("Arial", 0, 20);
		titre.setFont(policeTitre);
		titre.setBackground(blanc);
		ImageIcon iconeLogo = new ImageIcon(new ImageIcon(getClass().getResource("images/Cavalier_N.png")).getImage()
				.getScaledInstance(40, 40, Image.SCALE_SMOOTH));
		titre.setIcon(iconeLogo);
		paneltitre.add(titre);
		paneltitre.setBackground(blanc);
		paneltitre.setBorder(new EmptyBorder(new Insets(150, 200, 150, 200)));
		contenu.add(paneltitre, BorderLayout.NORTH);
		contenu.add(Box.createVerticalStrut(20));

		// Boîte contenant tous les choix disponibles pour l'utilisateur
		JPanel choix = new JPanel();
		choix.setLayout(new BoxLayout(choix, BoxLayout.Y_AXIS));
		choix.setBackground(blanc);

		// Choix disponibles à l'utilisateur, affichage noir sur blanc, bordure noire

		// Choix humain, l'utilisateur va à ChoixHumain
		JPanel caseHumain = new JPanel();
		caseHumain.add(this.boutonHumain);
		caseHumain.setBackground(blanc);
		boutonHumain.setPreferredSize(DimensionBouton);
		boutonHumain.setBackground(blanc);
		boutonHumain.setBorder(BordureNoire);
		boutonHumain.addActionListener(new ActionHumain());

		// Choix ordinateur, l'utilisateur va à NiveauOrdi
		JPanel caseOrdi = new JPanel();
		caseOrdi.add(this.boutonOrdinateur);
		caseOrdi.setBackground(blanc);
		boutonOrdinateur.setPreferredSize(DimensionBouton);
		boutonOrdinateur.setBackground(blanc);
		boutonOrdinateur.setBorder(BordureNoire);
		boutonOrdinateur.addActionListener(new ActionOrdi());

		// Choix retour, l'utilisateur retourne au Menu
		JPanel caseQuitter = new JPanel();
		caseQuitter.add(this.boutonRetour);
		caseQuitter.setBackground(blanc);
		boutonRetour.setPreferredSize(DimensionBouton);
		boutonRetour.setBackground(blanc);
		boutonRetour.setBorder(BordureNoire);
		boutonRetour.addActionListener(new ActionRetour());

		// Organisation du centre de la fenêtre avec les options de jeu : humain ou IA
		JPanel options = new JPanel();
		options.setLayout(new BoxLayout(options, BoxLayout.X_AXIS));
		options.add(caseHumain);
		options.add(Box.createHorizontalStrut(20));
		options.add(caseOrdi);
		options.setBackground(blanc);

		// Organisation du bas de fenêtre : retour au Menu
		choix.add(options);
		choix.add(Box.createVerticalStrut(20));
		choix.add(caseQuitter);

		// Ajout de l'ensemble de la boîte au contenu de la fenêtre
		contenu.add(choix, BorderLayout.CENTER);

		// Paramètres d'affichage de la fenêtre
		this.fenetre.setPreferredSize(dimensionFenetre);
		this.fenetre.setLocation(x, y);
		this.fenetre.pack();
		this.fenetre.setVisible(true);

	}

	class ActionRetour implements ActionListener {
		public void actionPerformed(ActionEvent quitter) {
			fenetre.dispose();
			new Menu();
		}
	}

	class ActionHumain implements ActionListener {
		public void actionPerformed(ActionEvent quitter) {
			new ChoixHumain(0, 0, 0);
			fenetre.dispose();
		}
	}

	class ActionOrdi implements ActionListener {
		public void actionPerformed(ActionEvent quitter) {
			new NiveauOrdi();
			fenetre.dispose();
		}
	}
}
