package code;

public class Cavalier implements Piece {

    private int couleur; // 0 pour les blancs et 1 pour les noirs
    private boolean peutRocker = false;
    final int valeur = 320;
    final int[] DEPLACEMENT_CAVALIER = {-17,-10,15,6,-15,17,10,-6};
    
    public int RenvoyerValeur () {
        return this.valeur;
    }


    Cavalier(int couleur) {
        this.couleur = couleur;
    }

    public int RenvoyerCouleur() {
        return this.couleur;
    }

    public void PlusDeRoque() {
        this.peutRocker = false;
    }

    public void RemettreRoque ()
    {
        this.peutRocker = true;
    }

    public int[] RenvoyerCoupPossibles (int position, Piece[] plateauDeJeu, int[] direction) {
        return null;
    }

    @Override
    public long RenvoyerCoupPossibles(int position, long plateauDeJeu) {
        long coupsPossibles = 0;

        for (int deplacement : DEPLACEMENT_CAVALIER) {
            int caseArrivee = position + deplacement;
            if (BitBoard.estValide(caseArrivee) && BitBoard.colonneValideCavalier(position, deplacement)) {
                long coup = BitBoard.creerBoard(caseArrivee);
                if ((coup & plateauDeJeu) == 0) {
                    coupsPossibles += coup;
                }
            }
        }
        return coupsPossibles;
    }

    

    public boolean RenvoyerRoque ()
    {
        return this.peutRocker;
    }
}
