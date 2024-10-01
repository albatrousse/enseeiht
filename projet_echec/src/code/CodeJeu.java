package code;
import javax.swing.*;
import javax.swing.border.EmptyBorder;

import java.awt.*;
import java.awt.event.*;

public class CodeJeu implements InterfaceMenu {

	JFrame fenetre = new JFrame();
	JButton boutonRetour = new JButton("Retour");
	JTextField codeJeu = new JTextField();
	JButton boutonEntrer = new JButton("Entrer");
	JLabel LabelCodeIncorrect = new JLabel("");
	int nivIA;
	int joueur1;
	int joueur2;
	
	public CodeJeu(int joueur1, int joueur2, int nivIA) {
		
		// Mise à jour des caractéristiques des joueurs
		this.nivIA = nivIA;
		this.joueur1 = joueur1;
		this.joueur2 = joueur2;
		
		// Conteneur de la fenêtre de CodeJeu
		fenetre.setTitle("Jeu d'échecs");
		Container contenu = this.fenetre.getContentPane();
		contenu.setLayout(new BorderLayout());
		
		// Consigne pour l'utilisateur, affichage noir sur blanc, bordure noire
		JPanel paneltitre = new JPanel();
		paneltitre.setLayout(new FlowLayout(FlowLayout.CENTER));
		JLabel titre = new JLabel("Veuillez sélectionner le code du jeu en cours");
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
		
		// Entrée du code de jeu
		JPanel code = new JPanel();
		code.setLayout(new FlowLayout());
		code.setBackground(blanc);
		JLabel codeNom = new JLabel("Code : ");
		codeNom.setBackground(blanc);
		code.add(codeNom);
		// code de type ligne/ligne/ligne/ligne, max 32 places occupées et 32 vides
		codeJeu = new JTextField((8+1)*8);
		codeJeu.setBackground(blanc);
		codeJeu.setHorizontalAlignment(SwingConstants.CENTER);
		codeJeu.setSize(256000,256);
		code.add(codeJeu);
		
		// Affichage du code
		choix.add(code);
		
		// Cas de code incorrect
		JPanel PanelCodeIncorrect = new JPanel();
		PanelCodeIncorrect.setBackground(blanc);
		PanelCodeIncorrect.add(LabelCodeIncorrect);
		choix.add(PanelCodeIncorrect);
		
		// Entrer la commande tapée au clavier
		JPanel caseEntrer = new JPanel();
		caseEntrer.setBackground(blanc);
		caseEntrer.setLayout(new BoxLayout(caseEntrer, BoxLayout.Y_AXIS));
		caseEntrer.setAlignmentX(Component.CENTER_ALIGNMENT);
		caseEntrer.add(this.boutonEntrer);
		boutonEntrer.setBackground(blanc);
		boutonEntrer.addActionListener(new ActionEntrer());
		choix.add(caseEntrer);
		
		// Retour au ChoixHumain
		JPanel caseRetour = new JPanel();
		caseRetour.setBackground(blanc);
		caseRetour.setLayout(new BoxLayout(caseRetour, BoxLayout.X_AXIS));
		caseRetour.setAlignmentX(Component.CENTER_ALIGNMENT);
		caseRetour.add(this.boutonRetour);
		boutonRetour.addActionListener(new ActionRetour());
		boutonRetour.setBackground(blanc);
		choix.add(Box.createVerticalStrut(20));
		choix.add(caseRetour);
		
		// Ajout des composants au contenu de la fenêtre
		contenu.add(choix, BorderLayout.CENTER);
		
		// Paramètres de la fenêtre
		this.fenetre.setPreferredSize(dimensionFenetre);
		this.fenetre.setLocation(x,y);
		this.fenetre.pack();
		this.fenetre.setVisible(true);
		
	}
	
	class ActionRetour implements ActionListener {
		public void actionPerformed(ActionEvent retour) {
			new ChoixHumain(joueur1, joueur2, nivIA);
			fenetre.dispose();
		}
	}
	
	class ActionEntrer implements ActionListener {
		public void actionPerformed(ActionEvent jeu) {
			try {
				String codedemand = codeJeu.getText();
				new App(joueur1, joueur2, nivIA, Menu.chrono, Menu.coms, codedemand);
			} catch (CodeIncorrectException CIE) {
				LabelCodeIncorrect.setText("Code Incorrect");
			}


			
			// création du plateau en fonction du parametre du niveau de l'IA du constructeur (0 -> humain, 1 -> facile, 2 -> moyen, 3 -> difficile)
		}
	}
}
