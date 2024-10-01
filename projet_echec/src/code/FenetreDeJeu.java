package code;

import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.Image;
import java.awt.BorderLayout;
import java.awt.Color;

import javax.swing.*;

import java.awt.Toolkit;

public class FenetreDeJeu extends JFrame {

    /**
	 * 
	 */
	private static final long serialVersionUID = 4851876810396336464L;
	
	// Les variables qui gère la fenêtre
    Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize(); // Permet d'obtenir la taille de l'écran de
                                                                        // l'utilisateur
    double width = screenSize.getWidth();
    double height = screenSize.getHeight();
    int size = (int) (Math.sqrt(width * height) / 1.5);
    private final String titre = "Jeu d'échecs";
    final int largeurPanel = size / 8;
    private final Dimension dimensionFenetre = new Dimension((size + 35) + largeurPanel, size + 35);
    private final int[] positionFenetre = { (int) ((width - dimensionFenetre.getWidth()) / 2),
            (int) ((height - dimensionFenetre.getHeight()) / 2) };
    private JLayeredPane organisationPlans = new JLayeredPane();

    // Les variables qui gèrent l'échequier
    private JPanel plateauDeJeu;
    private final Color[] couleurEchequier = { new Color(236, 236, 212), new Color(113, 141, 84),
            new Color(229, 232, 232), new Color(247, 247, 105, 255), new Color(187, 203, 43) };
    private JPanel[] casesEchequier = new JPanel[64];
    private JLabel[] imagesEchequier = new JLabel[64];

    private boolean partieEnCour = true;

    Joueur joueur1;
    Joueur joueur2;
    Joueur[] joueurs;

    // Les variables qui gèrent le drag and drop

    private DragAndDrop gestionDragAndDrop = new DragAndDrop(this);
    private JLabel pieceEnMouvement;
    private final int tailleCase = (int) size / 8;
    private final int taillePiece = tailleCase - 10;
    private int caseDepart;
    private int caseArrive;
    private Plateau plateau;
    private Coup[] coupLegauxEnCour;

    // On initialise les images des Piece

    private ImageIcon imageRoiNoir = new ImageIcon( getClass().getResource("images/Roi_N.png"));
    private ImageIcon imageDameNoir = new ImageIcon(getClass().getResource("images/Reine_N.png"));
    private ImageIcon imageCavalierNoir = new ImageIcon(getClass().getResource("images/Cavalier_N.png"));
    private ImageIcon imageFouNoir = new ImageIcon(getClass().getResource("images/Fou_N.png"));
    private ImageIcon imageTourNoir = new ImageIcon(getClass().getResource("images/Tour_N.png"));
    private ImageIcon imagePionNoir = new ImageIcon(getClass().getResource("images/Pion_N.png"));
    private ImageIcon imageRoiBlanc = new ImageIcon(getClass().getResource("images/Roi_B.png"));
    private ImageIcon imageDameBlanc = new ImageIcon(getClass().getResource("images/Reine_B.png"));
    private ImageIcon imageCavalierBlanc = new ImageIcon(getClass().getResource("images/Cavalier_B.png"));
    private ImageIcon imageFouBlanc = new ImageIcon(getClass().getResource("images/Fou_B.png"));
    private ImageIcon imageTourBlanc = new ImageIcon(getClass().getResource("images/Tour_B.png"));
    private ImageIcon imagePionBlanc = new ImageIcon(getClass().getResource("images/Pion_B.png"));
    private ImageIcon imageCasePossible1 = new ImageIcon(getClass().getResource("images/CasePossible1.png"));
    private ImageIcon imageCasePossible2 = new ImageIcon(getClass().getResource("images/CasePossible2.png"));
    private ImageIcon imagePieceCapturable = new ImageIcon(getClass().getResource("images/PieceCapturable.png"));
    private ImageIcon imageVide = new ImageIcon("");

