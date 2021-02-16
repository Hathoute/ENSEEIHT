public interface EnsembleOrdonne<E extends Comparable<E>> extends Ensemble<E> {

    /** Retourne le plus petit element de l'ensemble
     */
    E min();

}
