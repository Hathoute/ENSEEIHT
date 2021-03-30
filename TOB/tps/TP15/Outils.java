import java.util.ArrayList;
import java.util.List;

/** Quelques outils (méthodes) sur les listes.  */
public class Outils {

	/** Retourne vrai ssi tous les éléments de la collection respectent le critère. */
	public static <E> boolean tous(
			List<? extends E> elements,
			Critere<E> critere)
	{
		for (E elt : elements) {
			if (!critere.satisfaitSur(elt))
				return false;
		}

		return true;
	}


	/** Ajouter dans resultat tous les éléments de la source
	 * qui satisfont le critère aGarder.
	 */
	public static <E> void filtrer(
			List<E> source,
			Critere<? super E> aGarder,
			List<? super E> resultat)
	{
		for (E elt : source) {
			if (aGarder.satisfaitSur(elt))
				resultat.add(elt);
		}
	}

}
