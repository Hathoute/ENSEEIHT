import afficheur.AfficheurSVG;
import afficheur.Ecran;

import java.awt.Color;

/** Un segment est défini pas ses deux points qui constituent ses
 * extrémités.  Un segment peut être affiché et translaté.
 *
 * @author	Xavier Crégut
 * @version	1.9
 */
public class Segment {

	private Point extremite1;
	private Point extremite2;
	private Color couleur;

	/**  Construire un Segment à partir de ses deux points extrémités.
	 *  @param ext1	le premier point extrémité
	 *  @param ext2	le deuxième point extrémité
	 */
	public Segment(Point ext1, Point ext2) {
		this.extremite1 = ext1;
		this.extremite2 = ext2;
		this.couleur = Color.green;
	}

   /** Translater le segment.
	* @param dx déplacement suivant l'axe des X
	* @param dy déplacement suivant l'axe des Y
	*/
	public void translater(double dx, double dy) {
		extremite1.translater(dx, dy);
		extremite2.translater(dx, dy);
	}

	/** Obtenir la longueur du segment.
	 * @return la longueur du segment
	 */
	public double getLongueur() {
		return this.extremite1.distance(this.extremite2);
	}

	/** @deprecated Cette méthode a changé de nom pour respecter
	 * la convention de nommage préconisée par Sun pour Java.
	 * @see #getLongueur()
	 */
	@Deprecated public double longueur() {
		return this.extremite1.distance(this.extremite2);
	}

	/** Afficher le segment.  Le segment est affiché sous la forme :
	 * <PRE>
	 *		[extremite1-extremite2]
	 * </PRE>
	 */
	public void afficher() {
		System.out.print("[");
		this.extremite1.afficher();
		System.out.print("-");
		this.extremite2.afficher();
		System.out.print("]");
	}

	/** Obtenir la couleur du segment.
	 * @return la couleur du segment
	 */
	public Color getCouleur() {
		return this.couleur;
	}

	/** Changer la couleur du segment.
	 * @param nouvelleCouleur nouvelle couleur
	 */
	public void setCouleur(Color nouvelleCouleur) {
		this.couleur = nouvelleCouleur;
	}

	/** Dessiner le segment dans un écran.
	 * @param ecran Ecran de dessin
	 */
	public void dessiner(Ecran ecran) {
		ecran.dessinerLigne(extremite1.getX(), extremite1.getY(),
				extremite2.getX(), extremite2.getY(),
				couleur);
	}

	/** Dessiner le segment dans un Afficheur SVG.
	 * @param afficheurSVG Afficheur de dessin
	 */
	public void dessiner(AfficheurSVG afficheurSVG) {
		afficheurSVG.dessinerLigne(extremite1.getX(), extremite1.getY(),
				extremite2.getX(), extremite2.getY(),
				couleur);
	}
}
