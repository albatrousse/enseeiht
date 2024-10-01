package code;

public class Plateau

{

    final int MIDGAME = 0;
    final int ENDGAME = 1;

    private int etatJeu;

    private Piece[] echequierPositions = new Piece[64]; // Variable qui indique les position de chaque Piece
    private FenetreDeJeu fenetrePrincipale;

    private boolean tourBlanc = true;
    private int balanceMaterielBlanc = 0;
    private int materielBlanc = 0;
    private int materielNoir = 0;

    private long positionsPieces;
    private long positionPiecesBlanches;
    private long positionPiecesNoires;

    private long positionFous;
    private long positionTours;
    private long positionReine;
    private long positionCavalier;
    private long positionPion;
    private long positionRoi;

    private long casePriseEnPassant;

    private long[] CAVALIER_COUPS = new long[64];
    private long[] REINE_COUPS = new long[64];
    private long[] FOU_COUPS = new long[64];
    private long[] TOUR_COUP = new long[64];
    private long[] PION_B_PRISES = new long[64];
    private long[] PION_N_PRISES = new long[64];
    private long[] ROI_COUPS = new long[64];
    private long[] PION_B_DEPLACEMENT = new long[64];
    private long[] PION_N_DEPLACEMENT = new long[64];
    private long[][] PIECES_COUPS;
    private final long[] MASQUEDROITE = BitBoard.InitialiserMasqueDroites();

    private final int[] evaluationCasesCavalier = new int[] {
            -50, -40, -30, -30, -30, -30, -40, -50,
            -40, -20, 0, 0, 0, 0, -20, -40,
            -30, 0, 10, 15, 15, 10, 0, -30,
            -30, 5, 15, 20, 20, 15, 5, -30,
            -30, 0, 15, 20, 20, 15, 0, -30,
            -30, 5, 10, 15, 15, 10, 5, -30,
            -40, -20, 0, 5, 5, 0, -20, -40,
            -50, -40, -30, -30, -30, -30, -40, -50,
    };
    private final int[] evaluationCasesFou = new int[] {
            -20, -10, -10, -10, -10, -10, -10, -20,
            -10, 0, 0, 0, 0, 0, 0, -10,
            -10, 0, 5, 10, 10, 5, 0, -10,
            -10, 5, 5, 10, 10, 5, 5, -10,
            -10, 0, 10, 10, 10, 10, 0, -10,
            -10, 10, 10, 10, 10, 10, 10, -10,
            -10, 5, 0, 0, 0, 0, 5, -10,
            -20, -10, -10, -10, -10, -10, -10, -20,
    };
    private final int[] evaluationCasesTour = new int[] {
            0, 0, 0, 0, 0, 0, 0, 0,
            5, 10, 10, 10, 10, 10, 10, 5,
            -5, 0, 0, 0, 0, 0, 0, -5,
            -5, 0, 0, 0, 0, 0, 0, -5,
            -5, 0, 0, 0, 0, 0, 0, -5,
            -5, 0, 0, 0, 0, 0, 0, -5,
            -5, 0, 0, 0, 0, 0, 0, -5,
            0, 0, 0, 5, 5, 0, 0, 0
    };
    private final int[] evaluationCasesPion = new int[] {
            0, 0, 0, 0, 0, 0, 0, 0,
            50, 50, 50, 50, 50, 50, 50, 50,
            10, 10, 20, 30, 30, 20, 10, 10,
            5, 5, 10, 25, 25, 10, 5, 5,
            0, 0, 0, 20, 20, 0, 0, 0,
            5, -5, -10, 0, 0, -10, -5, 5,
            5, 10, 10, -20, -20, 10, 10, 5,
            0, 0, 0, 0, 0, 0, 0, 0

    };
    private final int[] evaluationCasesReine = new int[] {
            -20, -10, -10, -5, -5, -10, -10, -20,
            -10, 0, 0, 0, 0, 0, 0, -10,
            -10, 0, 5, 5, 5, 5, 0, -10,
            -5, 0, 5, 5, 5, 5, 0, -5,
            0, 0, 5, 5, 5, 5, 0, -5,
            -10, 5, 5, 5, 5, 5, 0, -10,
            -10, 0, 5, 0, 0, 0, 0, -10,
            -20, -10, -10, -5, -5, -10, -10, -20
    };
    private final int[] evaluationCasesRoiDebut = new int[] {
            -30, -40, -40, -50, -50, -40, -40, -30,
            -30, -40, -40, -50, -50, -40, -40, -30,
            -30, -40, -40, -50, -50, -40, -40, -30,
            -30, -40, -40, -50, -50, -40, -40, -30,
            -20, -30, -30, -40, -40, -30, -30, -20,
            -10, -20, -20, -20, -20, -20, -20, -10,
            20, 20, 0, 0, 0, 0, 20, 20,
            20, 30, 10, 0, 0, 10, 30, 20
    };
    private final int[] evaluationCasesRoiFin = new int[] {
            -50, -40, -30, -20, -20, -30, -40, -50,
            -30, -20, -10, 0, 0, -10, -20, -30,
            -30, -10, 20, 30, 30, 20, -10, -30,
            -30, -10, 30, 40, 40, 30, -10, -30,
            -30, -10, 30, 40, 40, 30, -10, -30,
            -30, -10, 20, 30, 30, 20, -10, -30,
            -30, -30, 0, 0, 0, 0, -30, -30,
            -50, -30, -30, -30, -30, -30, -30, -50
    };

    /**
     * @return la liste des pieces et leurs positions
     */
    public Piece[] RecupererPositionsPiece() {
        return this.echequierPositions;
    }

    public boolean RenvoyerTourBlanc() {
        return this.tourBlanc;
    }

    public FenetreDeJeu RenvoyerFenetre() {
        return this.fenetrePrincipale;
    }

    public static int[][] MoinsUn(int[][] tableau) {
        for (int i = 0; i < tableau.length; i++) {
            for (int j = 0; j < tableau[i].length; j++) {
                tableau[i][j] = -1;
            }
        }
        return tableau;
    }

