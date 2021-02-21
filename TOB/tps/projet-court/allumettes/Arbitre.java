package allumettes;

public class Arbitre {

    private Jeu jeu;
    private final Joueur j1, j2;
    private boolean estConfiant;

    // true si c'est le tour de j1.
    private boolean tourJ1;

    public Arbitre(Joueur j1, Joueur j2, boolean estConfiant) {
        this.j1 = j1;
        this.j2 = j2;
        this.estConfiant = estConfiant;
        this.tourJ1 = true;
    }

    public void arbitrer(Jeu jeu) {
        this.jeu = jeu;
        debuterPartie();
    }

    private void debuterPartie() {
        while(pasDeGagnant() && jouerTour()) {
            tourJ1 = !tourJ1;
            System.out.println();
        }
    }

    private boolean jouerTour() {
        System.out.println("Nombre d'allumettes restantes : " + jeu.getNombreAllumettes());

        Joueur joueur = tourJ1 ? j1 : j2;
        Jeu procuration = estConfiant ? jeu : new AllumettesProxy(jeu);
        while(true) {
            try {
                int prise = joueur.getPrise(procuration);
                System.out.println(joueur.getNom() + " prend " + prise + " allumette" +
                        (prise > 1 ? "s" : ""));
                jeu.retirer(prise);
            } catch(CoupInvalideException e) {
                System.out.println(" Impossible ! Nombre d'allumettes invalide : " +
                        e.getNombreAllumettes() + " (" + e.getMessage() + ")");
                continue;
            } catch (OperationInterditeException e) {
                System.out.println("Abandon de la partie car " + joueur.getNom() + " triche !");
                return false;
            }
            break;
        }

        return true;
    }

    private boolean pasDeGagnant() {
        if(jeu.getNombreAllumettes() > 0)
            return true;

        System.out.println((tourJ1 ? j2 : j1).getNom() + " perd !");
        System.out.println((tourJ1 ? j1 : j2).getNom() + " gagne !");
        return false;
    }
}
