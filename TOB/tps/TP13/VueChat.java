import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Observable;
import java.util.Observer;

public class VueChat extends JPanel implements Observer {

    private JTextArea chatTexte;

    public VueChat(Chat model) {

        model.addObserver(this);

        configurerVue();
    }

    private void configurerVue() {
        this.setLayout(new BorderLayout());

        chatTexte = new JTextArea(10, 40);
        chatTexte.setEditable(false);
        this.add(chatTexte, BorderLayout.CENTER);
    }

    @Override
    public void update(Observable o, Object arg) {
        if (!(arg instanceof Message))
            return;

        chatTexte.append(arg.toString() + "\n");
    }
}
