import afficheur.Afficheur;

import java.awt.*;


public class AfficheurTexte implements Afficheur {
    private final StringBuilder affichage;

    public AfficheurTexte() {
        affichage = new StringBuilder();
    }

    @Override
    public void dessinerPoint(double x, double y, Color c) {
        affichage.append("Point {\n");
        affichage.append("\tx = ").append(x).append("\n");
        affichage.append("\ty = ").append(y).append("\n");
        affichage.append("\tcouleur = ").append(c).append("\n");
        affichage.append("}\n");
    }

    @Override
    public void dessinerLigne(double x1, double y1, double x2, double y2, Color c) {
        affichage.append("Ligne {\n");
        affichage.append("\tx1 = ").append(x1).append("\n");
        affichage.append("\ty1 = ").append(y1).append("\n");
        affichage.append("\tx2 = ").append(x2).append("\n");
        affichage.append("\ty2 = ").append(y2).append("\n");
        affichage.append("\tcouleur = ").append(c).append("\n");
        affichage.append("}\n");
    }

    @Override
    public void dessinerCercle(double x, double y, double rayon, Color c) {
        affichage.append("Cercle {\n");
        affichage.append("\tcentre_x = ").append(x).append("\n");
        affichage.append("\tcentre_y = ").append(y).append("\n");
        affichage.append("\trayon = ").append(rayon).append("\n");
        affichage.append("\tcouleur = ").append(c).append("\n");
        affichage.append("}\n");
    }

    @Override
    public void dessinerTexte(double x, double y, String texte, Color c) {
        affichage.append("Cercle {\n");
        affichage.append("\tx = ").append(x).append("\n");
        affichage.append("\ty = ").append(y).append("\n");
        affichage.append("\tvaleur = ").append(texte).append("\n");
        affichage.append("\tcouleur = ").append(c).append("\n");
        affichage.append("}\n");
    }

    @Override
    public String toString() {
        return affichage.toString();
    }

    public void ecrire() {
        System.out.println(this);
    }
}
