package code;

import javax.swing.*;
import java.awt.*;
import javax.swing.border.EmptyBorder;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.IOException;


public class Menu implements InterfaceMenu {
	
	public static boolean chrono;
	public static boolean coms;
	
	// La fenêtre
	private JFrame fenetre = new JFrame();

	public Menu() {
		
		// Fenêtre principale
		fenetre.setTitle("Jeu d'échecs");
		fenetre.setLocationRelativeTo(null);
		fenetre.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

		// Conteneur de la fenêtre principale
		Container conteneur = fenetre.getContentPane();
		BorderLayout borderLayout = new BorderLayout();
		conteneur.setLayout(borderLayout);

		// Définiton du PanelBouton
		JPanel panelBouton = new JPanel();
		BoxLayout boxLayout = new BoxLayout(panelBouton, BoxLayout.Y_AXIS);
		panelBouton.setLayout(boxLayout);
		panelBouton.setBorder(new EmptyBorder(new Insets(150, 200, 150, 200)));

		// Définition des boutons et leur JPanel
		JPanel PanelJouer = new JPanel();
		JPanel PanelBoutonQuitter = new JPanel();
		JPanel PanelBoutonRegles = new JPanel();
		JPanel PanelBoutonOptions = new JPanel();
		JButton BoutonJouer = new JButton("Jouer");
		JButton BoutonQuitter = new JButton("Quitter");
		JButton BoutonRegles = new JButton("Livret de Règles");
		JButton BoutonOptions = new JButton("Options");
		BoutonJouer.setPreferredSize(DimensionBouton);
		BoutonQuitter.setPreferredSize(DimensionBouton);
		BoutonRegles.setPreferredSize(DimensionBouton);
		BoutonOptions.setPreferredSize(DimensionBouton);
		PanelJouer.add(BoutonJouer);
		PanelBoutonRegles.add(BoutonRegles);
		PanelBoutonQuitter.add(BoutonQuitter);
		PanelBoutonOptions.add(BoutonOptions);

		// Définition du titre, de son JPanel et son icône
		final int largeur_titre = 300;
		final int hauteur_titre = 150;
		Dimension DimensionTitre = new Dimension(largeur_titre, hauteur_titre);
		JPanel PanelTitre = new JPanel();
		JLabel Titre = new JLabel("Jeu d'échecs");
		ImageIcon iconeLogo = new ImageIcon(new ImageIcon(getClass().getResource("images/Cavalier_N.png")).getImage().getScaledInstance(40, 40, Image.SCALE_SMOOTH));
		Titre.setIcon(iconeLogo);
		Titre.setPreferredSize(DimensionTitre);
		Font PoliceTitre = new Font("Arial", 0, 40);
		Titre.setFont(PoliceTitre);
		Titre.setBackground(Color.WHITE);
		PanelTitre.add(Titre);
		
		// Ajout des composants au PanelBouton
		final int espace_entre_boutons = 10;
		final int espace_entre_titre_et_boutons = 20;
		panelBouton.add(PanelTitre);
		panelBouton.add(Box.createVerticalStrut(espace_entre_titre_et_boutons));
		panelBouton.add(PanelJouer);
		panelBouton.add(Box.createVerticalStrut(espace_entre_boutons));
		panelBouton.add(PanelBoutonRegles);
		panelBouton.add(Box.createVerticalStrut(espace_entre_boutons));
		panelBouton.add(PanelBoutonOptions);
		panelBouton.add(Box.createVerticalStrut(espace_entre_boutons));
		panelBouton.add(PanelBoutonQuitter);
		
		// Couleurs des composants 
		PanelTitre.setBackground(blanc);
		panelBouton.setBackground(blanc);
		PanelJouer.setBackground(blanc);
		PanelBoutonRegles.setBackground(blanc);
		PanelBoutonOptions.setBackground(blanc);
		PanelBoutonQuitter.setBackground(blanc);
		BoutonJouer.setBackground(blanc);
		BoutonJouer.setForeground(noir);
		BoutonJouer.setBorder(BordureNoire);
		BoutonRegles.setBackground(blanc);
		BoutonRegles.setForeground(noir);
		BoutonRegles.setBorder(BordureNoire);
		BoutonOptions.setBackground(blanc);
		BoutonOptions.setForeground(noir);
		BoutonOptions.setBorder(BordureNoire);
		BoutonQuitter.setBackground(blanc);
		BoutonQuitter.setForeground(noir);
		BoutonQuitter.setBorder(BordureNoire);

		// ActionsListener des boutons
		BoutonJouer.addActionListener(new ActionJouer());
		BoutonRegles.addActionListener(new ActionRegles());
		BoutonOptions.addActionListener(new ActionOptions());
		BoutonQuitter.addActionListener(new ActionQuitter());

		// Ajout des panels au conteneur
		conteneur.add(panelBouton, BorderLayout.CENTER);

		// Options de la fenêtre
		fenetre.setPreferredSize(dimensionFenetre);
		fenetre.setLocation(x, y);
		fenetre.pack();
		fenetre.setVisible(true);
		
	}
	
		public Menu(boolean chronometre, boolean comentaires) {
		this();
		chrono = chronometre;
		coms = comentaires;
	}

	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				new Menu();
			}
		});
	}

	// Quitte la fenêtre si le bouton "Quitter" est selectionné
	class ActionQuitter implements ActionListener {
		public void actionPerformed(ActionEvent e) {
			fenetre.dispose();
		}
	}

	// Ouvre la fenêtre de selection de l'adversaire si le bouton "Jouer" est
	// selectionné
	class ActionJouer implements ActionListener {
		public void actionPerformed(ActionEvent e) {
			new MenuJouer();
			fenetre.dispose();
		}
	}
	
	// Ouvre la fenêtre de selection des options si le bouton "Jouer" est
		// selectionné
		class ActionOptions implements ActionListener {
			public void actionPerformed(ActionEvent e) {
				new Options(chrono, coms);
				fenetre.dispose();
			}
		}

	// Ouvre le livret de règles dans le navigateur internet si le bouton "Livret de règles" est selectionné
	class ActionRegles implements ActionListener {
		public void actionPerformed(ActionEvent e) {
			try {
				File monFichier = new File ("images/Livret_de_Regles.pdf");
				Desktop.getDesktop().open(monFichier);
			} catch (IOException IOE) {
			}
		}
	}
}
