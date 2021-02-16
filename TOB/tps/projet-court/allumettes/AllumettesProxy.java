package allumettes;

public class AllumettesProxy implements Jeu {

    private final Jeu jeuReel;

    public AllumettesProxy(Jeu jeu) {
        this.jeuReel = jeu;
    }

    @Override
    public int getNombreAllumettes() {
        return jeuReel.getNombreAllumettes();
    }

    @Override
    public void retirer(int nbPrises) throws OperationInterditeException {
        throw new OperationInterditeException();
    }
}
