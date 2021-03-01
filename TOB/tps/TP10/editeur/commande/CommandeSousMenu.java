package editeur.commande;

import editeur.Ligne;
import menu.SousMenu;
import util.Console;

/** Affiche un sous menu
 * @author	Hathoute Hamza
 * @version	1.0
 */
public class CommandeSousMenu
        extends CommandeLigne
{

    private SousMenu sousMenu;

    /** Initialiser la ligne sur laquelle travaille
     * cette commande.
     * @param l la ligne
     * @param sousMenu le sous menu
     */
    //@ requires l != null;	// la ligne doit être définie
    public CommandeSousMenu(Ligne l, SousMenu sousMenu) {
        super(l);
        this.sousMenu = sousMenu;
    }

    public void executer() {
        do {
            System.out.println();
            ligne.afficher();
            System.out.println();

            sousMenu.executer();
        } while (!sousMenu.getSeulAffichage() && !sousMenu.estQuitte());
    }

    public boolean estExecutable() {
        return sousMenu.estExecutable();
    }

}
