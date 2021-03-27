package allumettes.tests;

import allumettes.JeuReel;
import allumettes.Jeu;
import allumettes.Joueur;
import allumettes.strategie.IStrategie;
import allumettes.strategie.StrategieRapide;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Vérifier que les exceptions sont correctement définies.
 *
 * @author	Xavier Crégut <Prenom.Nom@enseeiht.fr>
 */
public class StrategieRapideTest {

    private Joueur joueur;
    private IStrategie strategie;

    @Before
    public void initialisation() {
        strategie = new StrategieRapide();
        joueur = new Joueur("Hamza", strategie);
    }


    public void testerPriseMax() {
        Jeu jeu = new JeuReel(JeuReel.PRISE_MAX);
        assertEquals(JeuReel.PRISE_MAX, strategie.getPrise(joueur, jeu));

        jeu = new JeuReel(JeuReel.PRISE_MAX + 1);
        assertEquals(JeuReel.PRISE_MAX, strategie.getPrise(joueur, jeu));

        jeu = new JeuReel(2 * JeuReel.PRISE_MAX);
        assertEquals(JeuReel.PRISE_MAX, strategie.getPrise(joueur, jeu));
    }

    public void testerPriseLimitee() {
        for (int i = 1; i < JeuReel.PRISE_MAX; i++) {
            Jeu jeu = new JeuReel(i);
            assertEquals(i, strategie.getPrise(joueur, jeu));
        }
    }

    @Test
    public void tester() {
        testerPriseMax();
        testerPriseLimitee();
    }

}
