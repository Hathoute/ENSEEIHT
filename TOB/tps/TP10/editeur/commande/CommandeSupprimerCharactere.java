package editeur.commande;

import editeur.Ligne;
import util.Console;

/** Supprimer le charactère sous le curseur
 * @author	Hathoute Hamza
 * @version	1.0
 */
public class CommandeSupprimerCharactere
        extends CommandeLigne
{

    /** Initialiser la ligne sur laquelle travaille
     * cette commande.
     * @param l la ligne
     */
    //@ requires l != null;	// la ligne doit être définie
    public CommandeSupprimerCharactere(Ligne l) {
        super(l);
    }

    public void executer() {
        ligne.supprimer();
    }

    public boolean estExecutable() {
        return ligne.getLongueur() > 0;
    }

}
