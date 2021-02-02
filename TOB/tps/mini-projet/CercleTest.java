import org.junit.Before;
import org.junit.Test;

import java.awt.*;
import java.util.Random;

import static org.junit.Assert.*;

/**
 * Classe de test des exigences E12, E13 et E14 de la classe Cercle.
 * @author	HATHOUTE Hamza
 */
public class CercleTest {

    public static final double EPSILON = 1e-6;
    // précision pour la comparaison entre réels.

    // Les points du sujet
    private Point C, D, centre;
    double rayon;

    @Before
    public void setUp() {
        // Construire les points
        Random random = new Random();

        C = new Point(random.nextFloat(), random.nextFloat());
        D = new Point(C.getX() + 1.0 + random.nextFloat(),
                C.getY() + 1.0 + random.nextFloat());

        centre = new Point((C.getX()+D.getX())/2, (C.getY()+D.getY())/2);
        rayon = C.distance(D)/2;
    }

    @Test
    public void testerE12() {
        Cercle cercle = new Cercle(C, D);
        assertEquals("E12 : Rayon de C2 incorrect",
                rayon, cercle.getRayon(), EPSILON);
        assertEquals("E12 : Abscisse du centre incorrect",
                centre.getX(), cercle.getCentre().getX(), EPSILON);
        assertEquals("E12 : Ordonnée du centre incorrect",
                centre.getY(), cercle.getCentre().getY(), EPSILON);
        assertEquals("E12 : Couleur du centre incorrect",
                Color.blue, cercle.getCouleur());
    }

    @Test
    public void testerE13() {
        Cercle cercle = new Cercle(C, D, Color.green);
        assertEquals("E13 : Rayon de C2 incorrect",
                rayon, cercle.getRayon(), EPSILON);
        assertEquals("E13 : Abscisse du centre incorrect",
                centre.getX(), cercle.getCentre().getX(), EPSILON);
        assertEquals("E13 : Ordonnée du centre incorrect",
                centre.getY(), cercle.getCentre().getY(), EPSILON);
        assertEquals("E13 : Couleur du centre incorrect",
                Color.green, cercle.getCouleur());
    }

    @Test
    public void testerE14() {
        Cercle cercle = Cercle.creerCercle(C, D);
        assertEquals("E14 : Rayon de C2 incorrect",
                C.distance(D), cercle.getRayon(), EPSILON);
        assertEquals("E14 : Abscisse du centre incorrect",
                C.getX(), cercle.getCentre().getX(), EPSILON);
        assertEquals("E14 : Ordonnée du centre incorrect",
                C.getY(), cercle.getCentre().getY(), EPSILON);
        assertEquals("E14 : Couleur du centre incorrect",
                Color.blue, cercle.getCouleur());
    }
}