    public int RenvoyerEvaluationCase(Piece piece, int position) {

        if (piece instanceof Pion) {
            if (piece.RenvoyerCouleur() == 0) {
                return this.evaluationCasesPion[position];
            } else {
                return this.evaluationCasesPion[63 - position];
            }

        } else if (piece instanceof Cavalier) {
            return this.evaluationCasesCavalier[position];

        } else if (piece instanceof Tour) {
            return this.evaluationCasesTour[position];

        } else if (piece instanceof Roi) {
            if (piece.RenvoyerCouleur() == 0) {
                if (this.etatJeu == MIDGAME) {
                    return this.evaluationCasesRoiDebut[position];
                }
                else if (this.etatJeu == ENDGAME) {
                    return this.evaluationCasesRoiFin [position];
                }
            } else {
                if (this.etatJeu == MIDGAME) {
                    return this.evaluationCasesRoiDebut[63 - position];
                }
                else if (this.etatJeu == ENDGAME) {
                    return this.evaluationCasesRoiFin [63 - position];
                }
            }

        } else if (piece instanceof Fou) {
            return this.evaluationCasesFou[position];

        } else if (piece instanceof Reine) {
            return this.evaluationCasesReine[position];
        }
        return 0;
    }

    public boolean EstCapture (Coup coup) {
        if (this.echequierPositions[coup.positionArivee] instanceof CaseVide) {
            return false;
        }
        return true;
    }

    public void MettreAJourEvaluation (Coup coup, boolean JouerCoup) {

        Piece pieceBougee = this.echequierPositions[coup.positionArivee];
        int ajoutPositionnel = 0;

        ajoutPositionnel += this.tourBlanc ? - this.RenvoyerEvaluationCase(pieceBougee, coup.positionDepart) : this.RenvoyerEvaluationCase(pieceBougee, coup.positionDepart);
        ajoutPositionnel += this.tourBlanc ? this.RenvoyerEvaluationCase(pieceBougee, coup.positionArivee) : - this.RenvoyerEvaluationCase(pieceBougee, coup.positionArivee);    

        if (!(coup.pieceMangee instanceof CaseVide)) {

            if (this.tourBlanc) {
                if (JouerCoup) {
                    this.materielNoir += -coup.pieceMangee.RenvoyerValeur();
                }
                else {
                    this.materielBlanc += coup.pieceMangee.RenvoyerValeur();
                }    
            }
            else {
                if (JouerCoup) {
                    this.materielBlanc += -coup.pieceMangee.RenvoyerValeur();
                }
                else {
                    this.materielNoir += coup.pieceMangee.RenvoyerValeur();
                } 
            }

            this.balanceMaterielBlanc += this.tourBlanc ? coup.pieceMangee.RenvoyerValeur() : -coup.pieceMangee.RenvoyerValeur();
            ajoutPositionnel += this.tourBlanc ? this.RenvoyerEvaluationCase(coup.pieceMangee, coup.positionArivee) : - this.RenvoyerEvaluationCase(coup.pieceMangee, coup.positionArivee);

            if (this.materielBlanc < 1500 || this.materielNoir < 1500) {
                this.etatJeu = ENDGAME;
            }

        }

        if (coup.priseEnPassant != -1) {
            this.balanceMaterielBlanc += this.tourBlanc ? 100 : -100;
            if (JouerCoup) {
                ajoutPositionnel += this.tourBlanc ? this.evaluationCasesPion[63 - coup.priseEnPassant] : - this.evaluationCasesPion[coup.priseEnPassant];
            }
            else {
                ajoutPositionnel += this.tourBlanc ? this.evaluationCasesPion[coup.priseEnPassant] : - this.evaluationCasesPion[63 - coup.priseEnPassant];
            }
        }

        else if (coup.promotion != -1) {
            this.balanceMaterielBlanc += this.tourBlanc ? 800 : -800;
            if (!(JouerCoup)) {
                ajoutPositionnel += this.tourBlanc ? this.evaluationCasesReine[coup.positionDepart] : - this.evaluationCasesReine[coup.positionDepart];
                ajoutPositionnel += this.tourBlanc ? - this.evaluationCasesPion[63 - coup.positionDepart] : this.evaluationCasesPion[coup.positionDepart];
            }
            else {
                ajoutPositionnel += this.tourBlanc ? this.evaluationCasesReine[coup.positionDepart] : - this.evaluationCasesReine[coup.positionDepart];
                ajoutPositionnel += this.tourBlanc ? - this.evaluationCasesPion[coup.positionDepart] : this.evaluationCasesPion[63 - coup.positionDepart];
            }
        }

        // if (this.materielBlanc > 1500 && this.materielNoir > 1500) {
        //     this.etatJeu = MIDGAME;
        // }
        // else {
        //     this.etatJeu = ENDGAME;
        // }

        this.balanceMaterielBlanc += ajoutPositionnel;
    }

    public void InitialiserBitboards() {

        // On initialise les deplacement de toutes les pieces sur toutes les cases de
        // l'echequier pour ne pas avoir a les recalculer plus tard

        Piece[] pieces = new Piece[] { new Cavalier(1), new Fou(1), new Tour(1), new Reine(1), new Roi(1), new Pion(0),
                new Pion(1) };
        PIECES_COUPS = new long[][] { this.CAVALIER_COUPS, this.FOU_COUPS, this.TOUR_COUP, this.REINE_COUPS,
                this.ROI_COUPS, this.PION_B_PRISES, this.PION_N_PRISES, this.PION_B_DEPLACEMENT,
                this.PION_N_DEPLACEMENT };

        for (int piece = 0; piece < PIECES_COUPS.length - 4; piece++) {
            for (int position = 0; position < 64; position++) {
                this.PIECES_COUPS[piece][position] = pieces[piece].RenvoyerCoupPossibles(position, 0L);
            }
        }
        for (int couleur = 0; couleur < 2; couleur++) {
            for (int position = 0; position < 64; position++) {
                this.PIECES_COUPS[5 + couleur][position] = ((Pion) pieces[5 + couleur]).RenvoyerCasesMenacees(position);
            }
        }
        for (int couleur = 0; couleur < 2; couleur++) {
            for (int position = 0; position < 64; position++) {
                this.PIECES_COUPS[7 + couleur][position] = ((Pion) pieces[5 + couleur]).RenvoyerCoupPossibles(position,
                        0L);
            }
        }
    }

