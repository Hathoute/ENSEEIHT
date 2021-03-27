import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;
import java.io.*;
import java.util.zip.*;
import java.time.LocalDateTime;


/**
 * La classe principale.
 *
 * Tous les traitements demandés sont faits dans la mêthode
 * {@code repondreQuestions}.
 * Il serait plus logique d'écrire des méthodes qui pemettraient d'améliorer
 * la structuration et la réutilisation.  Cependant l'objectif est ici la
 * manipulation de l'API des collections, pas la structuration du code
 * en sous-programmes.
 */

public class Main {

	private static void repondreQuestions(Reader in) {
		Iterable<PointDeVente> iterable = PointDeVenteUtils.fromXML(in);

		// Construire un tableau associatif (pdvs) des points de vente avec un
		// accès par identifiant
		Map<Long, PointDeVente> pdvs = new HashMap<>();
		for (PointDeVente pdv : iterable) {
			pdvs.put(pdv.getIdentifiant(), pdv);
		}

		// Nombre de point de vente
		System.out.println("Nombre de points de vente: " + pdvs.size());


		// Afficher le nombre de services existants
		Set<String> services = new HashSet<>();
		for(PointDeVente pdv : pdvs.values()) {
			services.addAll(pdv.getServices());
		}
		System.out.println("Nombre de services existants: " + services.size());

		// Afficher les services fournis
		for (String svc : services) {
			System.out.println("Service: " + svc);
		}

		// Afficher la ville correspondant au point de vente d'identifiant
		// 31075001 et le prix du gazole le 25 janvier 2017 à 10h.
		PointDeVente pdv = pdvs.get(Long.decode("31075001"));
		System.out.println("Ville du pdv 31075001: " + pdv.getVille());
		System.out.println("Prix du gazole le 25 janvier 2017 à 10h: " +
				pdv.getPrix(Carburant.GAZOLE, LocalDateTime.parse("2017-01-25T10:00:00")));


		// Afficher le nombre de villes offrant au moins un point de vente
		Set<String> villes = new HashSet<>();
		for (PointDeVente pv : pdvs.values()) {
			villes.add(pv.getVille());
		}
		System.out.println("Nombre de villes offrant au moins un point de vente: " + villes.size());

		// Afficher le nombre moyen de points de vente par ville
		System.out.println("Nombre moyen de pdv par ville: " + ((float)pdvs.size())/villes.size());

		// le nombre de villes offrants un certain nombre de carburants
		// Réponse dans le pdf...

		// Afficher le nombre et les points de vente dont le code postal est 31200
		// Réponse dans le pdf...

		// Nombre de PDV de la ville de Toulouse qui proposent et du Gazole
		// et du GPLc.

		List<PointDeVente> pdvsTls = pdvs.values().stream()
				.filter(x -> x.getVille().equals("Toulouse"))
				.filter(x -> x.getPrix().containsKey(Carburant.GPLc))
				.filter(x -> x.getPrix().containsKey(Carburant.GAZOLE))
				.collect(Collectors.toList());

		System.out.println("Nombre de PDV de Toulouse qui proposent Gazole et GPLc: " + pdvsTls.size());

		// Afficher le nom et le nombre de points de vente des villes qui ont au
		// moins 20 points de vente

		Map<String, Long> villes20Pdv = pdvs.values().stream()
				.map(PointDeVente::getVille)
				.collect(Collectors.groupingBy(Function.identity(), Collectors.counting()));

		villes20Pdv.keySet().stream()
				.filter(x -> villes20Pdv.get(x) >= 20)
				.forEach(x -> System.out.println("La ville " + x + " a " + villes20Pdv.get(x)));
	}


	private static Reader ouvrir(String nomFichier)
			throws FileNotFoundException, IOException
	{
		if (nomFichier.endsWith(".zip")) {
			// On suppose que l'archive est bien formée :
			// elle contient fichier XML !
			ZipFile zfile = new ZipFile(nomFichier);
			ZipEntry premiere = zfile.entries().nextElement();
			return new InputStreamReader(zfile.getInputStream(premiere));
		} else {
			return new FileReader(nomFichier);
		}
	}


	public static void main(String[] args) {

		args = new String[1];
		args[0] = "PrixCarburants_annuel_2017.zip";

		if (args.length != 1) {
			System.out.println("usage : java Main <fichier.xml ou fichier.zip>");
		} else {
			try (Reader in = ouvrir(args[0])) {
				repondreQuestions(in);
			} catch (FileNotFoundException e) {
				System.out.println("Fichier non trouvé : " + args[0]);
			} catch (Exception e) {
				System.out.println(e.getMessage());
				e.printStackTrace();
			}
		}
	}

}
