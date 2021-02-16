import afficheur.Afficheur;
import afficheur.Ecran;

import java.awt.*;

/** ObjetGeometrique modélise un objet geometrique qu'on
 * peut dessiner.
 *
 * @author  Xavier Crégut <Prénom.Nom@enseeiht.fr>
 */
public abstract class ObjetGeometrique {

    public ObjetGeometrique() { }

    public abstract void afficher();
    public abstract void translater(double dx, double dy);
    public abstract void dessiner(Afficheur afficheur);

}
