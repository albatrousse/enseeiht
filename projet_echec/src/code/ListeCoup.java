package code;

public class ListeCoup {

    private Coup[] listeCoup;
    private int taille;
    private int tailleMax;

    public ListeCoup(int tailleMax) {
        this.listeCoup = new Coup[tailleMax];
        this.tailleMax = tailleMax;
        this.taille = 0;
    }

    public void add(Coup coup) {
        if (taille < tailleMax) {
            this.listeCoup[taille] = coup;
            taille++;
        } else {
            throw new IndexOutOfBoundsException("Choisis une meilleure tailleMax");
        }
    }

    public Coup get(int indice) {
        return this.listeCoup[indice];
    }

    public int size() {
        return this.taille;
    }

    public void set(int position, Coup coup) {
        this.listeCoup[position] = coup;
    }

}
