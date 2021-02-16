import javafx.scene.control.Cell;

public class EnsembleChaine<E> implements Ensemble<E> {

    protected int taille;
    protected Cellule<E> tete;

    public EnsembleChaine() {
        this.taille = 0;
        this.tete = null;
    }

    @Override
    public int cardinal() {
        return taille;
    }

    @Override
    public boolean estVide() {
        return taille == 0;
    }

    @Override
    public boolean contient(E x) {
        Cellule<E> courante = tete;
        while(courante != null) {
            if(courante.valeur.equals(x))
                return true;

            courante = courante.suivante;
        }

        return false;
    }

    @Override
    public void ajouter(E x) {
        if(contient(x))
            return;

        this.tete = new Cellule<>(x, tete);
        this.taille++;
    }

    @Override
    public void supprimer(E x) {
        Cellule<E> precedente = null;
        Cellule<E> courante = tete;
        while(courante != null) {
            if(!courante.valeur.equals(x)) {
                precedente = courante;
                courante = courante.suivante;
                continue;
            }

            if(precedente == null)
                tete = courante.suivante;
            else
                precedente.suivante = courante.suivante;

            this.taille--;
            return;
        }
    }
}



class Cellule<E> {
    E valeur;
    Cellule<E> suivante;

    Cellule(E valeur, Cellule<E> suivante) {
        this.valeur = valeur;
        this.suivante = suivante;
    }
}