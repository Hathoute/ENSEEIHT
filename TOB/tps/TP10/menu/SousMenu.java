package menu;

public class SousMenu extends Menu implements Commande {

    private boolean seulAffichage;

    public SousMenu(String sonTitre, boolean seulAffichage) {
        super(sonTitre);
        this.seulAffichage = seulAffichage;
    }

    public void setSeulAffichage(boolean valeur) {
        this.seulAffichage = valeur;
    }

    public boolean getSeulAffichage() {
        return seulAffichage;
    }

    @Override
    public void executer() {
        // Afficher le menu
        this.afficher();
        // Sélectionner une entrée dans le menu
        this.selectionner();
        // Valider l'entrée sélectionnée
        this.valider();
    }

    @Override
    public boolean estExecutable() {
        return true;
    }
}