    public long PiecesMenacantCase(int caseAttaquee, int couleurEnnemie) {

        long positionPiecesEnnemies = couleurEnnemie == 1 ? positionPiecesNoires : positionPiecesBlanches;

        long menacesTour = new Tour(0).RenvoyerCoupPossibles(caseAttaquee, this.positionsPieces);
        long menacesFou = new Fou(0).RenvoyerCoupPossibles(caseAttaquee, this.positionsPieces);
        long[] PION_COUPS_ENNEMI = couleurEnnemie == 0 ? this.PION_N_PRISES : this.PION_B_PRISES;

        long attaquant = 0L;

        // On calcule les pieces qui menacent la case
        attaquant |= (CAVALIER_COUPS[caseAttaquee] & this.positionCavalier & positionPiecesEnnemies);
        attaquant |= (PION_COUPS_ENNEMI[caseAttaquee] & this.positionPion & positionPiecesEnnemies);
        attaquant |= (menacesTour & (this.positionTours + this.positionReine) & positionPiecesEnnemies);
        attaquant |= (menacesFou & (this.positionFous + this.positionReine) & positionPiecesEnnemies);

        return attaquant;
    }

    public long CasesMenacees(int couleurEnnemie, int positionRoi) {

        // Les positions des pieces ennemies
        long positionPiecesEnnemies = couleurEnnemie == 1 ? this.positionPiecesNoires : this.positionPiecesBlanches;
        long positionsPions = this.positionPion & positionPiecesEnnemies;
        long positionReine = this.positionReine & positionPiecesEnnemies;
        long positionCavalier = this.positionCavalier & positionPiecesEnnemies;
        long positionFous = this.positionFous & positionPiecesEnnemies;
        long positionTours = this.positionTours & positionPiecesEnnemies;
        long positionRoiEnnemi = this.positionRoi & positionPiecesEnnemies;

        long plateauSansRoi = this.positionsPieces & BitBoard.InverserBits(BitBoard.creerBoard(positionRoi));

        long[] PION_PRISE_ENNEMI = couleurEnnemie == 1 ? this.PION_N_PRISES : this.PION_B_PRISES;
        long casesMenacees = 0L;

        // Les cases menacees des pions
        while (positionsPions != 0) {
            int pion = BitBoard.exposant(positionsPions & -positionsPions);
            casesMenacees |= PION_PRISE_ENNEMI[pion];
            positionsPions &= positionsPions - 1;
        }

        // Les cases menacees des cavaliers
        while (positionCavalier != 0) {
            int cavalier = BitBoard.exposant(positionCavalier & -positionCavalier);
            casesMenacees |= CAVALIER_COUPS[cavalier];
            positionCavalier &= positionCavalier - 1;
        }

        // Les cases menacees des fous
        while (positionFous != 0) {
            int fou = BitBoard.exposant(positionFous & -positionFous);
            casesMenacees |= this.echequierPositions[fou].RenvoyerCoupPossibles(fou, plateauSansRoi);
            positionFous &= positionFous - 1;
        }

        // Les cases menacees des tours
        while (positionTours != 0) {
            int tour = BitBoard.exposant(positionTours & -positionTours);
            casesMenacees |= this.echequierPositions[tour].RenvoyerCoupPossibles(tour, plateauSansRoi);
            positionTours &= positionTours - 1;
        }

        // Les cases menacees du roi
        int roi = BitBoard.exposant(positionRoiEnnemi);
        casesMenacees |= ROI_COUPS[roi];

        // Les cases menacees de la dame
        while (positionReine != 0) {
            int dame = BitBoard.exposant(positionReine);
            casesMenacees |= this.echequierPositions[dame].RenvoyerCoupPossibles(dame, plateauSansRoi);
            positionReine &= positionReine - 1;
        }
        return casesMenacees;

    }

    // Renvoie la position des pices pinned

    public long GenererPiecesPinned(int couleurEnnemie, int positionRoi) {

        long positionPiecesAllies = couleurEnnemie == 0 ? positionPiecesNoires : positionPiecesBlanches;
        long positionPiecesEnnemie = couleurEnnemie == 1 ? positionPiecesNoires : positionPiecesBlanches;
        Piece Reine = new Reine(0);
        long menacesDame = Reine.RenvoyerCoupPossibles(positionRoi, this.positionsPieces);

        // On calcule les pieces qui sont potentiellement pinned
        long piecesAVerifier = (menacesDame & positionPiecesAllies);
        long piecesPinned = 0L;

        while (piecesAVerifier != 0) {
            long casePiece = piecesAVerifier & -piecesAVerifier;
            long masque = this.MASQUEDROITE[BitBoard.IndiceMasqueDroites(BitBoard.exposant(casePiece), positionRoi)];
            long pieceEnnemie = Reine.RenvoyerCoupPossibles(BitBoard.exposant(casePiece), this.positionsPieces
                    | masque)
                    & (positionPiecesEnnemie & BitBoard.InverserBits(masque));
            if (pieceEnnemie != 0) {
                int casePieceEnnemie = BitBoard.exposant(pieceEnnemie);
                if ((this.echequierPositions[casePieceEnnemie] instanceof Fou
                        || this.echequierPositions[casePieceEnnemie] instanceof Reine)
                        && BitBoard.EstDiagonale(casePiece, pieceEnnemie, positionRoi)) {
                    piecesPinned |= casePiece;

                } else if (BitBoard.EstLigneColonne(casePiece, pieceEnnemie, positionRoi)
                        && (this.echequierPositions[casePieceEnnemie] instanceof Tour
                                || this.echequierPositions[casePieceEnnemie] instanceof Reine)) {
                    piecesPinned |= casePiece;
                }
            }
            piecesAVerifier &= piecesAVerifier - 1;
        }
        return piecesPinned;
    }

    public void AjouterCoupsLegauxPieceGlissante(ListeCoup coups, long positionPieces, long piecesPinned,
            long masqueCoup, long positionPiecesAllies, int positionRoi) {
        while (positionPieces != 0) {
            long coupsPossibles;
            long posPiece = positionPieces & -positionPieces;
            int piece = BitBoard.exposant(posPiece);
            if ((piecesPinned & posPiece) == 0L) {
                coupsPossibles = this.echequierPositions[piece].RenvoyerCoupPossibles(piece, this.positionsPieces)
                        & masqueCoup
                        & BitBoard.InverserBits(positionPiecesAllies);
            } else {
                long masquePinned = this.MASQUEDROITE[BitBoard.IndiceMasqueDroites(piece, positionRoi)];
                coupsPossibles = this.echequierPositions[piece].RenvoyerCoupPossibles(piece,
                        this.positionsPieces | masquePinned) & masqueCoup
                        & BitBoard.InverserBits(positionPiecesAllies | masquePinned);
            }
            while (coupsPossibles != 0) {
                long caseArrivee = coupsPossibles & -coupsPossibles;
                coups.add(new Coup(piece, BitBoard.exposant(caseArrivee)));
                coupsPossibles &= coupsPossibles - 1;
            }
            positionPieces &= positionPieces - 1;
        }
    }

