package code;

public class IA implements Joueur {
    private Plateau plateau;
    private boolean aMonTour;
    private final int INFINI = 100000;
    private int couleur;
    private long tempsRecherche = 5;
    private boolean coms;
    private int evalPrecedPlateau;
    private BullesChat bulleChat = null;


    public void DefinirNiveau(int niveau) {
        if (niveau == 1) {
            this.tempsRecherche = 90;
        } else if (niveau == 2) {
            this.tempsRecherche = 1500;
        }
    }

    IA(Plateau plateau, Boolean tour, boolean chrono, boolean coms) {
        this.plateau = plateau;
        this.aMonTour = tour;
        this.couleur = aMonTour ? 0 : 1;
        this.coms = coms;
        this.evalPrecedPlateau = this.plateau.RenvoyerEvaluation();
    }

    public void ChangerTour() {
        this.aMonTour = !this.aMonTour;
    }

    public int MinMax(int profondeur, int alpha, int beta, boolean maximiserJouer) {

        if (profondeur == 0) {
            if (maximiserJouer) {
                return this.RechercheCaptures(alpha, beta, false);
            } else {
                return this.RechercheCaptures(alpha, beta, true);
            }
        }

        if (maximiserJouer) {
            int maxEval = -INFINI;

            ListeCoup coupsLegaux = this.plateau.CoupLegaux();

            if (coupsLegaux.size() != 0) {
                for (int compteurCoup = 0; compteurCoup < coupsLegaux.size(); compteurCoup++) {

                    Coup coup = coupsLegaux.get(compteurCoup);
                    this.plateau.JouerCoup(coup);

                    coup.evaluationCoup = MinMax(profondeur - 1, alpha, beta, false);
                    maxEval = Plateau.max(maxEval, coup.evaluationCoup);
                    alpha = Plateau.max(alpha, coup.evaluationCoup);

                    this.plateau.DejouerCoup(coup);
                    if (beta <= alpha) {
                        return maxEval;
                    }
                }
            } else {
                int couleurEnnemie = this.plateau.RenvoyerTourBlanc() ? 1 : 0;
                if (plateau.RoiEnEchec(couleurEnnemie)) {
                    return -INFINI;
                } else {
                    return 0;
                }
            }

            return maxEval;

        } else {
            int minEval = INFINI;

            ListeCoup coupsLegaux = this.plateau.CoupLegaux();

            if (coupsLegaux.size() != 0) {
                for (int compteurCoup = 0; compteurCoup < coupsLegaux.size(); compteurCoup++) {

                    Coup coup = coupsLegaux.get(compteurCoup);
                    this.plateau.JouerCoup(coup);

                    coup.evaluationCoup = MinMax(profondeur - 1, alpha, beta, true);
                    minEval = Plateau.min(minEval, coup.evaluationCoup);
                    beta = Plateau.min(beta, coup.evaluationCoup);

                    this.plateau.DejouerCoup(coup);

                    if (beta <= alpha) {
                        return minEval;
                    }

                }
            } else {
                int couleurEnnemie = this.plateau.RenvoyerTourBlanc() ? 1 : 0;
                if (plateau.RoiEnEchec(couleurEnnemie)) {
                    return INFINI;
                } else {
                    return 0;
                }
            }
            return minEval;
        }
    }

    public int RechercheCaptures(int alpha, int beta, boolean maximiserJouer) {
        int eval;
        int nbCaptures = 0;
        if (maximiserJouer) {
            int evalPos = this.evaluerPosition(this.couleur);
            alpha = Plateau.max(alpha, evalPos);
            if (beta <= alpha) {
                return evalPos;
            }
            int maxEval = -INFINI;
            ListeCoup coupsLegaux = this.plateau.CoupLegaux();

            if (coupsLegaux.size() != 0) {

                for (int compteurCoup = 0; compteurCoup < coupsLegaux.size(); compteurCoup++) {
                    Coup coup = coupsLegaux.get(compteurCoup);

                    if (this.plateau.EstCapture(coup)) {
                        this.plateau.JouerCoup(coup);
                        nbCaptures++;
                        eval = RechercheCaptures(alpha, beta, false);
                        maxEval = Plateau.max(maxEval, eval);
                        alpha = Plateau.max(alpha, eval);

                        this.plateau.DejouerCoup(coup);
                        if (beta <= alpha) {
                            return maxEval;
                        }
                    }
                }
            }

            if (nbCaptures == 0) {
                maxEval = this.evaluerPosition(this.couleur);
            }

            return maxEval;

        } else {

            int evalPos = this.evaluerPosition(this.couleur);
            beta = Plateau.min(beta, evalPos);

            if (beta <= alpha) {
                return evalPos;
            }

            int minEval = INFINI;
            ListeCoup coupsLegaux = this.plateau.CoupLegaux();

            if (coupsLegaux.size() != 0) {
                for (int compteurCoup = 0; compteurCoup < coupsLegaux.size(); compteurCoup++) {
                    Coup coup = coupsLegaux.get(compteurCoup);

                    if (this.plateau.EstCapture(coup)) {
                        this.plateau.JouerCoup(coup);
                        nbCaptures++;
                        eval = RechercheCaptures(alpha, beta, true);
                        minEval = Plateau.min(minEval, eval);
                        beta = Plateau.min(beta, eval);

                        this.plateau.DejouerCoup(coup);
                        if (beta <= alpha) {
                            return minEval;
                        }
                    }
                }
            }

            if (nbCaptures == 0) {
                minEval = this.evaluerPosition(this.couleur);
            }

            return minEval;
        }
    }

