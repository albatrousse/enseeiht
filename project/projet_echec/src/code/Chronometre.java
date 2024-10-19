package code;

import javax.swing.*;

public class Chronometre extends Thread {

	private int secondes;
	private int minutes;
	private JLabel labelChronometre = new JLabel(minutes+":"+secondes);
	
	public void run() {
		while (true){
			decompterDeUn();
			wait(1);
		}
	}
	
	// Initialise le compteur avec minutesInitiales et secondesInitiales
	public Chronometre(int minutesInitiales, int secondesInitiales) {
		this.minutes = minutesInitiales;
		this.secondes = secondesInitiales;
		this.labelChronometre.setText(minutes+":"+secondes);
	}
	
	// Decompte le chronometre d'une seconde
	public boolean decompterDeUn() {
		if (!estFini()) {
			if (this.secondes == 0) {
				this.secondes = 60;
				this.minutes --;
			}
			this.secondes--;
			labelChronometre.setText(this.minutes + ":" + this.secondes);
		}
		return true;
	}
	
	// Attend nbSecondes 
	private void wait(int nbSecondes) {
		try {
			int tempsAttente = nbSecondes * 1000;
			Thread.sleep(tempsAttente);
		} catch (InterruptedException IE) {}
	}
	
	// Renvoie true si le compteur est terminé
	public boolean estFini() {
		return this.secondes == 0 && this.minutes == 0;
	}
	
	// Renvoie le label du compteur
	public JLabel getLabel() {
		return this.labelChronometre;
	}
		
	// Renvoie les minutes du compteur
	public int getMinutes() {
		return this.minutes;
	}
	
	// Renvoie les secondes du compteur
	public int getSeconds() {
		return this.secondes;
	}

}