    // Paramètres des Chronomètres
    final int minutesInit = 60;
    final int secondesInit = 0;
    Chronometre ChronoBlanc = new Chronometre(minutesInit, secondesInit);
    Chronometre ChronoNoir = new Chronometre(minutesInit, secondesInit);
    Thread threadChronoBlanc = new Thread(this.ChronoBlanc);
    Thread threadChronoNoir = new Thread(this.ChronoNoir);

    // JLabel d'indication à qui de jouer
    JLabel LabelTourCouleur = new JLabel("Blanc");
    JLabel LabelTour;

    private boolean chrono;

    /**
     * @param plateau le plateau de jeu, qui gère les pièces et déplacements
     * @param chrono Le chronomètre du jeu
     */
    FenetreDeJeu(Plateau plateau, boolean chrono) {
        this.plateau = plateau;
        this.chrono = chrono;
    }

    /**
     * @param joueur1 Le joueur blanc
     * @param joueur2 Le joueur noir
     * Permet de faire passer les joueurs à la fenêtre graphique
     */
    public void InitialiserJoueurs(Joueur joueur1, Joueur joueur2) {
        this.joueur1 = joueur1;
        this.joueur2 = joueur2;
        this.joueurs = new Joueur[] { joueur1, joueur2 };

        if (this.joueur1 instanceof IA) {
            this.RelacherPieceIA();
        }
    }

    /**
     * Pour afficher la fenetre crée
     */
    void initialiserFenetre() {

        super.setTitle(this.titre);
        super.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        super.setPreferredSize(this.dimensionFenetre);
        super.setLocation(positionFenetre[0], positionFenetre[1]);

        this.initialiserPartieDroiteFenetre();

        super.pack();
        super.setVisible(true);
    }

    /**
     * Permet d'initialiser la fenêtre a droite de l'echequier
     */
    public void initialiserPartieDroiteFenetre () {

        // Layout de la fenêtre
        BorderLayout LayoutConteneur = new BorderLayout();
        super.setLayout(LayoutConteneur);

        // Panel à côté du plateau de Jeu
        JPanel panel1 = new JPanel();
        BorderLayout LayoutPanel1 = new BorderLayout();
        panel1.setLayout(LayoutPanel1);

        // sous-Panel qui contrôle l'allignement selon Y des composants
        JPanel panel2 = new JPanel();
        BoxLayout LayoutPanel2 = new BoxLayout(panel2, BoxLayout.Y_AXIS);
        panel2.setLayout(LayoutPanel2);

        // Gestion des chronomètres
        JPanel panel3 = new JPanel();
        BoxLayout LayoutPanel3 = new BoxLayout(panel3, BoxLayout.X_AXIS);
        panel3.setLayout(LayoutPanel3);

        // Chronomètres
        JPanel panel4 = new JPanel();
        JPanel panel5 = new JPanel();
        if (this.chrono) {
            // Chronomètre de gauche
            BoxLayout LayoutPanel4 = new BoxLayout(panel4, BoxLayout.Y_AXIS);
            panel4.setLayout(LayoutPanel4);
            JLabel TitreChronoBlanc = new JLabel("Blanc");
            JLabel LabelChronoBlanc = new JLabel();
            LabelChronoBlanc = ChronoBlanc.getLabel();
            panel4.add(TitreChronoBlanc);
            panel4.add(LabelChronoBlanc);

            // Chronomètre de droite
            BoxLayout LayoutPanel5 = new BoxLayout(panel5, BoxLayout.Y_AXIS);
            panel5.setLayout(LayoutPanel5);
            JLabel TitreChronoNoir = new JLabel("Noir");
            JLabel LabelChronoNoir = new JLabel();
            LabelChronoNoir = ChronoNoir.getLabel();
            panel5.add(TitreChronoNoir);
            panel5.add(LabelChronoNoir);
        }

        // Indication à qui de jouer
        JPanel panel6 = new JPanel();
        // BoxLayout LayoutPanel6 = new BoxLayout(panel6, BoxLayout.Y_AXIS);
        // panel6.setLayout(LayoutPanel6);
        this.LabelTour = new JLabel("Tour :");
        panel6.add(LabelTour);
        panel6.add(this.LabelTourCouleur);

        // Gestions des panels
        panel3.add(panel4);
        panel3.add(Box.createHorizontalStrut(10));
        panel3.add(panel5);
        panel3.add(Box.createHorizontalStrut(25));

        if (this.chrono) {
            panel2.add(panel3);
            panel6.add(Box.createHorizontalStrut(25));
            panel1.add(panel6, BorderLayout.PAGE_START);
            panel1.add(panel2, BorderLayout.CENTER);
        } else {
            panel6.add(Box.createHorizontalStrut(25));
            panel1.add(panel6, BorderLayout.CENTER);
        }

        super.add(organisationPlans, BorderLayout.CENTER);
        super.add(panel1, BorderLayout.LINE_END);

        this.dessinerPlateau();

        addMouseListener(this.gestionDragAndDrop);
        addMouseMotionListener(this.gestionDragAndDrop);
    }