    /**
     * Renvoie les coups d'une position
     * 
     * @return une liste des coups possibles
     */
    public ListeCoup CoupLegaux() {

        int couleurEnnemie = this.tourBlanc ? 1 : 0;

        // Les pieces ennemies et allies
        long positionPiecesAllies = this.tourBlanc ? positionPiecesBlanches : positionPiecesNoires;
        long positionPiecesEnnemies = this.tourBlanc ? positionPiecesNoires : positionPiecesBlanches;

        // Les positions des pieces alliees
        long positionPions = this.positionPion & positionPiecesAllies;
        long positionReine = this.positionReine & positionPiecesAllies;
        long positionCavaliers = this.positionCavalier & positionPiecesAllies;
        long positionFous = this.positionFous & positionPiecesAllies;
        long positionTours = this.positionTours & positionPiecesAllies;

        // Les mouvements de pions ennemis

        long[] PION_PRISES_ALLIES = this.tourBlanc ? this.PION_B_PRISES : this.PION_N_PRISES;

        // Les pieces qui menacent le roi
        int positionRoi = BitBoard.exposant(positionPiecesAllies & this.positionRoi);
        long attaquants = this.PiecesMenacantCase(positionRoi, couleurEnnemie);

        long piecesPinned = this.GenererPiecesPinned(couleurEnnemie, positionRoi);

        // Les coups a retourner
        ListeCoup coups = new ListeCoup(200);

        long casesMenacees = this.CasesMenacees(couleurEnnemie, positionRoi);

        int nbAttaquants = BitBoard.NbBits(attaquants);

        long bloquerEchec = 0xFFFFFFFFFFFFFFFFL;

        if (attaquants == 0L) {
            attaquants = 0xFFFFFFFFFFFFFFFFL;
        }
        // Si le roi en double echec
        if (nbAttaquants > 1) {
            // seul le roi peut bouger et seulement sur une case non menacee
            bloquerEchec = 0L;
            attaquants = 0L;
        }

        // Si le roi est en echec
        else if (nbAttaquants == 1) {
            int positionAttaquant = BitBoard.exposant(attaquants);
            Piece pieceAttaquant = this.echequierPositions[positionAttaquant];
            if (pieceAttaquant instanceof Fou || pieceAttaquant instanceof Tour || pieceAttaquant instanceof Reine) {
                bloquerEchec = BitBoard.LigneBitBoard(positionAttaquant, positionRoi);
            } else {
                bloquerEchec = 0L;
            }
        }

        // Les coups du roi hors roque
        long coupsPossibles = this.ROI_COUPS[positionRoi] & BitBoard.InverserBits(positionPiecesAllies)
                & BitBoard.InverserBits(casesMenacees);

        while (coupsPossibles != 0) {
            long caseArrivee = coupsPossibles & -coupsPossibles;
            coups.add(new Coup(positionRoi, BitBoard.exposant(caseArrivee)));
            coupsPossibles &= coupsPossibles - 1;
        }

        // On regarde le roque
        if (this.echequierPositions[positionRoi].RenvoyerRoque() && nbAttaquants == 0) {

            // roque a droite
            if (this.echequierPositions[positionRoi + 3].RenvoyerRoque()) {
                long masqueRoque = BitBoard.creerBoard(positionRoi + 1) | BitBoard.creerBoard(positionRoi + 2);
                if (((masqueRoque & this.positionsPieces) == 0L) && ((masqueRoque & casesMenacees) == 0L)) {
                    coups.add(new Coup(positionRoi, positionRoi + 2, positionRoi + 3, -1));
                }
            }

            // roque a gauche
            if (this.echequierPositions[positionRoi - 4].RenvoyerRoque()) {
                long masqueRoque = BitBoard.creerBoard(positionRoi - 1) | BitBoard.creerBoard(positionRoi - 2)
                        | BitBoard.creerBoard(positionRoi - 3);
                if (((masqueRoque & this.positionsPieces) == 0L) && ((masqueRoque & casesMenacees) == 0L)) {
                    coups.add(new Coup(positionRoi, positionRoi - 2, positionRoi - 4, -1));
                }
            }
        }

        long masqueCoup = (attaquants | bloquerEchec);

        // On ajoute les coups de la reine, des fous et des tours et les deplacements
        // sans prises des pions

        this.AjouterCoupsLegauxPieceGlissante(coups, positionFous, piecesPinned, masqueCoup, positionPiecesAllies,
                positionRoi);
        this.AjouterCoupsLegauxPieceGlissante(coups, positionTours, piecesPinned, masqueCoup, positionPiecesAllies,
                positionRoi);
        this.AjouterCoupsLegauxPieceGlissante(coups, positionReine, piecesPinned, masqueCoup, positionPiecesAllies,
                positionRoi);
        this.AjouterCoupsLegauxPieceGlissante(coups, positionPions, piecesPinned, masqueCoup, positionPiecesAllies,
                positionRoi);

        // Les coups des cavaliers
        while (positionCavaliers != 0) {
            long posCavalier = positionCavaliers & -positionCavaliers;
            int cavalier = BitBoard.exposant(posCavalier);
            if ((piecesPinned & posCavalier) == 0L) {
                coupsPossibles = CAVALIER_COUPS[cavalier] & masqueCoup & BitBoard.InverserBits(positionPiecesAllies);
            } else {
                coupsPossibles = 0;
            }
            while (coupsPossibles != 0) {
                long caseArrivee = coupsPossibles & -coupsPossibles;
                coups.add(new Coup(cavalier, BitBoard.exposant(caseArrivee)));
                coupsPossibles &= coupsPossibles - 1;
            }
            positionCavaliers &= positionCavaliers - 1;
        }

        long positionPionCopie = positionPions;

        // Les coups des pions 2) deplacement avec prise
        while (positionPionCopie != 0) {
            long posPion = positionPionCopie & -positionPionCopie;
            int pion = BitBoard.exposant(posPion);
            if ((piecesPinned & posPion) == 0L) {
                coupsPossibles = PION_PRISES_ALLIES[pion] & masqueCoup & (positionPiecesEnnemies);
            } else {

                long masquePinned = this.MASQUEDROITE[BitBoard.IndiceMasqueDroites(pion, positionRoi)];
                coupsPossibles = PION_PRISES_ALLIES[pion] & masqueCoup & positionPiecesEnnemies
                        & BitBoard.InverserBits(masquePinned);
            }
            // prises en passant
            if ((PION_PRISES_ALLIES[pion] & (this.casePriseEnPassant)) != 0L) {
                if (this.EnPassantLegal(positionRoi, couleurEnnemie, pion)) {
                    int direction = this.tourBlanc ? 1 : -1;
                    coups.add(new Coup(pion, BitBoard.exposant(this.casePriseEnPassant), -1,
                            BitBoard.exposant(this.casePriseEnPassant) + 8 * direction));
                }
            }
            while (coupsPossibles != 0) {
                long caseArrivee = coupsPossibles & -coupsPossibles;
                int casearrivee = BitBoard.exposant(caseArrivee);
                coups.add(new Coup(pion, casearrivee));
                coupsPossibles &= coupsPossibles - 1;
            }
            positionPionCopie &= positionPionCopie - 1;
        }

        positionPionCopie = positionPions;

        return coups;

    }

