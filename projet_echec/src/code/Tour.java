package code;

public class Tour implements Piece
{
    private int couleur; // 0 pour les blancs et 1 pour les noirs
    private boolean peutRocker = true;
    final int valeur = 500;
    
    public int RenvoyerValeur () {
        return this.valeur;
    }


    Tour (int couleur)
    {
        this.couleur = couleur;
    }

    public boolean RenvoyerRoque ()
    {
        return this.peutRocker;
    }

    public int RenvoyerCouleur()
    {
        return this.couleur;
    }

    public void PlusDeRoque() {
        this.peutRocker = false;
    }

    public void RemettreRoque ()
    {
        this.peutRocker = true;
    }

    
    
    
    
    @Override
    public long RenvoyerCoupPossibles(int position, long plateauDeJeu) {
        int caseX = position % 8;
        int caseY = position / 8;
        long coupsPossibles = 0;

        // Boucle pour les coups à gauche
        int compteurBoucle = 0;
        while (compteurBoucle != caseX) {
            compteurBoucle++;
            long coup = BitBoard.creerBoard(position - compteurBoucle);
            if ((coup & plateauDeJeu) == 0) {
                coupsPossibles += coup;
            }

            else {
                coupsPossibles += coup;
                compteurBoucle = caseX;
            }
        }

        // Boucle pour les coups à droite
        compteurBoucle = 0;
        while (compteurBoucle != 7 - caseX) {
            compteurBoucle++;
            long coup = BitBoard.creerBoard(position + compteurBoucle);
            if ((coup & plateauDeJeu) == 0) {
                coupsPossibles += coup;
            }

            else {
                coupsPossibles += coup;
                compteurBoucle = 7 - caseX;
            }
        }

        // Boucle pour les coups en bas
        compteurBoucle = 0;
        while (compteurBoucle != caseY) {
            compteurBoucle++;
            long coup = BitBoard.creerBoard(position - 8 * compteurBoucle);
            if ((coup & plateauDeJeu) == 0) {
                coupsPossibles += coup;
            }

            else {
                coupsPossibles += coup;
                compteurBoucle = caseY;
            }

        }

        // Boucle pour les coups en haut
        compteurBoucle = 0;
        while (compteurBoucle != 7 - caseY) {
            compteurBoucle++;
            long coup = BitBoard.creerBoard(position + 8 * compteurBoucle);
            if ((coup & plateauDeJeu) == 0) {
                coupsPossibles += coup;
            }

            else {
                coupsPossibles += coup;
                compteurBoucle = 7 - caseY;
            }

        }
        
        return  coupsPossibles;
    }
}
