package editeur.commande;

import editeur.Ligne;
import menu.Commande;
import util.Console;

import java.util.Stack;

/** Mettre le curseur en début de ligne.
 * @author	Hathoute Hamza
 * @version	1.0
 */
public class CommandeAnnulerOperation
        implements Commande
{

    private static CommandeAnnulerOperation instance;
    private static Stack<CommandeReversible> operationsEffectues;

    /** Initialiser de la commande
     */
    private CommandeAnnulerOperation() {
        operationsEffectues = new Stack<>();
    }

    public static CommandeAnnulerOperation getInstance() {
        if(instance == null)
            instance = new CommandeAnnulerOperation();

        return instance;
    }

    public void executer() {
        operationsEffectues.pop().annulerCommande();
    }

    public boolean estExecutable() {
        return !operationsEffectues.isEmpty();
    }

    public static void ajouterOperation(CommandeReversible operation) {
        operationsEffectues.add(operation);
    }
}