    public boolean RoiEnEchec(int couleurEnnemie) {
        long positionRoi = couleurEnnemie == 1 ? (this.positionRoi & this.positionPiecesBlanches)
                : (this.positionRoi & this.positionPiecesNoires);
        return this.RoiEnEchec(BitBoard.exposant(positionRoi), couleurEnnemie);
    }

    public boolean RoiEnEchec(int positionRoi, int couleurEnnemie) {

        // Les positions des pieces ennemies
        long positionPiecesEnnemies = couleurEnnemie == 1 ? this.positionPiecesNoires : this.positionPiecesBlanches;
        long positionsPions = this.positionPion & positionPiecesEnnemies;
        long positionReine = this.positionReine & positionPiecesEnnemies;
        long positionCavalier = this.positionCavalier & positionPiecesEnnemies;
        long positionFous = this.positionFous & positionPiecesEnnemies;
        long positionTours = this.positionTours & positionPiecesEnnemies;

        long positionRoiAllie = BitBoard.creerBoard(positionRoi);

        long[] PION_PRISE_ENNEMI = couleurEnnemie == 1 ? this.PION_N_PRISES : this.PION_B_PRISES;
        long echec = 0L;
        // Les cases menacees des pions
        while (positionsPions != 0) {
            int pion = BitBoard.exposant(positionsPions & -positionsPions);
            echec |= PION_PRISE_ENNEMI[pion] & positionRoiAllie;
            if (echec != 0L) {
                return true;
            }
            positionsPions &= positionsPions - 1;
        }

        // Les cases menacees des cavaliers
        while (positionCavalier != 0) {
            int cavalier = BitBoard.exposant(positionCavalier & -positionCavalier);
            echec |= CAVALIER_COUPS[cavalier] & positionRoiAllie;
            if (echec != 0L) {
                return true;
            }
            positionCavalier &= positionCavalier - 1;
        }

        // Les cases menacees des fous
        while (positionFous != 0) {
            int fou = BitBoard.exposant(positionFous & -positionFous);
            echec |= this.echequierPositions[fou].RenvoyerCoupPossibles(fou, this.positionsPieces) & positionRoiAllie;
            if (echec != 0L) {
                return true;
            }
            positionFous &= positionFous - 1;
        }

        // Les cases menacees des tours
        while (positionTours != 0) {
            int tour = BitBoard.exposant(positionTours & -positionTours);
            echec |= this.echequierPositions[tour].RenvoyerCoupPossibles(tour, this.positionsPieces) & positionRoiAllie;
            if (echec != 0L) {
                return true;
            }
            positionTours &= positionTours - 1;
        }

        // Les cases menacees de la dame
        if (positionReine != 0) {
            int dame = BitBoard.exposant(positionReine);
            echec |= this.echequierPositions[dame].RenvoyerCoupPossibles(dame, this.positionsPieces) & positionRoiAllie;
            if (echec != 0L) {
                return true;
            }
        }
        return false;
    }

    public boolean EnPassantLegal(int positionRoi, int couleurEnnemie, int pion) {

        boolean legal = true;
        int direction = this.tourBlanc ? 1 : -1;
        Coup priseEnPassant = new Coup(pion, BitBoard.exposant(this.casePriseEnPassant), -1,
                BitBoard.exposant(this.casePriseEnPassant) + 8 * direction);
        this.JouerCoup(priseEnPassant);
        if (this.RoiEnEchec(positionRoi, couleurEnnemie)) {
            legal = false;
        }
        this.DejouerCoup(priseEnPassant);
        return legal;
    }

    public Coup[] CoupLegaux(int casePiece) {

        // On verifie qu'il y a des coups legaux

        ListeCoup coupsLegaux = this.CoupLegaux();
        if (coupsLegaux == null) {
            return null;
        }

        // On ne selectionne que les coups de la piece selectionnée
        Coup[] coupsLegauxPiece = new Coup[40];
        int compteurListePiece = 0;
        int compteurBoucle = 0;

        Coup coup = coupsLegaux.get(0);
        while (coup != null) {
            if (coup.positionDepart == casePiece) {
                coupsLegauxPiece[compteurListePiece] = coup;
                compteurListePiece++;
            }
            compteurBoucle++;
            coup = coupsLegaux.get(compteurBoucle);

        }
        return coupsLegauxPiece;
    }

    public int RenvoyerEvaluation() {
        return this.balanceMaterielBlanc;
    }