    /**
     * Pour dessiner les cases de l'échequier
     */
    void dessinerPlateau() {
        this.plateauDeJeu = new JPanel();
        this.plateauDeJeu.setLayout(new GridLayout(8, 8));
        this.plateauDeJeu.setPreferredSize(this.dimensionFenetre);
        for (int i = 0; i < 8; i++) {
            for (int j = 0; j < 8; j++) {
                JPanel casePlateau = new JPanel();
                if ((i + j) % 2 == 0) {
                    casePlateau.setBackground(this.couleurEchequier[0]);
                } else {
                    casePlateau.setBackground(this.couleurEchequier[1]);
                }

                JLabel image = new JLabel();
                image.setSize(new Dimension(this.tailleCase, this.tailleCase));

                casePlateau.add(image);
                this.plateauDeJeu.add(casePlateau);
                this.casesEchequier[i * 8 + j] = casePlateau;
                this.imagesEchequier[i * 8 + j] = image;
            }
        }
        this.plateauDeJeu.setBounds(0, 0, size, size);
        this.organisationPlans.add(this.plateauDeJeu, JLayeredPane.DEFAULT_LAYER);
        super.add(organisationPlans);
    }

    /**
     * @param numeroPiece       le nom de la piece a poser
     * @param numeroCasePlateau la case sur laquel poser la piece
     */
    public void poserPiece(int numeroPiece, int numeroCasePlateau) {
        if (numeroPiece == 1) {
            this.gestionImagePiece(numeroCasePlateau, this.imagePionBlanc);
        } else if (numeroPiece == 2) {
            this.gestionImagePiece(numeroCasePlateau, this.imageFouBlanc);
        } else if (numeroPiece == 3) {
            this.gestionImagePiece(numeroCasePlateau, this.imageTourBlanc);
        } else if (numeroPiece == 4) {
            this.gestionImagePiece(numeroCasePlateau, this.imageCavalierBlanc);
        } else if (numeroPiece == 5) {
            this.gestionImagePiece(numeroCasePlateau, this.imageDameBlanc);
        } else if (numeroPiece == 6) {
            this.gestionImagePiece(numeroCasePlateau, this.imageRoiBlanc);
        } else if (numeroPiece == 9) {
            this.gestionImagePiece(numeroCasePlateau, this.imagePionNoir);
        } else if (numeroPiece == 10) {
            this.gestionImagePiece(numeroCasePlateau, this.imageFouNoir);
        } else if (numeroPiece == 11) {
            this.gestionImagePiece(numeroCasePlateau, this.imageTourNoir);
        } else if (numeroPiece == 12) {
            this.gestionImagePiece(numeroCasePlateau, this.imageCavalierNoir);
        } else if (numeroPiece == 13) {
            this.gestionImagePiece(numeroCasePlateau, this.imageDameNoir);
        } else if (numeroPiece == 14) {
            this.gestionImagePiece(numeroCasePlateau, this.imageRoiNoir);
        }
    }

