package code;

public class App {

    static final String codePositionInitiale = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR";
    
    public App(int joueur1, int joueur2, int niveauIA, boolean chrono, boolean coms) throws CodeIncorrectException {
    	
    			Plateau plateauDeJeu = new Plateau(codePositionInitiale, chrono, coms);
    			
    			Joueur j1, j2;
    	    	
    			if (joueur1 == 0) {
    				j1 = new Humain(true);
    			} else {
    				j1 = new IA(plateauDeJeu, true, chrono, coms);
    				j1.DefinirNiveau(niveauIA);
    			}
    			if (joueur2 == 0) {
    				j2 = new Humain(false);
    			} else {
    				j2 = new IA(plateauDeJeu, false, chrono, coms);
    				j2.DefinirNiveau(niveauIA);
    			}
    			
    	    	plateauDeJeu.RenvoyerFenetre().InitialiserJoueurs(j1, j2);   	
	    	
    }
    
    public App(int joueur1, int joueur2, int niveauIA, boolean chrono, boolean coms, String codePosition) throws CodeIncorrectException {
    	
        
    		Plateau plateauDeJeu = new Plateau(codePosition, chrono, coms);

    		Joueur j1, j2;
        	
    		if (joueur1 == 0) {
    			j1 = new Humain(true);
    		} else {
    			j1 = new IA(plateauDeJeu, false, chrono, coms);
    			j1.DefinirNiveau(niveauIA);
    		}
    		if (joueur2 == 0) {
    			j2 = new Humain(true);
    		} else {
    			j2 = new IA(plateauDeJeu, false, chrono, coms);
    			j2.DefinirNiveau(niveauIA);
    		}
    		
        	plateauDeJeu.RenvoyerFenetre().InitialiserJoueurs(j1, j2);
        	
    }

}
