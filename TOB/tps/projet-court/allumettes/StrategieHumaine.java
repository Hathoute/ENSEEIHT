package allumettes;

import java.util.Scanner;

public class StrategieHumaine implements IStrategie {

    private static final Scanner scanner = new Scanner(System.in);

    public int getPrise(Joueur joueur, Jeu jeu) {
        while(true) {
            System.out.print(joueur.getNom() + ", combien d'allumettes ? ");
            String input = scanner.next();

            if(input.equals("triche")) {
                tricherHumain(jeu);
                continue;
            }

            try {
                return Integer.parseInt(input);
            } catch (NumberFormatException e) {
                System.out.println("Vous devez donner un entier.");
            }
        }
    }

    private void tricherHumain(Jeu jeu) {
        try {
            jeu.retirer(1);
        } catch (CoupInvalideException e) {};
        System.out.println("[Une allumette en moins, plus que " + jeu.getNombreAllumettes() + ". Chut !]");
    }

}
