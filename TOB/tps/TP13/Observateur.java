import java.util.Observable;
import java.util.Observer;

public class Observateur implements Observer {
    @Override
    public void update(Observable o, Object arg) {
        if (!(arg instanceof Message))
            return;

        System.out.println(arg.toString());
    }

    public static void main(String[] args) {
        Chat chat = new Chat();
        Observer observer = new Observateur();
        chat.addObserver(observer);
        chat.ajouter(new MessageTexte("User1", "Texte1"));
        chat.ajouter(new MessageTexte("User2", "Texte2"));
        chat.ajouter(new MessageTexte("User3", "Texte3"));
    }
}