    public void JouerCoup(Coup coup) {

        // On recupere les infos du coup
        int positionDepart = coup.positionDepart;
        long caseDepart = BitBoard.creerBoard(positionDepart);
        int positionArivee = coup.positionArivee;
        long caseArrivee = BitBoard.creerBoard(positionArivee);

        long positionPiecesAllies = this.tourBlanc ? positionPiecesBlanches : positionPiecesNoires;
        long positionPiecesEnnemies = this.tourBlanc ? positionPiecesNoires : positionPiecesBlanches;

        Piece pieceMangee = this.echequierPositions[positionArivee];
        Piece pieceBougee = this.echequierPositions[positionDepart];

        // Si un roque est possible pour la piece qui bouge, on garde l'info
        coup.roqueLegal = pieceBougee.RenvoyerRoque();

        // On empeche les pieces qui bougent de roquer
        pieceBougee.PlusDeRoque();

        // Si une prise en passant est posible durant ce tour, on garde l'info
        if (this.casePriseEnPassant != 0L) {
            int direction = this.tourBlanc ? 1 : -1;
            coup.pionAvancee2 = BitBoard.exposant(this.casePriseEnPassant) + 8 * direction;
        }

        // Si un pion avance de 2, il peut etre pris en passant
        if (pieceBougee instanceof Pion && Math.abs(positionDepart - positionArivee) == 16) {
            int direction = this.tourBlanc ? 1 : -1;
            this.casePriseEnPassant = BitBoard.creerBoard(positionArivee + 8 * direction);
        } else {
            this.casePriseEnPassant = 0L;
        }

        coup.pieceMangee = pieceMangee;

        // On met l'echequier a jour

        this.echequierPositions[positionArivee] = this.echequierPositions[positionDepart];
        this.echequierPositions[positionDepart] = new CaseVide(-1);
        positionPiecesAllies = (BitBoard.InverserBits(caseDepart) & positionPiecesAllies) | caseArrivee;
        positionPiecesEnnemies &= BitBoard.InverserBits(caseArrivee);

        // On le met a jour dans le cas d'une prise en passant
        if (coup.priseEnPassant != -1) {
            this.echequierPositions[coup.priseEnPassant] = new CaseVide(-1);
            positionPiecesEnnemies &= BitBoard.InverserBits(BitBoard.creerBoard(coup.priseEnPassant));
            this.positionPion &= BitBoard.InverserBits(BitBoard.creerBoard(coup.priseEnPassant));
        }

        // On le met a jour dans le cas d'un roque
        if (coup.roque != -1) {
            int caseArriveeTour = (coup.positionDepart - coup.positionArivee) > 0 ? coup.positionDepart - 1
                    : coup.positionDepart + 1;
            this.echequierPositions[caseArriveeTour] = this.echequierPositions[coup.roque];
            this.echequierPositions[coup.roque] = new CaseVide(-1);
            long positionArriveeTour = BitBoard.creerBoard(caseArriveeTour);
            long positionDepartTour = BitBoard.creerBoard(coup.roque);
            positionPiecesAllies = (BitBoard.InverserBits(positionDepartTour) & positionPiecesAllies)
                    | positionArriveeTour;
            this.positionTours = (BitBoard.InverserBits(positionDepartTour) & this.positionTours) | positionArriveeTour;
        }

        this.positionsPieces = positionPiecesAllies | positionPiecesEnnemies;

        this.MettreAJourBitBoards(pieceBougee, pieceMangee, caseDepart, caseArrivee);

        // On le met a jour dans le cas d'une promotion
        if (pieceBougee instanceof Pion && (positionArivee / 8 == 0 | positionArivee / 8 == 7)) {
            int couleur = this.tourBlanc ? 0 : 1;
            this.echequierPositions[positionArivee] = new Reine(couleur);
            this.positionReine |= caseArrivee;
            this.positionPion &= BitBoard.InverserBits(caseArrivee);
            coup.promotion = 1;
        }

        this.MettreAJourEvaluation(coup, true);

        if (this.tourBlanc) {
            this.positionPiecesBlanches = positionPiecesAllies;
            this.positionPiecesNoires = positionPiecesEnnemies;
        } else {
            this.positionPiecesNoires = positionPiecesAllies;
            this.positionPiecesBlanches = positionPiecesEnnemies;
        }

        this.tourBlanc = !this.tourBlanc;

    }

    public void DejouerCoup(Coup coup) {

        this.MettreAJourEvaluation(coup, false);

        // On recupere les infos du coup
        int positionDepart = coup.positionDepart;
        long caseDepart = BitBoard.creerBoard(positionDepart);
        int positionArivee = coup.positionArivee;
        long caseArrivee = BitBoard.creerBoard(positionArivee);

        long positionPiecesAllies = !this.tourBlanc ? positionPiecesBlanches : positionPiecesNoires;
        long positionPiecesEnnemies = !this.tourBlanc ? positionPiecesNoires : positionPiecesBlanches;

        Piece pieceBougee = this.echequierPositions[positionArivee];

        // On met l'echequier a jour

        this.echequierPositions[positionDepart] = pieceBougee;
        this.echequierPositions[positionArivee] = coup.pieceMangee;

        positionPiecesAllies = (BitBoard.InverserBits(caseArrivee) & positionPiecesAllies) | caseDepart;

        if (!(coup.pieceMangee instanceof CaseVide)) {
            positionPiecesEnnemies |= caseArrivee;
        }

        // dans le cas d'une prise en passant
        if (coup.priseEnPassant != -1) {
            int couleurEnnemie = this.tourBlanc ? 0 : 1;
            this.echequierPositions[coup.priseEnPassant] = new Pion(couleurEnnemie);
            positionPiecesEnnemies |= BitBoard.creerBoard(coup.priseEnPassant);
            this.positionPion |= BitBoard.creerBoard(coup.priseEnPassant);
        }

        // Dans le cas d'un roque
        if (coup.roque != -1) {
            int positionTourDepart = (coup.positionDepart - coup.positionArivee) > 0 ? coup.positionDepart - 1
                    : coup.positionDepart + 1;
            long caseTourDepart = BitBoard.creerBoard(positionTourDepart);
            long caseTourArivee = BitBoard.creerBoard(coup.roque);
            this.echequierPositions[coup.roque] = this.echequierPositions[positionTourDepart];
            this.echequierPositions[positionTourDepart] = new CaseVide(-1);
            positionPiecesAllies = (BitBoard.InverserBits(caseTourDepart) & positionPiecesAllies) | caseTourArivee;
            this.positionTours = (BitBoard.InverserBits(caseTourDepart) & this.positionTours) | caseTourArivee;
        }

        this.positionsPieces = positionPiecesAllies | positionPiecesEnnemies;

        this.MettreAJourBitBoards(pieceBougee, new CaseVide(-1), caseArrivee, caseDepart);

        if (!(coup.pieceMangee instanceof CaseVide)) {
            this.MettreAJourBitBoards(coup.pieceMangee, new CaseVide(-1), caseArrivee, caseArrivee);
        }

        // Promotion
        if (coup.promotion != -1) {
            int couleur = this.tourBlanc ? 1 : 0;
            this.echequierPositions[positionDepart] = new Pion(couleur);
            this.positionReine &= BitBoard.InverserBits(caseDepart);
            this.positionPion |= caseDepart;
        }

        

        if (!this.tourBlanc) {
            this.positionPiecesBlanches = positionPiecesAllies;
            this.positionPiecesNoires = positionPiecesEnnemies;
        } else {
            this.positionPiecesNoires = positionPiecesAllies;
            this.positionPiecesBlanches = positionPiecesEnnemies;
        }

        

        // On remet la possibilité de faire une prise en passant
        if (coup.pionAvancee2 != -1) {
            int direction = this.tourBlanc ? 1 : -1;
            this.casePriseEnPassant = BitBoard.creerBoard(coup.pionAvancee2 + 8 * direction);
        }

        // On remet la possibilité de roquer
        if (coup.roqueLegal) {
            pieceBougee.RemettreRoque();
        }

        this.tourBlanc = !this.tourBlanc;

    }

