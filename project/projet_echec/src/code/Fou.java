package code;

public class Fou implements Piece {
    private int couleur; // 0 pour les blancs et 1 pour les noirs
    private boolean peutRocker = false;
    final int valeur = 330;

    public int RenvoyerValeur() {
        return this.valeur;
    }

    Fou(int couleur) {
        this.couleur = couleur;
    }

    public int RenvoyerCouleur() {
        return this.couleur;
    }

    public void PlusDeRoque() {
        this.peutRocker = false;
    }

    public void RemettreRoque() {
        this.peutRocker = true;
    }

    public boolean RenvoyerRoque() {
        return this.peutRocker;
    }

    @Override
    public long RenvoyerCoupPossibles(int position, long plateauDeJeu) {
        int caseX = position % 8;
        int caseY = position / 8;
        long coupsPossibles = 0;

        // Boucle pour les coups en diagonale haut gauche

        int compteurBoucle = 0;
        while (compteurBoucle != Plateau.min(caseY, caseX)) {
            compteurBoucle++;
            long coup = BitBoard.creerBoard(position - 9 * compteurBoucle);
            if ((coup & plateauDeJeu) == 0) {
                coupsPossibles += coup;
            }

            else {
                coupsPossibles += coup;
                compteurBoucle = Plateau.min(caseY, caseX);
            }
        }

        // Boucle pour les coups en diagonale haut droit
        compteurBoucle = 0;
        while (compteurBoucle != Plateau.min(caseY, 7 - caseX)) {
            compteurBoucle++;
            long coup = BitBoard.creerBoard(position - 7 * compteurBoucle);
            if ((coup & plateauDeJeu) == 0) {
                coupsPossibles += coup;
            }

            else {
                coupsPossibles += coup;
                compteurBoucle = Plateau.min(caseY, 7 - caseX);
            }

        }

        // Boucle pour les coups en diagonale bas droit
        compteurBoucle = 0;
        while (compteurBoucle != Plateau.min(7 - caseY, 7 - caseX)) {
            compteurBoucle++;
            long coup = BitBoard.creerBoard(position + 9 * compteurBoucle);
            if ((coup & plateauDeJeu) == 0) {
                coupsPossibles += coup;
            }

            else {
                coupsPossibles += coup;
                compteurBoucle = Plateau.min(7 - caseY, 7 - caseX);
            }

        }

        // Boucle pour les coups en diagonale bas gauche
        compteurBoucle = 0;
        while (compteurBoucle != Plateau.min(7 - caseY, caseX)) {
            compteurBoucle++;
            long coup = BitBoard.creerBoard(position + 7 * compteurBoucle);
            if ((coup & plateauDeJeu) == 0) {
                coupsPossibles += coup;
            }

            else {
                coupsPossibles += coup;
                compteurBoucle = Plateau.min(7 - caseY, caseX);
            }

        }


        return coupsPossibles;
    }

}
