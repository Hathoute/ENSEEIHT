import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Observable;
import java.util.Observer;

public class ChatSwing {

    private JFrame fenetre;
    private Chat model;
    private String pseudo;

    public ChatSwing(String pseudo, Chat model) {
        this.fenetre = new JFrame("Chat de " + pseudo);

        this.pseudo = pseudo;
        this.model = model;

        configurerVue();

        this.fenetre.pack();
        this.fenetre.setVisible(true);
    }

    private void configurerVue() {
        final JPanel borderPanel = new JPanel(new BorderLayout());

        JButton fermerButton = new JButton("Fermer");
        borderPanel.add(fermerButton, BorderLayout.NORTH);
        borderPanel.add(new VueChat(model), BorderLayout.CENTER);
        borderPanel.add(new ControleurChat(pseudo, model), BorderLayout.SOUTH);

        fermerButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                fenetre.dispose();
            }
        });

        this.fenetre.getContentPane().add(borderPanel);
    }



    public static void main(String[] args) {
        Chat chat = new Chat();
        ChatSwing chat1 = new ChatSwing("Moi", chat);
        ChatSwing chat2 = new ChatSwing("Toi", chat);
    }
}
