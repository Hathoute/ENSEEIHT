package allumettes;

public class StrategieExpert implements IStrategie {
    @Override
    public int getPrise(Joueur joueur, Jeu jeu) {
        int alumettes = (jeu.getNombreAllumettes() - 1) % (Jeu.PRISE_MAX + 1) + 1;
        return alumettes - (alumettes == 1 ? 0 : 1);
    }
}
