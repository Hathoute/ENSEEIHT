package allumettes.strategie;

import allumettes.Jeu;
import allumettes.Joueur;

import java.util.Random;

public class StrategieNaive implements IStrategie {

    private static final Random RANDOM = new Random();

    public int getPrise(Joueur joueur, Jeu jeu) {
        return RANDOM.nextInt(Jeu.PRISE_MAX) + 1;
    }

}
