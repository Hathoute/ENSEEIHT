package allumettes;

import allumettes.strategie.IStrategie;

public class Joueur {

    private final String nom;
    private IStrategie strategie;

    public Joueur(String nom, IStrategie strategie) {
        this.nom = nom;
        this.strategie = strategie;
    }

    public String getNom() {
        return nom;
    }

    public IStrategie getStrategie() {
        return strategie;
    }

    public void setStrategie(IStrategie strategie) {
        this.strategie = strategie;
    }

    public int getPrise(Jeu jeu) {
        return strategie.getPrise(this, jeu);
    }
}
