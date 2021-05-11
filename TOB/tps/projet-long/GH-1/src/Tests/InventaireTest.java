package Tests;

import java.awt.Color;

import Jeu.Modeles.ModeleMaitreJeu;
import org.junit.*;
import static org.junit.Assert.*;

/** Test le fonctionnement de l'inventaire du modèle.
 * @author Basile Gros
 * @version 2eme iteration
*/

public class InventaireTest{
	// précision pour les comparaisons réelle
		public final static double EPSILON = 10e-3;
		
		ModeleMaitreJeu modele; /*Le modèle dont l'inventaire est testé*/
		
		String objet1 = "Baton"; /*Des objets à ajouter à l'inventaire*/
		String objet2 = "Caillou";
		
	@Before public void setUp() {
		modele = new ModeleMaitreJeu();
	}
	
	@Test public void testerAjoutSimple() {
		
		modele.ajouterInventaire(objet1);
		assertEquals("1x Baton.",modele.getInventaire());
		modele.ajouterInventaire(objet2);
		assertEquals("1x Caillou,1x Baton.",modele.getInventaire());
	}
	
	@Test public void testerAjoutMultiple() {
		for (int i = 1; i <= 10; i++) {
			modele.ajouterInventaire(objet1);
			assertEquals(i+"x Baton.",modele.getInventaire());
		}
		
		for (int i = 1; i <= 25; i++) {
			modele.ajouterInventaire(objet2);
			assertEquals(i+"x Caillou,10x Baton.",modele.getInventaire());
		}
		
	}
	
	@Test public void testerAjoutDesordre() {
		modele.ajouterInventaire(objet1);
		assertEquals("1x Baton.",modele.getInventaire());
		modele.ajouterInventaire(objet2);
		assertEquals("1x Caillou,1x Baton.",modele.getInventaire());
		modele.ajouterInventaire(objet1);
		assertEquals("1x Caillou,2x Baton.",modele.getInventaire());
		modele.ajouterInventaire(objet2);
		assertEquals("2x Caillou,2x Baton.",modele.getInventaire());
	}
	
	@Test public void testerAjouterVide() {
		String objetVide = "";
		modele.ajouterInventaire(objetVide);
		assertEquals("",modele.getInventaire());
		modele.ajouterInventaire(objetVide);
		assertEquals("",modele.getInventaire());
		modele.ajouterInventaire(objetVide);
		assertEquals("",modele.getInventaire());
	}
	
	@Test public void testerAjouterNull() {
		String objetNull = null;
		modele.ajouterInventaire(objetNull);
		assertEquals("",modele.getInventaire());
	}
	
	@Test public void testerAjourCaracteresSpeciaux() {
		String objetSpecial1 = "çè€§$ê£ì";
		String objetSpecial2 = "Δοκιμή Контрольная работа";
		modele.ajouterInventaire(objetSpecial1);
		assertEquals("1x çè€§$ê£ì.",modele.getInventaire());
		modele.ajouterInventaire(objetSpecial2);
		assertEquals("1x çè€§$ê£ì,1x Δοκιμή Контрольная работа.",modele.getInventaire());
		}
	
	@Test public void testerSuppressionSimple() {
		modele.ajouterInventaire(objet1);
		assertEquals("1x Baton.",modele.getInventaire());
		modele.supprimerInventaire(objet1);
		assertEquals("",modele.getInventaire());
		modele.ajouterInventaire(objet2);
		assertEquals("1x Caillou.",modele.getInventaire());
		modele.supprimerInventaire(objet2);
		assertEquals("",modele.getInventaire());
		
	}
	
	@Test public void testerSuppressionMultiple() {
		for (int i = 1; i <= 10; i++) {
			modele.ajouterInventaire(objet1);
		}
		
		for (int i = 1; i <= 25; i++) {
			modele.ajouterInventaire(objet2);
		}
		
		for (int i = 24; i >= 1; i--) {
			modele.supprimerInventaire(objet2);
			assertEquals(i+"x Caillou,10x Baton.",modele.getInventaire());
		}
		modele.supprimerInventaire(objet2);
		assertEquals("10x Baton.",modele.getInventaire());
		
		for (int i = 9; i >= 1; i--) {
			modele.supprimerInventaire(objet1);
			assertEquals(i+"x Baton.",modele.getInventaire());
		}
		
		modele.supprimerInventaire(objet1);
		assertEquals("",modele.getInventaire());
	}
	
	@Test public void testSupprimerAbsent() {
		modele.supprimerInventaire(objet1);
		assertEquals("",modele.getInventaire());
		modele.supprimerInventaire(objet2);
		assertEquals("",modele.getInventaire());
	}
	
	@Test public void testSupprimerNull() {
		String objetNull = null;
		modele.supprimerInventaire(null);
	}
}