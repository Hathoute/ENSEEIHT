package allumettes;

import allumettes.strategie.StrategieTricheur;
import allumettes.strategie.StrategieExpert;
import allumettes.strategie.StrategieNaive;
import allumettes.strategie.StrategieRapide;
import allumettes.strategie.StrategieHumaine;
import allumettes.strategie.IStrategie;

/** Lance une partie des 13 allumettes en fonction des arguments fournis
 * sur la ligne de commande.
 * @author	Xavier Crégut
 * @version	$Revision: 1.5 $
 */
public class Jouer {

	private static final int ARGS_MODE_CONFIANT = 3;

	/** Lancer une partie. En argument sont donnés les deux joueurs sous
	 * la forme nom@stratégie.
	 * @param args la description des deux joueurs
	 */
	public static void main(String[] args) {
		try {
			/*//TODO: remove!
			boolean isDebug = java.lang.management.ManagementFactory.getRuntimeMXBean().getInputArguments().toString().contains("-agentlib:jdwp");
			if (isDebug) {
				args = "-confiant Xavier@humain Ordinateur@expert".split(" ");
			}*/

			verifierNombreArguments(args);

			boolean modeConfiant = false;
			if (args.length == ARGS_MODE_CONFIANT) {
				if (!args[0].equals("-confiant")) {
					throw new ConfigurationException("Option " + args[0]
							+ " non reconnue");
				}

				modeConfiant = true;
			}

			Joueur j1 = creerJoueur(args[modeConfiant ? 1 : 0]);
			Joueur j2 = creerJoueur(args[modeConfiant ? 2 : 1]);
			Jeu jeu = new JeuReel();
			Arbitre arbitre = new Arbitre(j1, j2);
			arbitre.setConfiant(modeConfiant);
			arbitre.arbitrer(jeu);

		} catch (ConfigurationException | IdentifiantJoueurException e) {
			System.out.println();
			System.out.println("Erreur : " + e.getMessage());
			afficherUsage();
			System.exit(1);
		}
	}

	private static Joueur creerJoueur(String identifiant)
			throws IdentifiantJoueurException {
		String[] parties = identifiant.split("@");
		if (parties.length != 2) {
			throw new IdentifiantJoueurException("Format Invalide");
		}

		String nom = parties[0];
		IStrategie strategie = creerStrategie(parties[1]);
		return new Joueur(nom, strategie);
	}

	private static IStrategie creerStrategie(String nomStrategie)
			throws IdentifiantJoueurException {
		switch (nomStrategie.toUpperCase()) {
			case "TRICHEUR":
				return new StrategieTricheur();
			case "EXPERT":
				return new StrategieExpert();
			case "RAPIDE":
				return new StrategieRapide();
			case "NAIF":
				return new StrategieNaive();
			case "HUMAIN":
				return new StrategieHumaine();
			default:
				throw new IdentifiantJoueurException("Stratégie Invalide");
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