    public Coup RechercherMeilleurCoup() {

        if (this.bulleChat != null) {
            this.bulleChat.Fermer();
            this.bulleChat = null;
        }

        long tempsDebut = System.currentTimeMillis();

        int bestEval = -INFINI;
        Coup meilleurCoup = null;
        ListeCoup coupsLegaux = this.plateau.CoupLegaux();
        int profondeurMax = 1;

        if (coupsLegaux.size() != 0) {

            Coup meilleCoupTemp = null;

            while (System.currentTimeMillis() - tempsDebut < this.tempsRecherche) {

                int bestEvalTemp = -INFINI;

                coupsLegaux = this.TrierCoupsDecroissant(coupsLegaux);

                for (int compteurCoup = 0; compteurCoup < coupsLegaux.size(); compteurCoup++) {

                    if (System.currentTimeMillis() - tempsDebut > this.tempsRecherche) {
                        profondeurMax--;
                        meilleCoupTemp = meilleurCoup;
                        bestEval = bestEvalTemp;
                        break;
                    }

                    Coup coup = coupsLegaux.get(compteurCoup);

                    this.plateau.JouerCoup(coup);
                    coup.evaluationCoup = MinMax(profondeurMax - 1, -INFINI, INFINI, false);
                    this.plateau.DejouerCoup(coup);

                    if (coup.evaluationCoup > bestEvalTemp) {
                        bestEvalTemp = coup.evaluationCoup;
                        meilleCoupTemp = coup;

                    }

                }
                meilleurCoup = meilleCoupTemp;
                bestEval = bestEvalTemp;
                profondeurMax++;
            }
        }
        if (this.coms) {
            if (this.evalPrecedPlateau - bestEval > 400) {
                this.bulleChat = new BullesChat(1);
            } else if (bestEval - this.evalPrecedPlateau > 400) {
                this.bulleChat = new BullesChat(0);
            }
        }
        this.evalPrecedPlateau = bestEval;

        return meilleurCoup;
    }

    public int evaluerPosition(int couleurAjoue) {
        return couleurAjoue == 0 ? this.plateau.RenvoyerEvaluation() : -this.plateau.RenvoyerEvaluation();
    }

    public boolean RenvoyerTour() {
        return this.aMonTour;
    }

    public ListeCoup TrierCoupsDecroissant(ListeCoup listeCoups) {
        int n = listeCoups.size();
        boolean swapped;
        do {
            swapped = false;
            for (int i = 1; i < n; i++) {
                if (listeCoups.get(i - 1).evaluationCoup < listeCoups.get(i).evaluationCoup) {
                    Coup temp = listeCoups.get(i - 1);
                    listeCoups.set(i - 1, listeCoups.get(i));
                    listeCoups.set(i, temp);
                    swapped = true;
                }
            }
            n--;
        } while (swapped);
        return listeCoups;
    }

    public ListeCoup TrierCoupsCroissant(ListeCoup listeCoups) {
        int n = listeCoups.size();
        boolean swapped;
        do {
            swapped = false;
            for (int i = 1; i < n; i++) {
                if (listeCoups.get(i - 1).evaluationCoup > listeCoups.get(i).evaluationCoup) {
                    Coup temp = listeCoups.get(i - 1);
                    listeCoups.set(i - 1, listeCoups.get(i));
                    listeCoups.set(i, temp);
                    swapped = true;
                }
            }
            n--;
        } while (swapped);
        return listeCoups;
    }

}