    public void MettreAJourBitBoards(Piece piece, Piece pieceMangee, long caseDepart, long caseArrivee) {
        // On met a jour la piece qui se fait mangee
        if (!(pieceMangee instanceof CaseVide)) {

            if (pieceMangee instanceof Tour) {
                this.positionTours = (BitBoard.InverserBits(caseArrivee) & this.positionTours);
            } else if (pieceMangee instanceof Cavalier) {
                this.positionCavalier = (BitBoard.InverserBits(caseArrivee) & this.positionCavalier);
            } else if (pieceMangee instanceof Fou) {
                this.positionFous = (BitBoard.InverserBits(caseArrivee) & this.positionFous);
            } else if (pieceMangee instanceof Reine) {
                this.positionReine = (BitBoard.InverserBits(caseArrivee) & this.positionReine);
            } else if (pieceMangee instanceof Pion) {
                this.positionPion = (BitBoard.InverserBits(caseArrivee) & this.positionPion);
            }
        }

        // On met a jour la piece qui bouge
        if (piece instanceof Tour) {
            this.positionTours = (BitBoard.InverserBits(caseDepart) & this.positionTours) | caseArrivee;
        } else if (piece instanceof Cavalier) {
            this.positionCavalier = (BitBoard.InverserBits(caseDepart) & this.positionCavalier) | caseArrivee;
        } else if (piece instanceof Fou) {
            this.positionFous = (BitBoard.InverserBits(caseDepart) & this.positionFous) | caseArrivee;
        } else if (piece instanceof Reine) {
            this.positionReine = (BitBoard.InverserBits(caseDepart) & this.positionReine) | caseArrivee;
        } else if (piece instanceof Roi) {
            this.positionRoi = (BitBoard.InverserBits(caseDepart) & this.positionRoi) | caseArrivee;
        } else if (piece instanceof Pion) {
            this.positionPion = (BitBoard.InverserBits(caseDepart) & this.positionPion) | caseArrivee;
        }
    }

    /**
     * @param codeString Cette fonction convertit une chaine de caractère au format
     *                   echec officiel en position de plateau
     */

