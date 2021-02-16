package allumettes;

import java.util.Random;
import java.util.Scanner;

public class Joueur {

    public enum Strategie {
        HUMAIN,
        NAIF,
        RAPIDE,
        EXPERT,
        TRICHEUR
    }


    private final String nom;
    private Strategie strategie;

    public Joueur(String identifiant) throws IdentifiantJoueurException {
        String[] parties = identifiant.split("@");
        if(parties.length != 2)
            throw new IdentifiantJoueurException("Format Invalide");

        this.nom = parties[0];
        try {
            this.strategie = Strategie.valueOf(parties[1].toUpperCase());
        } catch (IllegalArgumentException e) {
            throw new IdentifiantJoueurException("Stratégie invalide : " + parties[1]);
        }
    }

    public String getNom() {
        return nom;
    }

    public int getPrise(Jeu jeu) {
        switch (strategie) {
            case HUMAIN:
                return getPriseHumain(jeu);
            case NAIF:
                return getPriseNaif(jeu);
            case RAPIDE:
                return getPriseRapide(jeu);
            case EXPERT:
                return getPriseExpert(jeu);
            case TRICHEUR:
                return getPriseTricheur(jeu);
        }

        return 0;
    }

    //region Humain

    // static -> un seul scanner pour toutes les classes joueur.
    private static final Scanner scanner = new Scanner(System.in);

    private int getPriseHumain(Jeu jeu) {
        while(true) {
            System.out.println(nom + ", combien d'allumettes ?");
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
    //endregion

    //region Naif
    private static final Random random = new Random();

    private int getPriseNaif(Jeu jeu) {
        return random.nextInt(3) + 1;
    }
    //endregion

    //region Rapide
    private int getPriseRapide(Jeu jeu) {
        return Math.min(jeu.getNombreAllumettes(), 3);
    }
    //endregion

    //region Expert
    private int getPriseExpert(Jeu jeu) {
        //TODO: Implémenter une methode robuste...
        return 1;
    }
    //endregion

    //region Tricheur
    private int getPriseTricheur(Jeu jeu) {
        System.out.println("[Je triche...]");
        try {
            jeu.retirer(jeu.getNombreAllumettes() - 2);
        } catch (CoupInvalideException e) {};
        System.out.println("[Allumettes restantes : " + jeu.getNombreAllumettes() + "]");
        return 1;
    }
    //endregion
}
