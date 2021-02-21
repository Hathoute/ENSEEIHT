package allumettes;

/** Lance une partie des 13 allumettes en fonction des arguments fournis
 * sur la ligne de commande.
 * @author	Xavier Crégut
 * @version	$Revision: 1.5 $
 */
public class Jouer {


	enum Strategie {
		HUMAIN,
		NAIF,
		RAPIDE,
		EXPERT,
		TRICHEUR
	}

	/** Lancer une partie. En argument sont donnés les deux joueurs sous
	 * la forme nom@stratégie.
	 * @param args la description des deux joueurs
	 */
	public static void main(String[] args) {
		try {
			//TODO: remove!
			boolean isDebug = java.lang.management.ManagementFactory.getRuntimeMXBean().getInputArguments().toString().contains("-agentlib:jdwp");
			if(isDebug) {
				args = "-confiant aaa@Tricheur bbb@Naif".split(" ");
			}

			verifierNombreArguments(args);

			boolean modeConfiant = false;
			if(args.length == 3) {
				if(!args[0].equals("-confiant"))
					throw new ConfigurationException("Option " + args[0] + " non reconnue");

				modeConfiant = true;
			}

			Joueur j1 = creerJoueur(args[modeConfiant ? 1 : 0]);
			Joueur j2 = creerJoueur(args[modeConfiant ? 2 : 1]);
			Jeu jeu = new Allumettes();
			Arbitre arbitre = new Arbitre(j1, j2, modeConfiant);
			arbitre.arbitrer(jeu);

		} catch (ConfigurationException | IdentifiantJoueurException e) {
			System.out.println();
			System.out.println("Erreur : " + e.getMessage());
			afficherUsage();
			System.exit(1);
		}
	}

	private static Joueur creerJoueur(String identifiant) throws IdentifiantJoueurException {
		String[] parties = identifiant.split("@");
		if(parties.length != 2)
			throw new IdentifiantJoueurException("Format Invalide");

		String nom = parties[0];
		IStrategie strategie = creerStrategie(parties[1]);
		return new Joueur(nom, strategie);
	}

	private static IStrategie creerStrategie(String nomStrategie) throws IdentifiantJoueurException {
		Strategie strategie;
		try {
			strategie = Strategie.valueOf(nomStrategie.toUpperCase());
		} catch (IllegalArgumentException e) {
			throw new IdentifiantJoueurException("Stratégie Invalide");
		}

		switch (strategie) {
			case TRICHEUR:
				return new StrategieTricheur();
			case EXPERT:
				return new StrategieExpert();
			case RAPIDE:
				return new StrategieRapide();
			case NAIF:
				return new StrategieNaive();
			case HUMAIN:
				return new StrategieHumaine();
			default:
				throw new IdentifiantJoueurException("Stratégie non implémentée");
		}
	}

	private static void verifierNombreArguments(String[] args) {
		final int nbJoueurs = 2;
		if (args.length < nbJoueurs) {
			throw new ConfigurationException("Trop peu d'arguments : "
					+ args.length);
		}
		if (args.length > nbJoueurs + 1) {
			throw new ConfigurationException("Trop d'arguments : "
					+ args.length);
		}
	}

	/** Afficher des indications sur la manière d'exécuter cette classe. */
	public static void afficherUsage() {
		System.out.println("\n" + "Usage :"
				+ "\n\t" + "java allumettes.Jouer joueur1 joueur2"
				+ "\n\t\t" + "joueur est de la forme nom@stratégie"
				+ "\n\t\t" + "strategie = naif | rapide | expert | humain | tricheur"
				+ "\n"
				+ "\n\t" + "Exemple :"
				+ "\n\t" + "	java allumettes.Jouer Xavier@humain "
					   + "Ordinateur@naif"
				+ "\n"
				);
	}

}
