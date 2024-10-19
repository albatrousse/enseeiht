package code;

public interface Joueur {
    
    public boolean RenvoyerTour();
    public Coup RechercherMeilleurCoup();
    public void DefinirNiveau (int niveau);
}
