package allumettes;

public class Allumettes implements Jeu {

    public static final int ALLUMETTES_INITIALES = 13;

    private int nombreAllumettes;

    public Allumettes() {
        nombreAllumettes = ALLUMETTES_INITIALES;
    }

    @Override
    public int getNombreAllumettes() {
        return nombreAllumettes;
    }

    @Override
    public void retirer(int nbPrises) throws CoupInvalideException {
        String probleme = "";
        if(nbPrises > PRISE_MAX)
            probleme = "> " + PRISE_MAX;
        else if(nbPrises < 1)
            probleme = "< 1";
        else if(nbPrises > nombreAllumettes)
            probleme = "> " + nombreAllumettes;

        if(!probleme.isEmpty())
            throw new CoupInvalideException(nbPrises, probleme);

        nombreAllumettes -= nbPrises;
    }
}
