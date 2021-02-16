/**
 * Classe de test pour EnsembleChaine.
 */
public class EnsembleOrdonneChaineTest extends EnsembleTestAbstrait {

    protected Ensemble<Integer> nouvelEnsemble(int capacite) {
        return new EnsembleOrdonneChaine<>();
    }

}
