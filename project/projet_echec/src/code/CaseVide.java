package code;

public class CaseVide implements Piece
{

    private int couleur; // 0 pour les blancs et 1 pour les noirs et -1 pour vide
    private boolean peutRocker = false;
    final int valeur = 0;
    
    public int RenvoyerValeur () {
        return this.valeur;
    }


    CaseVide (int couleur)
    {
        this.couleur = couleur;
    }

    public int RenvoyerCouleur()
    {
        return this.couleur;
    }

    @Override
    public long RenvoyerCoupPossibles(int position, long plateauDeJeu) {
        return 0L;
    }

    public boolean RenvoyerRoque ()
    {
        return this.peutRocker;
    }

    public void RemettreRoque ()
    {
        this.peutRocker = true;
    }

    public void PlusDeRoque() {
        this.peutRocker = false;
    }

    public int[] RenvoyerCoupPossibles (int position, Piece[] plateauDeJeu, int[] direction) {
        return null;
    }
        
}
