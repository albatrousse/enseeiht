package code;

public class Roi implements Piece

{

    private int couleur; // 0 pour les blancs et 1 pour les noirs
    private boolean peutRocker = true;
    final int valeur = 0;
    final int[] DEPLACEMENT_ROI = {-9,-8,-7,-1,1,7,8,9};
    
    public int RenvoyerValeur () {
        return this.valeur;
    }


    public void PlusDeRoque() {
        this.peutRocker = false;
    }


    Roi(int couleur) {
        this.couleur = couleur;
    }

    public boolean RenvoyerRoque ()
    {
        return this.peutRocker;
    }

    public int RenvoyerCouleur() {
        return this.couleur;
    }


    public void RemettreRoque ()
    {
        this.peutRocker = true;
    }

    
    @Override
    public long RenvoyerCoupPossibles(int position, long plateauDeJeu) {
        long coupsPossibles = 0;

        for (int deplacement : DEPLACEMENT_ROI) {
            int caseArrivee = position + deplacement;
            if (BitBoard.estValide(caseArrivee) && BitBoard.colonneValideRoiPion(position, deplacement)) {
                long coup = BitBoard.creerBoard(caseArrivee);
                if ((coup & plateauDeJeu) == 0) {
                    coupsPossibles += coup;
                }
            }
        }

        return coupsPossibles;
    }

}
