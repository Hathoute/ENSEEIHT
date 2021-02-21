package allumettes;

public class Joueur {

    private final String nom;
    private IStrategie strategie;

    public Joueur(String nom, IStrategie strategie){
        this.nom = nom;
        this.strategie = strategie;
    }

    public String getNom() {
        return nom;
    }

    public int getPrise(Jeu jeu) {
        return strategie.getPrise(this, jeu);
    }
}
