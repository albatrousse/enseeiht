package code;

public class Coup {

    int positionDepart;
    int positionArivee;
    int roque = -1;
    int priseEnPassant = -1;
    boolean roqueLegal = false;
    int couleur = -1;
    int pionAvancee2 = -1;
    int promotion = -1;
    Piece pieceMangee;
    int evaluationCoup;

    public Coup(int positionDepart, int positionArivee) {

        this.positionDepart = positionDepart;
        this.positionArivee = positionArivee;

    }

    public Coup(int positionDepart, int positionArivee, int roque, int priseEnPassant) {

        this(positionDepart, positionArivee);
        this.roque = roque;
        this.priseEnPassant = priseEnPassant;

    }

    static void AfficherCoups (Coup[] listeCoups) {
        if (listeCoups == null) {
            System.out.println("Aucun Coup \n");
        }
        else {
            int compteurListe = 0;
            Coup coup = listeCoups[0];
            while (coup != null) {
                System.out.println("Le coup partant en " + coup.positionDepart + " et arrivant en " + coup.positionArivee);
                compteurListe ++;
                coup = listeCoups[compteurListe];
            }
        }
        System.out.println();
    }

}
