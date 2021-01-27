import org.junit.Before;
import org.junit.Test;

import java.awt.*;

import static org.junit.Assert.*;

/**
 * Classe de tests complémentaires de la classe Cercle.
 * @author	HATHOUTE Hamza
 */
public class ComplementsCercleTest {

    public static final double EPSILON = 1e-6;
    // précision pour la comparaison entre réels.

    // Les points du test
    private Point centre;

    @Before
    public void setUp() {
        // Construire les points
        centre = new Point(8, 4);
    }

    @Test
    public void testerE18() {
        Cercle cercle = new Cercle(centre, 1.0);
        centre.translater(10.0, 10.0);

        assertEquals("E18 : Abscisse du centre incorrect",
                8.0, cercle.getCentre().getX(), EPSILON);
        assertEquals("E18 : Ordonnée du centre incorrect",
                4.0, cercle.getCentre().getY(), EPSILON);
    }

    @Test
    public void testerNull() {
        Point A = null;
        try {
            Cercle cercle = new Cercle(A, 1.0);
        } catch (Throwable e) {
            assertTrue("Null: pas de précondition pour le Constructeur(Point, double)",
                    e instanceof AssertionError);
        }
        try {
            Cercle cercle = new Cercle(centre, -20.0);
        } catch (Throwable e) {
            assertTrue("Null: pas de précondition pour le Constructeur(Point, double)",
                    e instanceof AssertionError);
        }

        try {
            Cercle cercle = new Cercle(new Point(1, 1), null);
        } catch (Throwable e) {
            assertTrue("Null: pas de précondition pour le Constructeur(Point, Point)",
                    e instanceof AssertionError);
        }
        try {
            Cercle cercle = new Cercle(null, new Point(1, 1));
        } catch (Throwable e) {
            assertTrue("Null: pas de précondition pour le Constructeur(Point, Point)",
                    e instanceof AssertionError);
        }
    }

}