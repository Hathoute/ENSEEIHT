import org.junit.*;
import static org.junit.Assert.*;
import java.util.*;

public class TestOutilsFiltrerStringObject extends TestOutilsFiltrerString {

	@Test
	public void testerListString() {
		List<String> mots4 = new ArrayList<>();
		Outils.filtrer(nombres, deLongueur4, mots4);
		assertEquals(3, mots4.size());
		assertEquals(new ArrayList<>( Arrays.asList("deux", "cinq", "sept") ), mots4);
	}

}
