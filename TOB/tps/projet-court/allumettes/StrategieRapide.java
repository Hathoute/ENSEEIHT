package allumettes;

public class StrategieRapide implements IStrategie {

    public int getPrise(Joueur joueur, Jeu jeu) {
        return Math.min(jeu.getNombreAllumettes(), Jeu.PRISE_MAX);
    }

}