    /**
     * Permet de gérer le centrage de la pièce sur la case pour le placement
     * 
     * @param numeroCasePlateau
     * @param imagePiece
     */
    private void gestionImagePiece(int numeroCasePlateau, ImageIcon imagePiece) {
        this.imagesEchequier[numeroCasePlateau].setIcon(redimensionnerImage(imagePiece));
        this.imagesEchequier[numeroCasePlateau].setVerticalAlignment(JLabel.CENTER);
        this.imagesEchequier[numeroCasePlateau].setHorizontalAlignment(JLabel.CENTER);
    }

    /**
     * Permet de redimensionner une image (d'une pièce)
     * 
     * @param imagePiece
     * @return ImageIcon qui est la version de imagePiece redimensionner
     */
    private ImageIcon redimensionnerImage(ImageIcon imagePiece) {
        Image newImagePiece = imagePiece.getImage().getScaledInstance(this.taillePiece, this.taillePiece,
                java.awt.Image.SCALE_SMOOTH);
        return new ImageIcon(newImagePiece);
    }

    /**
     * Permet de lacher la piece sur une case
     * 
     * @param positionX la coordonnée X de la souris
     * @param positionY la coordonée Y de la souris
     */
    public void relacherPiece(int positionX, int positionY) {
        if (this.partieEnCour) {
            if (positionY > 8 * this.tailleCase) {
                positionY = this.tailleCase * 8 - 1;
            }
            if (positionX > 8 * this.tailleCase) {
                positionX = this.tailleCase * 8 - 1;
            }
            int couleur = this.plateau.RenvoyerTourBlanc() ? 0 : 1;
            if (joueurs[couleur] instanceof Humain) {
                int ancienCaseArrive = this.caseArrive;
                this.caseArrive = positionX / this.tailleCase + (positionY / this.tailleCase) * 8;
                if (ancienCaseArrive != this.caseArrive) {
                    this.repeindrePlateau(ancienCaseArrive);
                }
                int positionTourDepart = 0;
                int positionTourArrivee = 0;
                this.decolorierCoups(this.coupLegauxEnCour);
                this.repeindrePlateau(this.caseArrive);
                if (Plateau.contains(this.coupLegauxEnCour, this.caseArrive)) {
                    Coup coup = this.coupLegauxEnCour[Plateau.IndiceListe(coupLegauxEnCour, this.caseArrive)];
                    if (coup.roque != -1) {
                        if (this.caseDepart - this.caseArrive == 2) {
                            positionTourDepart = coup.roque;
                            positionTourArrivee = caseDepart - 1;
                        } else if (this.caseDepart - this.caseArrive == -2) {
                            positionTourDepart = coup.roque;
                            positionTourArrivee = caseDepart + 1;
                        }
                    }
                    if (coup.priseEnPassant != -1) {
                        this.imagesEchequier[coup.priseEnPassant].setIcon(imageVide);
                    }
                    if (this.chrono) {
                        mettreAJourChronos();
                    }
                    mettreAJourLabelTour();
                    this.plateau.JouerCoup(coup);
                    this.imagesEchequier[this.caseArrive].setIcon(this.pieceEnMouvement.getIcon());
                    if (this.organisationPlans.getIndexOf(this.pieceEnMouvement) != -1) {
                        this.organisationPlans.remove(this.pieceEnMouvement);
                    }
                    if (coup.roque != -1) {
                        if (this.plateau.RecupererPositionsPiece()[this.caseArrive].RenvoyerCouleur() == 0) {
                            this.imagesEchequier[positionTourArrivee].setIcon(redimensionnerImage(imageTourBlanc));
                        } else {
                            this.imagesEchequier[positionTourArrivee].setIcon(redimensionnerImage(imageTourNoir));
                        }
                        this.imagesEchequier[positionTourDepart].setIcon(imageVide);

                    }
                    if (coup.promotion != -1) {
                        if (this.plateau.RecupererPositionsPiece()[coup.positionArivee].RenvoyerCouleur() == 0) {
                            this.imagesEchequier[coup.positionArivee].setIcon(redimensionnerImage(imageDameBlanc));
                        } else {
                            this.imagesEchequier[coup.positionArivee].setIcon(redimensionnerImage(imageDameNoir));
                        }
                    }

                    if (this.plateau.CoupLegaux().size() == 0) {
                        if (this.plateau.RoiEnEchec(couleur)) {
                            this.FinDePartie(couleur);
                        } else {
                            this.FinDePartie(-1);
                        }
                    }

                    else {

                        couleur = this.plateau.RenvoyerTourBlanc() ? 0 : 1;
                        if (joueurs[couleur] instanceof IA) {
                            this.RelacherPieceIA();
                        }
                    }
                }

                else {
                    if (this.pieceEnMouvement != null) {
                        this.imagesEchequier[this.caseDepart].setIcon(this.pieceEnMouvement.getIcon());
                        if (this.organisationPlans.getIndexOf(this.pieceEnMouvement) != -1) {
                            this.organisationPlans.remove(this.pieceEnMouvement);
                        }
                    }
                }
                this.colorierCoupsPieces(this.caseArrive);
                this.organisationPlans.repaint();
            }
        }
    }

