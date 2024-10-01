package code;

public class Pion implements Piece
{

    private int couleur; // 0 pour les blancs et 1 pour les noirs
    private boolean peutRocker = false;
    final int valeur = 100;
    
    public int RenvoyerValeur () {
        return this.valeur;
    }

    Pion (int couleur)
    {
        this.couleur = couleur;
    }

    public boolean RenvoyerRoque ()
    {
        return this.peutRocker;
    }

    public void PlusDeRoque() {
        this.peutRocker = false;
    }

    public int RenvoyerCouleur()
    {
        return this.couleur;
    }

    public void RemettreRoque ()
    {
        this.peutRocker = true;
    }

    public int[] RenvoyerCoupPossibles (int position, Piece[] plateauDeJeu, int[] direction) {
        return null;
    }
    
    @Override
    public long RenvoyerCoupPossibles(int position, long plateauDeJeu) 
    {
        long coupsPossibles = 0;
        int direction = this.couleur == 0 ? -1 : 1;
        int premierRang = direction == -1 ? 6 : 1;

        //deplacement simple ou double du pion
        long coupSimple = BitBoard.creerBoard(position + 8 * direction);
        if ((coupSimple & plateauDeJeu) == 0) {
            coupsPossibles += coupSimple;
            long coupDouble = BitBoard.creerBoard(position + 16 * direction);
            if ((position / 8) == premierRang && (coupDouble & plateauDeJeu) == 0) {
                coupsPossibles += coupDouble;
            }
        }
        return  coupsPossibles;
    }
    public long RenvoyerCasesMenacees(int position){
        long casesMenacees = 0L;
        int direction = this.couleur == 0 ? -1 : 1;
        
        //Prise
        if (BitBoard.colonneValideRoiPion(position,  7 * direction)) {
            casesMenacees += 1L << (position + 7 * direction);
        }
        if (BitBoard.colonneValideRoiPion(position, 9 * direction)) {
            casesMenacees += 1L << (position + 9*direction);
        }
        return  casesMenacees;

    }
    
}
