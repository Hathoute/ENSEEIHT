package editeur.commande;

import editeur.Ligne;
import util.Console;

import java.util.Stack;

/** Ajouter un caractère à la fin de la ligne.
 * @author	Xavier Crégut
 * @version	1.4
 */
public class CommandeAjouterFin
	extends CommandeLigne
	implements CommandeReversible
{

	private Stack<Integer> dernieresOperations;

	/** Initialiser la ligne sur laquelle travaille
	 * cette commande.
	 * @param l la ligne
	 */
	//@ requires l != null;	// la ligne doit être définie
	public CommandeAjouterFin(Ligne l) {
		super(l);
		dernieresOperations = new Stack<>();
	}

	public void executer() {
		String texte = Console.readLine("Texte à insérer : ");
		for (int i = 0; i < texte.length(); i++) {
			ligne.ajouterFin(texte.charAt(i));
		}

		dernieresOperations.add(texte.length());
		CommandeAnnulerOperation.ajouterOperation(this);
	}

	public boolean estExecutable() {
		return true;
	}

	@Override
	public void annulerCommande() {
		for(int i = 0; i < dernieresOperations.peek(); i++) {
			ligne.supprimerDernier();
		}

		dernieresOperations.pop();
	}
}
