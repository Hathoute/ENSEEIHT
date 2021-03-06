package allumettes.strategie;

import allumettes.Jeu;
import allumettes.Joueur;

public interface IStrategie {

    int getPrise(Joueur joueur, Jeu jeu);

}
