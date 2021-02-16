/**
 * Classe de test pour EnsembleChaine.
 */
public class EnsembleChaineTest extends EnsembleTestAbstrait {

	protected Ensemble<Integer> nouvelEnsemble(int capacite) {
		return new EnsembleChaine<Integer>();
	}

}
