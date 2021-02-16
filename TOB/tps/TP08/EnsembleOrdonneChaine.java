
public class EnsembleOrdonneChaine<E extends Comparable<E>> extends EnsembleChaine<E> implements EnsembleOrdonne<E> {


    @Override
    public void ajouter(E x) {
        if(contient(x))
            return;

        Cellule<E> precedente = null;
        Cellule<E> courante = tete;
        while(courante != null && courante.valeur.compareTo(x) < 0) {
            precedente = courante;
            courante = courante.suivante;
        }

        if(precedente == null)
            tete = new Cellule<>(x, tete);
        else
            precedente.suivante = new Cellule<>(x, courante);

        this.taille++;
    }

    @Override
    public void supprimer(E x) {
        super.supprimer(x);
    }

    @Override
    public E min() {
        if(estVide())
            return null;

        return tete.valeur;
    }

    public E justePlusGrandQue(E x) {
        Cellule<E> courante = tete;
        while (courante != null && courante.valeur.compareTo(x) < 0) {
            courante = courante.suivante;
        }

        return courante != null ? courante.valeur : null;
    }
}