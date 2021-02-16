package allumettes;

public class Arbitre {

    private Jeu jeu;
    private final Joueur j1, j2;

    // true si c'est le tour de j1.
    private boolean tourJ1;

    public Arbitre(Joueur j1, Joueur j2) {
        this.j1 = j1;
        this.j2 = j2;
        this.tourJ1 = true;
    }

    public void arbitrer(Jeu jeu) {
        this.jeu = jeu;
        debuterPartie();
    }

    private void debuterPartie() {
        while(pasDeGagnant()) {
            jouerTour();
            tourJ1 = !tourJ1;
            System.out.println();
        }
    }

    private void jouerTour() {
        System.out.println("Nombre d'allumettes restantes : " + jeu.getNombreAllumettes());

        Joueur joueur = tourJ1 ? j1 : j2;
        while(true) {
            int prise = joueur.getPrise(jeu);

            System.out.println(joueur.getNom() + " prend " + prise + " allumette" +
                    (prise > 1 ? "s" : ""));

            try {
                jeu.retirer(prise);
            } catch(CoupInvalideException e) {
                System.out.println(" Impossible ! Nombre d'allumettes invalide : " +
                        e.getNombreAllumettes() + " (" + e.getMessage() + ")");
                continue;
            }
            break;
        }
    }

    private boolean pasDeGagnant() {
        if(jeu.getNombreAllumettes() > 0)
            return true;

        System.out.println((tourJ1 ? j2 : j1).getNom() + " perd !");
        System.out.println((tourJ1 ? j1 : j2).getNom() + " gagne !");
        return false;
    }
}