    public void RelacherPieceIA() {

        if (this.partieEnCour) {

            int couleur = this.plateau.RenvoyerTourBlanc() ? 0 : 1;
            Coup coup = this.joueurs[couleur].RechercherMeilleurCoup();

            if (this.chrono) {
                mettreAJourChronos();
            }

            this.repeindrePlateau(this.caseDepart);
            this.caseDepart = coup.positionDepart;
            this.coupLegauxEnCour = null;
            this.colorierCoups(this.coupLegauxEnCour);
            this.colorierCoupsPieces(this.caseDepart);
            this.pieceEnMouvement = new JLabel();
            this.pieceEnMouvement.setIcon(this.imagesEchequier[this.caseDepart].getIcon());
            this.pieceEnMouvement.setVisible(true);
            this.pieceEnMouvement.setBounds((caseDepart % 8) * this.tailleCase, (caseDepart / 8) * this.tailleCase,
                    this.tailleCase, this.tailleCase);
            this.organisationPlans.add(this.pieceEnMouvement, JLayeredPane.DRAG_LAYER);
            this.imagesEchequier[this.caseDepart].setIcon(imageVide);

            this.organisationPlans.repaint();

            int ancienCaseArrive = this.caseArrive;
            this.caseArrive = coup.positionArivee;
            if (ancienCaseArrive != this.caseArrive) {
                this.repeindrePlateau(ancienCaseArrive);
            }
            int positionTourDepart = 0;
            int positionTourArrivee = 0;
            this.decolorierCoups(this.coupLegauxEnCour);
            this.repeindrePlateau(this.caseArrive);

            if (coup.roque != -1) {
                if (this.caseDepart - this.caseArrive == 2) {
                    positionTourDepart = coup.roque;
                    positionTourArrivee = caseDepart - 1;
                } else if (this.caseDepart - this.caseArrive == -2) {
                    positionTourDepart = coup.roque;
                    positionTourArrivee = caseDepart + 1;
                }
            }

            if (coup.priseEnPassant != -1) {
                this.imagesEchequier[coup.priseEnPassant].setIcon(imageVide);
            }
            mettreAJourLabelTour();
            this.plateau.JouerCoup(coup);
            this.imagesEchequier[this.caseArrive].setIcon(this.pieceEnMouvement.getIcon());
            if (this.organisationPlans.getIndexOf(this.pieceEnMouvement) != -1) {
                this.organisationPlans.remove(this.pieceEnMouvement);
            }
            if (coup.roque != -1) {
                if (this.plateau.RecupererPositionsPiece()[this.caseArrive].RenvoyerCouleur() == 0) {
                    this.imagesEchequier[positionTourArrivee].setIcon(redimensionnerImage(imageTourBlanc));
                } else {
                    this.imagesEchequier[positionTourArrivee].setIcon(redimensionnerImage(imageTourNoir));
                }
                this.imagesEchequier[positionTourDepart].setIcon(imageVide);

            }

            if (coup.promotion != -1) {
                if (this.plateau.RecupererPositionsPiece()[coup.positionArivee].RenvoyerCouleur() == 0) {
                    this.imagesEchequier[coup.positionArivee].setIcon(redimensionnerImage(imageDameBlanc));
                } else {
                    this.imagesEchequier[coup.positionArivee].setIcon(redimensionnerImage(imageDameNoir));
                }
            }

            this.colorierCoupsPieces(this.caseArrive);

            

            if (this.plateau.CoupLegaux().size() == 0) {
                if (this.plateau.RoiEnEchec(couleur)) {
                    this.FinDePartie(couleur == 0 ? 0 : 1);
                } else {
                    this.FinDePartie(-1);
                }
            }
            this.organisationPlans.repaint();
        }
    }