    Plateau(String codeString, boolean chrono, boolean coms) throws CodeIncorrectException {
    	fenetrePrincipale = new FenetreDeJeu(this, chrono);
        int position = 0;
        char[] codeListe = codeString.toCharArray();
        try {
	        if (codeListe.length < 64 && codeListe.length != 0) {
	        	this.fenetrePrincipale.initialiserFenetre();
		        for (int i = 0; i < codeListe.length; i++) {
		            if (codeListe[i] == 'P') {
		                this.echequierPositions[position] = new Pion(0);
		                this.positionPiecesBlanches |= BitBoard.creerBoard(position);
		                this.positionPion |= BitBoard.creerBoard(position);
		                this.materielBlanc += this.echequierPositions[position].RenvoyerValeur();
		                this.balanceMaterielBlanc += this.RenvoyerEvaluationCase(this.echequierPositions[position], position);
		                this.fenetrePrincipale.poserPiece(1, position);
		
		            } else if (codeListe[i] == 'B') {
		                this.echequierPositions[position] = new Fou(0);
		                this.fenetrePrincipale.poserPiece(2, position);
		                this.positionPiecesBlanches |= BitBoard.creerBoard(position);
		                this.materielBlanc += this.echequierPositions[position].RenvoyerValeur();
		                this.balanceMaterielBlanc += this.RenvoyerEvaluationCase(this.echequierPositions[position], position);
		                this.positionFous |= BitBoard.creerBoard(position);
		
		            } else if (codeListe[i] == 'R') {
		                this.echequierPositions[position] = new Tour(0);
		                this.fenetrePrincipale.poserPiece(3, position);
		                this.positionPiecesBlanches |= BitBoard.creerBoard(position);
		                this.materielBlanc += this.echequierPositions[position].RenvoyerValeur();
		                this.balanceMaterielBlanc += this.RenvoyerEvaluationCase(this.echequierPositions[position], position);
		                this.positionTours |= BitBoard.creerBoard(position);
		
		            } else if (codeListe[i] == 'N') {
		                this.echequierPositions[position] = new Cavalier(0);
		                this.fenetrePrincipale.poserPiece(4, position);
		                this.positionPiecesBlanches |= BitBoard.creerBoard(position);
		                this.materielBlanc += this.echequierPositions[position].RenvoyerValeur();
		                this.balanceMaterielBlanc += this.RenvoyerEvaluationCase(this.echequierPositions[position], position);
		                this.positionCavalier |= BitBoard.creerBoard(position);
		
		            } else if (codeListe[i] == 'Q') {
		                this.echequierPositions[position] = new Reine(0);
		                this.fenetrePrincipale.poserPiece(5, position);
		                this.positionPiecesBlanches |= BitBoard.creerBoard(position);
		                this.materielBlanc += this.echequierPositions[position].RenvoyerValeur();
		                this.balanceMaterielBlanc += this.RenvoyerEvaluationCase(this.echequierPositions[position], position);
		                this.positionReine |= BitBoard.creerBoard(position);
		
		            } else if (codeListe[i] == 'K') {
		                this.echequierPositions[position] = new Roi(0);
		                if (position != 60) {
		                    this.echequierPositions[position].PlusDeRoque();
		                }
		                this.fenetrePrincipale.poserPiece(6, position);
		                this.positionPiecesBlanches |= BitBoard.creerBoard(position);
		                this.materielBlanc += this.echequierPositions[position].RenvoyerValeur();
		                this.balanceMaterielBlanc += this.RenvoyerEvaluationCase(this.echequierPositions[position], position);
		                this.positionRoi |= BitBoard.creerBoard(position);
		
		            } else if (codeListe[i] == 'p') {
		                this.echequierPositions[position] = new Pion(1);
		                this.fenetrePrincipale.poserPiece(9, position);
		                this.positionPiecesNoires |= BitBoard.creerBoard(position);
		                this.materielNoir += this.echequierPositions[position].RenvoyerValeur();
		                this.balanceMaterielBlanc -= this.RenvoyerEvaluationCase(this.echequierPositions[position], position);
		                this.positionPion |= BitBoard.creerBoard(position);
		
		            } else if (codeListe[i] == 'b') {
		                this.echequierPositions[position] = new Fou(1);
		                this.fenetrePrincipale.poserPiece(10, position);
		                this.positionPiecesNoires |= BitBoard.creerBoard(position);
		                this.materielNoir += this.echequierPositions[position].RenvoyerValeur();
		                this.balanceMaterielBlanc -= this.RenvoyerEvaluationCase(this.echequierPositions[position], position);
		                this.positionFous |= BitBoard.creerBoard(position);
		
		            } else if (codeListe[i] == 'r') {
		                this.echequierPositions[position] = new Tour(1);
		                this.fenetrePrincipale.poserPiece(11, position);
		                this.positionPiecesNoires |= BitBoard.creerBoard(position);
		                this.materielNoir += this.echequierPositions[position].RenvoyerValeur();
		                this.balanceMaterielBlanc -= this.RenvoyerEvaluationCase(this.echequierPositions[position], position);
		                this.positionTours |= BitBoard.creerBoard(position);
		
		            } else if (codeListe[i] == 'n') {
		                this.echequierPositions[position] = new Cavalier(1);
		                this.fenetrePrincipale.poserPiece(12, position);
		                this.positionPiecesNoires |= BitBoard.creerBoard(position);
		                this.materielNoir += this.echequierPositions[position].RenvoyerValeur();
		                this.balanceMaterielBlanc -= this.RenvoyerEvaluationCase(this.echequierPositions[position], position);
		                this.positionCavalier |= BitBoard.creerBoard(position);
		
		            } else if (codeListe[i] == 'q') {
		                this.echequierPositions[position] = new Reine(1);
		                this.fenetrePrincipale.poserPiece(13, position);
		                this.positionPiecesNoires |= BitBoard.creerBoard(position);
		                this.materielNoir += this.echequierPositions[position].RenvoyerValeur();
		                this.balanceMaterielBlanc -= this.RenvoyerEvaluationCase(this.echequierPositions[position], position);
		                this.positionReine |= BitBoard.creerBoard(position);
		
		            } else if (codeListe[i] == 'k') {
		                this.echequierPositions[position] = new Roi(1);
		                if (position != 4) {
		                    this.echequierPositions[position].PlusDeRoque();
		                }
		                this.fenetrePrincipale.poserPiece(14, position);
		                this.positionPiecesNoires |= BitBoard.creerBoard(position);
		                this.materielNoir += this.echequierPositions[position].RenvoyerValeur();
		                this.balanceMaterielBlanc -= this.RenvoyerEvaluationCase(this.echequierPositions[position], position);
		                this.positionRoi |= BitBoard.creerBoard(position);
		
		            } else if (codeListe[i] == '/') {
		                position -= 1;
		
		            } else {
		                for (int j = 0; j < Character.getNumericValue(codeListe[i]); j++) {
		                    this.echequierPositions[position + j] = new CaseVide(-1);
		                }
		                position += Character.getNumericValue(codeListe[i]) - 1;
		            }
		            position += 1;
		
		        }
	        }
	        else {
	        	throw new CodeIncorrectException();
	        }
        } catch (ArrayIndexOutOfBoundsException e) {
        	this.fenetrePrincipale.FermerFenetre();
        	throw new CodeIncorrectException();
        }
        this.positionsPieces = this.positionPiecesBlanches | this.positionPiecesNoires;
        this.balanceMaterielBlanc += this.materielBlanc - this.materielNoir;
        if (this.materielBlanc > 1500 && this.materielNoir > 1500) {
            this.etatJeu = MIDGAME;
        }
        else {
            this.etatJeu = ENDGAME;
        }
        this.InitialiserBitboards();
    }

    static boolean contains(int[] liste, int element) {
        if (liste == null) {
            return false;
        }
        for (int i : liste) {
            if (i == element) {
                return true;
            }
        }
        return false;
    }

    static boolean contains(Coup[] liste, int element) {
        if (liste == null) {
            return false;
        }
        for (Coup coup : liste) {
            if (coup.positionArivee == element) {
                return true;
            }
        }
        return false;
    }

    static int min(int a, int b) {
        if (a < b) {
            return a;
        }
        return b;
    }

    static int max(int a, int b) {
        if (a > b) {
            return a;
        }
        return b;
    }

    static int IndiceListe(int[] liste, int element) {
        for (int i = 0; i < liste.length; i++) {
            if (element == liste[i]) {
                return i;
            }
        }
        return -1;
    }

    static int IndiceListe(Coup[] liste, int element) {
        for (int i = 0; i < liste.length; i++) {
            if (element == liste[i].positionArivee) {
                return i;
            }
        }
        return -1;
    }

    static String ListeToString(int[] liste) {
        String message = "";
        for (int i : liste) {
            message += i + 1;
            message += ".";
        }
        return message;
    }
    
    public boolean tourBlanc() {
    	return this.tourBlanc;
    }

}
