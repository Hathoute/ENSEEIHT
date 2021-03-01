package editeur.commande;

import editeur.Ligne;
import util.Console;

/** Mettre le curseur en début de ligne.
 * @author	Hathoute Hamza
 * @version	1.0
 */
public class CommandeCurseurDebut
        extends CommandeLigne
{

    /** Initialiser la ligne sur laquelle travaille
     * cette commande.
     * @param l la ligne
     */
    //@ requires l != null;	// la ligne doit être définie
    public CommandeCurseurDebut(Ligne l) {
        super(l);
    }

    public void executer() {
        ligne.raz();
    }

    public boolean estExecutable() {
        return ligne.getCurseur() > 1;
    }

}