    /**
     * Est appelée pour deplacer l'image de la pièce lorceque la souris se déplace
     * 
     * @param positionX la coordonée X de la souris
     * @param positionY la coordonée Y de la souris
     */
    public void tirerPiece(int positionX, int positionY) {
        if (this.partieEnCour) {
            if (positionY > 8 * this.tailleCase) {
                positionY = this.tailleCase * 8 - 1;
            }
            if (positionX > 8 * this.tailleCase) {
                positionX = this.tailleCase * 8 - 1;
            }
            int couleur = this.plateau.RenvoyerTourBlanc() ? 0 : 1;
            if (joueurs[couleur] instanceof Humain) {
                this.pieceEnMouvement.setLocation(positionX - this.tailleCase / 2, positionY - this.tailleCase / 2);
                this.organisationPlans.repaint();
            }
        }
    }

    /**
     * Est appellée lorsque l'on appuye sur une case
     * 
     * @param positionX la coordonée X de la souris
     * @param positionY la coordonée Y de la souris
     */
    public void appuyerSurPiece(int positionX, int positionY) {
        if (this.partieEnCour) {
            if (positionY > 8 * this.tailleCase) {
                positionY = this.tailleCase * 8 - 1;
            }
            if (positionX > 8 * this.tailleCase) {
                positionX = this.tailleCase * 8 - 1;
            }
            int couleur = this.plateau.RenvoyerTourBlanc() ? 0 : 1;
            if (joueurs[couleur] instanceof Humain) {
                this.repeindrePlateau(this.caseDepart);
                this.caseDepart = positionX / this.tailleCase + (positionY / this.tailleCase) * 8;
                this.coupLegauxEnCour = this.plateau.CoupLegaux(this.caseDepart);
                this.trierCoups();
                this.colorierCoups(this.coupLegauxEnCour);
                this.colorierCoupsPieces(this.caseDepart);
                this.pieceEnMouvement = new JLabel();
                this.pieceEnMouvement.setIcon(this.imagesEchequier[this.caseDepart].getIcon());
                this.pieceEnMouvement.setVisible(true);
                this.pieceEnMouvement.setBounds((caseDepart % 8) * this.tailleCase, (caseDepart / 8) * this.tailleCase,
                        this.tailleCase, this.tailleCase);
                this.organisationPlans.add(this.pieceEnMouvement, JLayeredPane.DRAG_LAYER);
                this.imagesEchequier[this.caseDepart].setIcon(imageVide);

                this.organisationPlans.repaint();
            }
        }
    }

    public void colorierCoups(Coup[] coups) {
        if (coups != null) {
            for (Coup coup : coups) {
                int i = coup.positionArivee;
                if (pieceCapturable(i)) {
                    this.casesEchequier[i].add(new JLabel(this.redimensionnerImage(imagePieceCapturable)));
                } else if ((i / 8 + i % 8) % 2 == 0) {
                    this.casesEchequier[i].add(new JLabel(this.redimensionnerImage(imageCasePossible1)));
                } else {
                    this.casesEchequier[i].add(new JLabel(this.redimensionnerImage(imageCasePossible2)));
                }
            }
        }
    }

