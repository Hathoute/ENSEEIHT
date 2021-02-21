package allumettes;

import java.util.Random;

public class StrategieNaive implements IStrategie {

    private static final Random random = new Random();

    public int getPrise(Joueur joueur, Jeu jeu) {
        return random.nextInt(3) + 1;
    }

}
