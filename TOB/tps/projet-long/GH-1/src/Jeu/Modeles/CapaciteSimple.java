package Jeu.Modeles;


import Jeu.Interfaces.Capacite;

public class CapaciteSimple implements Capacite {
    private final String nom;
    private String valeur;

    public CapaciteSimple(String nom) {
        this.nom = nom;
        this.valeur = "";
    }

    public CapaciteSimple(String nom, String valeur) {
        this.nom = nom;
        this.valeur = valeur;
    }

    public String getNom() {
        return this.nom;
    }

    public void setValeur(String valeur) {
        this.valeur = valeur;
    }

    public String getValeur() {
        return this.valeur;
    }
}