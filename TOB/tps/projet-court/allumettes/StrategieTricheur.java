package allumettes;

public class StrategieTricheur implements IStrategie {

    public int getPrise(Joueur joueur, Jeu jeu) {
        System.out.println("[Je triche...]");
        try {
            jeu.retirer(jeu.getNombreAllumettes() - 2);
        } catch (CoupInvalideException e) {};
        System.out.println("[Allumettes restantes : " + jeu.getNombreAllumettes() + "]");

        return 1;
    }

}
