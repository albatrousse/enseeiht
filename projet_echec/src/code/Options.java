package code;

import java.awt.*;
import java.awt.event.*;

import javax.swing.*;
import javax.swing.border.EmptyBorder;

public class Options implements InterfaceMenu {

	private boolean chrono;
	private boolean coms;

	JFrame fenetre = new JFrame();
	JButton boutonRetour = new JButton("Retour");

	public Options(boolean chrono, boolean coms) {

		// Mise à jour des options à partir des variables courantes du Menu
		this.chrono = chrono;
		this.coms = coms;

		// Conteneur de la fenêtre de Options
		fenetre.setTitle("Jeu d'échecs");
		Container contenu = this.fenetre.getContentPane();
		contenu.setLayout(new BorderLayout());

		// Consigne pour l'utilisateur, affichage noir sur blanc, bordure noire
		JPanel paneltitre = new JPanel();
		paneltitre.setLayout(new FlowLayout(FlowLayout.CENTER));
		JLabel titre = new JLabel("Veuillez sélectionner vos options");
		Font policeTitre = new Font("Arial", 0, 20);
		titre.setFont(policeTitre);
		titre.setBackground(blanc);
		ImageIcon iconeLogo = new ImageIcon(new ImageIcon(getClass().getResource("images/Cavalier_N.png")).getImage().getScaledInstance(40, 40, Image.SCALE_SMOOTH));
		titre.setIcon(iconeLogo);
		paneltitre.setBorder(new EmptyBorder(new Insets(150, 200, 10, 200)));
		paneltitre.add(titre);
		paneltitre.setBackground(blanc);

		// Organisation générale de la fenêtre
		JPanel options = new JPanel();
		options.setLayout(new BoxLayout(options, BoxLayout.Y_AXIS));
		options.setBackground(blanc);
		options.add(paneltitre);
		JPanel options1 = new JPanel();
		options1.setLayout(new BoxLayout(options1, BoxLayout.X_AXIS));
		options1.setBackground(blanc);
		options.add(options1);
		JPanel options2 = new JPanel();
		options2.setLayout(new BoxLayout(options2, BoxLayout.X_AXIS));
		options1.setBackground(blanc);
		options.add(options2);
		options.add(Box.createVerticalStrut(20));
		JPanel panelLabelCom = new JPanel();
		panelLabelCom.setBackground(blanc);
		JPanel panelLabelChrono = new JPanel();
		panelLabelChrono.setBackground(blanc);
		JPanel panelButtonCom = new JPanel();
		panelButtonCom.setBackground(blanc);
		JPanel panelButtonChrono = new JPanel();
		panelButtonChrono.setBackground(blanc);
		options1.add(panelLabelChrono);
		options1.add(panelButtonChrono);
		options2.add(panelLabelCom);
		options2.add(panelButtonCom);

		// Choix disponibles à l'utilisateur, affichage noir sur blanc, bordure noire

		// Choix du chronomètre
		JButton bChrono = new JButton("OFF");
		bChrono.setPreferredSize(DimensionBouton);
		bChrono.setBackground(blanc);
		bChrono.setBorder(BordureNoire);
		bChrono.addActionListener(new ActionChrono());
		JButton bChrono2 = new JButton("ON");
		bChrono2.setPreferredSize(DimensionBouton);
		bChrono2.setBackground(blanc);
		bChrono2.setBorder(BordureNoire);
		bChrono2.addActionListener(new ActionChrono());
		JLabel tChrono = new JLabel("Chronomètre : ");
		panelLabelChrono.add(tChrono);
		tChrono.setBackground(blanc);
		if (!this.chrono) {
			panelButtonChrono.add(bChrono);
		} else {
			panelButtonChrono.add(bChrono2);
		}

		// Choix des commentaires
		JButton bComs = new JButton("OFF");
		bComs.setPreferredSize(DimensionBouton);
		bComs.setBackground(blanc);
		bComs.setBorder(BordureNoire);
		bComs.addActionListener(new ActionComs());
		JButton bComs2 = new JButton("ON");
		bComs2.setPreferredSize(DimensionBouton);
		bComs2.setBackground(blanc);
		bComs2.setBorder(BordureNoire);
		bComs2.addActionListener(new ActionComs());
		JLabel tComs = new JLabel("Commentaires : ");
		panelLabelCom.add(tComs);
		tComs.setBackground(blanc);
		if (!this.coms) {
			panelButtonCom.add(bComs);
		} else {
			panelButtonCom.add(bComs2);
		}

		// Organisation du bas de fenêtre : retour au Menu
		JPanel caseQuitter = new JPanel();
		boutonRetour.setPreferredSize(DimensionBouton);
		boutonRetour.setBackground(blanc);
		boutonRetour.setBorder(BordureNoire);
		boutonRetour.addActionListener(new ActionRetour());
		boutonRetour.setAlignmentX(Component.CENTER_ALIGNMENT);
		caseQuitter.setBackground(blanc);
		caseQuitter.add(this.boutonRetour);
		options.add(caseQuitter);

		// Ajout de l'ensemble de la boîte au contenu de la fenêtre
		contenu.add(options, BorderLayout.CENTER);

		// Paramètres d'affichage de la fenêtre
		this.fenetre.setPreferredSize(dimensionFenetre);
		this.fenetre.setLocation(x, y);
		this.fenetre.setVisible(true);
		this.fenetre.pack();

	}

	class ActionRetour implements ActionListener {
		public void actionPerformed(ActionEvent quitter) {
			new Menu(chrono, coms);
			fenetre.dispose();
		}
	}

	class ActionChrono implements ActionListener {
		public void actionPerformed(ActionEvent chronom) {
			chrono = !chrono;
			new Options(chrono, coms);
			fenetre.dispose();
		}
	}

	class ActionComs implements ActionListener {
		public void actionPerformed(ActionEvent comms) {
			coms = !coms;
			new Options(chrono, coms);
			fenetre.dispose();
		}
	}

}
