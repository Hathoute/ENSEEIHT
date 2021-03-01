package menu;

public class EntreeRaccourci extends Entree {

    private String raccourci;

    /**
     * Construire une entrée à partir d'un intitulé, un raccourci et d'une commande.
     *
     * @param unIntitule  l'intitulé de l'entrée
     * @param raccourci   le raccourci de l'entrée
     * @param uneCommande l'intitulé de la commande
     */
    public EntreeRaccourci(String unIntitule, String raccourci, Commande uneCommande) {
        super(unIntitule, uneCommande);
        this.raccourci = raccourci;
    }

    public String getRaccourci() {
        return raccourci;
    }

    @Override
    public void afficher(int numero) {
        if (getCommande().estExecutable()) {
            String num = "" + numero;
            if (num.length() < 2) {
                System.out.print(" ");
            }
            System.out.print(num);
        } else {
            System.out.print(" -");
        }
        System.out.print(") ");
        System.out.print(getIntitule());

        System.out.print(" [" + (getCommande().estExecutable() ? raccourci : "-") + "]");

        System.out.println();
    }
}
