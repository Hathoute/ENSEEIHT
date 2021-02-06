import org.junit.Before;
import org.junit.Test;

import java.awt.*;

import static org.junit.Assert.*;

/**
 * Classe de test des exigences E12, E13 et E14 de la classe Cercle.
 * @author	HATHOUTE Hamza
 */
public class CercleTest {

    public static final double EPSILON = 1e-6;
    // précision pour la comparaison entre réels.

    // Les points du sujet
    private Point C, D, E;
    private static final double sqrt2 = Math.sqrt(2);

    @Before
    public void setUp() {
        // Construire les points
        C = new Point(-1, -1);
        D = new Point(0, 0);
        E = new Point(1, 1);
    }

    @Test
    public void testerE12() {
        Cercle cercle = new Cercle(C, E);
        assertEquals("E12 : Rayon de C2 incorrect",
                sqrt2, cercle.getRayon(), EPSILON);
        assertEquals("E12 : Abscisse du centre incorrect",
                0.0, cercle.getCentre().getX(), EPSILON);
        assertEquals("E12 : Ordonnée du centre incorrect",
                0.0, cercle.getCentre().getY(), EPSILON);
        assertEquals("E12 : Couleur du centre incorrect",
                Color.blue, cercle.getCouleur());
    }

    @Test
    public void testerE13() {
        Cercle cercle = new Cercle(C, E, Color.green);
        assertEquals("E13 : Rayon de C2 incorrect",
                sqrt2, cercle.getRayon(), EPSILON);
        assertEquals("E13 : Abscisse du centre incorrect",
                0.0, cercle.getCentre().getX(), EPSILON);
        assertEquals("E13 : Ordonnée du centre incorrect",
                0.0, cercle.getCentre().getY(), EPSILON);
        assertEquals("E13 : Couleur du centre incorrect",
                Color.green, cercle.getCouleur());
    }

    @Test
    public void testerE14() {
        Cercle cercle = Cercle.creerCercle(D, E);
        assertEquals("E14 : Rayon de C2 incorrect",
                sqrt2, cercle.getRayon(), EPSILON);
        assertEquals("E14 : Abscisse du centre incorrect",
                0.0, cercle.getCentre().getX(), EPSILON);
        assertEquals("E14 : Ordonnée du centre incorrect",
                0.0, cercle.getCentre().getY(), EPSILON);
        assertEquals("E14 : Couleur du centre incorrect",
                Color.blue, cercle.getCouleur());
    }

}