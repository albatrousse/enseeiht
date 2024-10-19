package code;

public interface Piece {


    
    /**
     * renvoye les mouvements d'une piece en fonction de sa position sur le plateau
     * @param position la position de la piece sur le plateau
     * @return les coups possibles
     */
    public long RenvoyerCoupPossibles (int position, long plateauDeJeu);

    /**
     * @return la couleur de la piece, 0: blanc, 1: noir, -1: vide
     */
    public int RenvoyerCouleur ();

    public boolean RenvoyerRoque ();

    public void PlusDeRoque();

    public void RemettreRoque ();

    public int RenvoyerValeur ();
}
