package editeur.commande;

import editeur.Ligne;

/** Avancer le curseur d'une position.
 * @author	Xavier Crégut
 * @version	1.4
 */
public class CommandeCurseurAvancer
	extends CommandeLigne
	implements CommandeReversible
{
	/** Initialiser la ligne sur laquelle travaille
	 * cette commande.
	 * @param l la ligne
	 */
	//@ requires l != null;	// la ligne doit être définie
	public CommandeCurseurAvancer(Ligne l) {
		super(l);
	}

	public void executer() {
		ligne.avancer();
		CommandeAnnulerOperation.ajouterOperation(this);
	}

	public boolean estExecutable() {
		return ligne.getCurseur() < ligne.getLongueur();
	}

	@Override
	public void annulerCommande() {
		ligne.reculer();
	}
}
