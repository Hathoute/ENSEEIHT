import java.util.*;

public class Chat extends Observable implements Iterable<Message> {

	private List<Message> messages;
	private List<Observer> observateurs;

	public Chat() {
		this.messages = new ArrayList<>();
		this.observateurs = new ArrayList<>();
	}

	public void ajouter(Message m) {
		this.messages.add(m);
		notifyObservers(m);
	}

	@Override
	public Iterator<Message> iterator() {
		return this.messages.iterator();
	}

	@Override
	public synchronized void addObserver(Observer o) {
		observateurs.add(o);
	}

	@Override
	public synchronized void deleteObserver(Observer o) {
		observateurs.remove(o);
	}

	@Override
	public void notifyObservers(Object arg) {
		for(Observer o : observateurs) {
			o.update(this, arg);
		}
	}
}
