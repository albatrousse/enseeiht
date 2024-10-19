package code;

public class BitBoard {

    static boolean estValide(int caseArrivee) {
        return (caseArrivee < 64) && (caseArrivee >= 0);
    }

    static boolean colonneValideRoiPion(int caseDepart, int deplacement) {
        if (caseDepart % 8 == 7 && ((deplacement == 1) || (deplacement == 9) || (deplacement == -7))) {
            return false;
        } else if (caseDepart % 8 == 0 && ((deplacement == -1) || (deplacement == -9) || (deplacement == +7))) {
            return false;
        } else {
            return true;
        }
    }

    static boolean colonneValideCavalier(int caseDepart, int deplacement) {
        if (caseDepart % 8 == 7
                && ((deplacement == 10) || (deplacement == -6) || (deplacement == 17) || (deplacement == -15))) {
            return false;
        } else if (caseDepart % 8 == 6 && ((deplacement == 10) || (deplacement == -6))) {
            return false;
        } else if (caseDepart % 8 == 1 && ((deplacement == -10) || (deplacement == 6))) {
            return false;
        } else if (caseDepart % 8 == 0
                && ((deplacement == -10) || (deplacement == 6) || (deplacement == -17) || (deplacement == 15))) {
            return false;
        } else {
            return true;
        }
    }

    static long creerBoard(int position) {
        return 1L << position;
    }

    static int exposant(long i) {
        return Long.numberOfTrailingZeros(i);
    }

    static long InverserBits(long i) {
        long masque = 0xFFFFFFFFFFFFFFFFL;
        return i ^ masque;
    }

    static long LigneBitBoard(int position1, int position2) {
        int x = (position2 % 8) - (position1 % 8);
        int y = (position2 / 8) - (position1 / 8);
        if (x != 0) {
            x = x / Math.abs(x);
        }
        if (y != 0) {
            y = y / Math.abs(y);
        }
        long ligne = 0L;
        if (position1 != position2) {
            position1 += x + 8 * y;
            while (position1 != position2) {
                ligne |= BitBoard.creerBoard(position1);
                position1 += x + 8 * y;
            }
        }
        return ligne;
    }
    

    static int NbBits(long i) {
        int nb = 0;
        while (i != 0) {
            nb += 1;
            i &= i - 1;
        }
        return nb;
    }

    static void AfficherBitBoard(long board) {
        for (int row = 0; row < 8; row++) {
            for (int col = 0; col < 8; col++) {
                int caseCible = row * 8 + col;
                if (((board >>> caseCible) & 1) == 1) {
                    System.out.print("1  ");
                } else {
                    System.out.print("0  ");
                }
            }
            System.out.println();
        }
        System.out.println();
    }

    public static long[] InitialiserMasqueDroites() {
        long[] masks = new long[46];

        // Lignes
        for (int row = 0; row < 8; row++) {
            long mask = 0L;
            for (int col = 0; col < 8; col++) {
                int square = row * 8 + col;
                mask |= (1L << square);
            }
            masks[8 + row] = mask;
            masks[8 + row] = InverserBits(masks[8 + row]);
        }

        // Colonnes
        for (int col = 0; col < 8; col++) {
            long mask = 0L;
            for (int row = 0; row < 8; row++) {
                int square = row * 8 + col;
                mask |= (1L << square);
            }
            masks[col] = mask;
            masks[col] = InverserBits(masks[col]);
        }

        // Diagonales
        for (int diag = 0; diag < 15; diag++) {
            long mask = 0L;
            int row = Math.max(diag - 7, 0);
            int col = Math.max(7 - diag, 0);
            while (row < 8 && col < 8) {
                int square = row * 8 + col;
                mask |= (1L << square);
                row++;
                col++;
            }
            masks[16 + diag] = mask;
            masks[16 + diag] = InverserBits(masks[16 + diag]);
        }
        for (int diag = 0; diag < 15; diag++) {
            long mask = 0L;
            int row = Math.min(diag, 7);
            int col = Math.max(diag - 7, 0);
            while (row >= 0 && col < 8) {
                int square = row * 8 + col;
                mask |= (1L << square);
                row--;
                col++;
            }
            masks[16 + 15 + diag] = mask;
            masks[16 + 15 + diag] = InverserBits(masks[16 + 15 + diag]);
        }
        return masks;

    }

    public static int IndiceMasqueDroites(int square1, int square2) {
        
            int row1 = square1 / 8;
            int col1 = square1 % 8;
            int row2 = square2 / 8;
            int col2 = square2 % 8;
        
            if (row1 == row2) {
                return row1 + 8;
            } else if (col1 == col2) {
                return col1;
            } else if (row1 - col1 == row2 - col2) {
                int diag = row1 - col1 + 7;
                return 16 + diag;
            } else if (row1 + col1 == row2 + col2) {
                int diag = row1 + col1;
                return 16 + 15 + diag;
            } else {
                throw new IllegalArgumentException("Squares are not on the same line, column or diagonal");
            
        }
        
    }


    public static boolean EstDiagonale(long depart, long arrivee, int case3) {
        int case1 = exposant(depart);
        int case2 = exposant(arrivee);
        // Convertir les numéros de case en coordonnées x et y
        int x1 = case1 % 8;
        int y1 = case1 / 8;
        int x2 = case2 % 8;
        int y2 = case2 / 8;
        int x3 = case3 % 8;
        int y3 = case3 / 8;
    
        // Vérifier si les cases sont sur la même diagonale en comparant les distances horizontales et verticales
        if (Math.abs(x1 - x2) == Math.abs(y1 - y2) &&
            Math.abs(x1 - x3) == Math.abs(y1 - y3) &&
            Math.abs(x2 - x3) == Math.abs(y2 - y3)) {
            return true;
        } else {
            return false;
        }
    }

    public static boolean EstLigneColonne(long depart, long arrivee, int case3) {
        int case1 = exposant(depart);
        int case2 = exposant(arrivee);
        // Convertir les numéros de case en coordonnées x et y
        int x1 = case1 % 8;
        int y1 = case1 / 8;
        int x2 = case2 % 8;
        int y2 = case2 / 8;
        int x3 = case3 % 8;
        int y3 = case3 / 8;
    
        // Vérifier si les cases sont sur la même ligne en comparant les coordonnées y
        if ((y1 == y2 && y1 == y3) || (x1 == x2 && x1 == x3)) {
            return true;
        } else {
            return false;
        }
    }

}
