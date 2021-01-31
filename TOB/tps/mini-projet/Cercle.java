import java.awt.Color;

/** Cercle modélise un cercle dans un repère cartésien.
 * Un cercle peut être affiché, mesuré et translaté.
 * Son rayon et son diamétre peuvent être obtenues/modifiés.
 *
 * @author  HATHOUTE Hamza
 */
public class Cercle implements Mesurable2D {

    /** Valeur de PI. */
    public static final double PI = Math.PI;

    /** Centre du cercle. */
    private final Point centre;
    /** Rayon du cercle. */
    private double rayon;
    /** Couleur du cercle. */
    private Color couleur;

    /** Construire un cercle de couleur bleue à partir de son centre et son rayon.
     * @param centre Centre
     * @param rayon Rayon
     */
    public Cercle(Point centre, double rayon) {
        assert centre != null;
        assert rayon > 0;

        this.centre = new Point(centre.getX(), centre.getY());
        this.rayon = rayon;
        this.couleur = Color.blue;
    }

    /** Construire un cercle de couleur bleue à
     * partir de deux points diamétralement opposés.
     * @param pt1 Premier point
     * @param pt2 Deuxième point
     */
    public  Cercle(Point pt1, Point pt2) {
        assert pt1 != null && pt2 != null;
        assert pt1.getX() != pt2.getX() && pt1.getY() != pt2.getY();

        double absCercle = (pt1.getX() + pt2.getX()) / 2;
        double ordCercle = (pt1.getY() + pt2.getY()) / 2;
        this.centre = new Point(absCercle, ordCercle);
        this.rayon = pt1.distance(pt2) / 2;
        this.couleur = Color.blue;
    }

    /** Construire un cercle à partir de deux points
     * diamétralement opposés et d'une couleur.
     * @param pt1 Premier point
     * @param pt2 Deuxième point
     * @param couleur Couleur
     */
    public Cercle(Point pt1, Point pt2, Color couleur) {
        assert pt1 != null && pt2 != null;
        assert couleur != null;
        assert pt1.getX() != pt2.getX() && pt1.getY() != pt2.getY();

        double absCercle = (pt1.getX() + pt2.getX()) / 2;
        double ordCercle = (pt1.getY() + pt2.getY()) / 2;
        this.centre = new Point(absCercle, ordCercle);
        this.rayon = pt1.distance(pt2) / 2;
        this.couleur = couleur;
    }

    /** Construire un cercle à partir du centre et d'un point de la circonférence.
     * @param centre    Centre
     * @param pt        Point de la circonférence
     * @return Le cercle qui répond à ces caractéristiques.
     */
    public static Cercle creerCercle(Point centre, Point pt) {
        assert centre != null;
        assert pt != null;
        assert pt.getX() != centre.getX() && pt.getY() != centre.getY();

        return new Cercle(centre, centre.distance(pt));
    }

    /** Translater le cercle.
     * @param dx    La translation suivant les abscisses.
     * @param dy    La translation suivant les ordonnées.
     */
    public void translater(double dx, double dy) {
        centre.translater(dx, dy);
    }

    /** Obtenir le centre du cercle.
     * @return Centre du cercle
     */
    public Point getCentre() {
        return new Point(centre.getX(), centre.getY());
    }

    /** Obtenir le rayon du cercle.
     * @return Rayon du cercle
     */
    public double getRayon() {
        return this.rayon;
    }

    /** Changer le rayon du cercle.
     * @param nouveau   Nouveau rayon du cercle
     */
    public void setRayon(double nouveau) {
        assert nouveau > 0;

        rayon = nouveau;
    }

    /** Obtenir le diamètre du cercle.
     * @return Diamètre du cercle
     */
    public double getDiametre() {
        return this.rayon * 2;
    }

    /** Changer le diamètre du cercle.
     * @param nouveau   Nouveau diamètre du cercle
     */
    public void setDiametre(double nouveau) {
        assert nouveau > 0;

        rayon = nouveau / 2;
    }

    /** Obtenir la couleur du cercle.
     * @return Couleur du cercle
     */
    public Color getCouleur() {
        return couleur;
    }

    /** Changer la couleur du cercle.
     * @param nouvelle   Nouvelle couleur du cercle
     */
    public void setCouleur(Color nouvelle) {
        assert nouvelle != null;

        couleur = nouvelle;
    }

    /** Savoir si un point est à l'intérieur du cercle.
     * @param point   Point à tester.
     * @return Vrai si le point est à l'intérieur du cercle, sinon Faux
     */
    public boolean contient(Point point) {
        assert point != null;

        return centre.distance(point) <= rayon;
    }

    @Override
    public double aire() {
        return PI * rayon * rayon;
    }

    @Override
    public double perimetre() {
        return 2 * PI * rayon;
    }

    @Override
    public String toString() {
        return "C" + rayon + "@" + centre;
    }

}
