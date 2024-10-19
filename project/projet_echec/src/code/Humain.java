package code;

public class Humain implements Joueur{

    boolean aMonTour;

    public Humain (boolean tour) {
        this.aMonTour = tour;
    }

    @Override
    public boolean RenvoyerTour() {
        return this.aMonTour;
    }

    @Override
    public Coup RechercherMeilleurCoup() {
        return null;
    }

    @Override
    public void DefinirNiveau(int niveau) {
    }
    
}
