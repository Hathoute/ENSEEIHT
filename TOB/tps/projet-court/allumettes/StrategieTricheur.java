package allumettes;

public class StrategieTricheur implements IStrategie {

    public int getPrise(Joueur joueur, Jeu jeu) {
        System.out.println("[Je triche...]");
        try {
            while(jeu.getNombreAllumettes() > 2) {
                jeu.retirer(1);
            }
        } catch (CoupInvalideException e) {};
        System.out.println("[Allumettes restantes : " + jeu.getNombreAllumettes() + "]");

        return 1;
    }

}