    public void trierCoups() {
        int compteurListe = 0;
        Coup[] coupLegaux;

        if (this.coupLegauxEnCour == null) {
            return;
        }

        Coup coup = this.coupLegauxEnCour[0];
        while (coup != null) {
            compteurListe++;
            coup = this.coupLegauxEnCour[compteurListe];
        }

        coupLegaux = new Coup[compteurListe];

        for (int i = 0; i < compteurListe; i++) {
            coupLegaux[i] = this.coupLegauxEnCour[i];
        }
        this.coupLegauxEnCour = coupLegaux;
    }

    private boolean pieceCapturable(int coup) {
        if (this.plateau.RecupererPositionsPiece()[coup] instanceof Pion ||
                this.plateau.RecupererPositionsPiece()[coup] instanceof Tour ||
                this.plateau.RecupererPositionsPiece()[coup] instanceof Fou ||
                this.plateau.RecupererPositionsPiece()[coup] instanceof Cavalier ||
                this.plateau.RecupererPositionsPiece()[coup] instanceof Reine) {
            return true;
        } else {
            return false;
        }
    }

    private void decolorierCoups(Coup[] coups) {
        if (coups != null) {
            for (Coup coup : coups) {
                int i = coup.positionArivee;
                if ((i / 8 + i % 8) % 2 == 0) {
                    this.casesEchequier[i].remove(this.casesEchequier[i].getComponentCount() - 1);
                } else {
                    this.casesEchequier[i].remove(this.casesEchequier[i].getComponentCount() - 1);
                }
            }
        }
    }

    private void colorierCoupsPieces(int caseAPeindre) {
        if ((caseAPeindre / 8 + caseAPeindre % 8) % 2 == 0) {
            this.casesEchequier[caseAPeindre].setBackground(this.couleurEchequier[3]);
        } else {
            this.casesEchequier[caseAPeindre].setBackground(this.couleurEchequier[4]);
        }
    }

    public void enleverColoriage(Coup[] coups) {
        if (coups != null) {
            for (Coup coup : coups) {
                repeindrePlateau(coup.positionArivee);
            }
        }
    }

    private void repeindrePlateau(int caseARepeindre) {
        assert caseARepeindre < 64 && caseARepeindre >= 0;
        if ((caseARepeindre / 8 + caseARepeindre % 8) % 2 == 0) {
            this.casesEchequier[caseARepeindre].setBackground(this.couleurEchequier[0]);
        } else {
            this.casesEchequier[caseARepeindre].setBackground(this.couleurEchequier[1]);
        }
    }
    
    /**
     * La méthode suspend() n'est plus à jour mais est utilisable.
     */
	private void mettreAJourChronos() {
        try {
            if (!(this.plateau.tourBlanc())) {
                threadChronoBlanc.start();
                threadChronoNoir.suspend();
            } else {
                threadChronoNoir.start();
                threadChronoBlanc.suspend();
            }
        } catch (IllegalThreadStateException ITSE) {
            if (!(this.plateau.tourBlanc())) {
                threadChronoNoir.suspend();
                threadChronoBlanc.resume();
            } else {
                threadChronoBlanc.suspend();
                threadChronoNoir.resume();
            }
        }
    }

    private void mettreAJourLabelTour() {
        if (!(this.plateau.tourBlanc())) {
            this.LabelTourCouleur.setText("Blanc");
        } else {
            this.LabelTourCouleur.setText("Noir");
        }
    }

    public void FermerFenetre() {
        super.dispose();
    }

    /**
     * @param couleurPerdant 0 pour les blancs, 1 noir et -1 pat
     */
    public void FinDePartie(int couleurPerdant) {
        this.partieEnCour = false;
        if (couleurPerdant != -1) {
            this.LabelTourCouleur.setText(couleurPerdant == 0 ? "Blanc" : "Noir");
            this.LabelTour.setText("Echec et Mat ! Gagnant :");
        } else {
            this.LabelTourCouleur.setText("");
            this.LabelTour.setText("Pat");
        }
    }

}
