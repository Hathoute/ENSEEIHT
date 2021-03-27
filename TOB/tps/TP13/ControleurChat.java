import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Observable;
import java.util.Observer;

public class ControleurChat extends JPanel {

    private Chat model;
    private String pseudo;

    private JTextArea chatTexte;

    public ControleurChat(String pseudo, Chat model) {

        this.pseudo = pseudo;
        this.model = model;

        configurerVue();
    }

    private void configurerVue() {
        setLayout(new BorderLayout());

        JLabel label = new JLabel();
        label.setText(pseudo);
        add(label, BorderLayout.WEST);

        JTextField messageField = new JTextField();
        add(messageField, BorderLayout.CENTER);

        JButton btnEnvoyer = new JButton("OK");
        add(btnEnvoyer, BorderLayout.EAST);

        btnEnvoyer.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String texte = messageField.getText();
                if(texte.isEmpty())
                    return;

                model.ajouter(new MessageTexte(pseudo, texte));
                messageField.setText("");
            }
        });
    }
}
