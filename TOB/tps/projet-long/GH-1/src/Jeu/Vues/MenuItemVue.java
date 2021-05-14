package Jeu.Vues;

import Jeu.FichePersonnageSwing;
import Jeu.Modeles.ModeleFichePersonnage;
import Jeu.Utils;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class MenuItemVue extends JPanel {
    private final ModeleFichePersonnage modele;

    private JButton btnAppercue;
    private JButton btnModifier;
    private JButton btnSupprimer;

    public MenuItemVue(ModeleFichePersonnage modele, ActionListener onModifier, ActionListener onSupprimer) {
        this.modele = modele;

        configurerVues();

        btnModifier.addActionListener(onModifier);
        btnSupprimer.addActionListener(onSupprimer);
        btnAppercue.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                new FichePersonnageSwing(modele);
            }
        });
    }

    private void configurerVues() {
        JLabel lblTitre = new JLabel(modele.getNom());
        lblTitre.setIcon(Utils.getMiniIcon(modele.getImage()));
        btnAppercue = new JButton("A");
        btnModifier = new JButton("M");
        btnSupprimer = new JButton("S");

        setLayout(new BoxLayout(this, BoxLayout.LINE_AXIS));
        add(lblTitre);
        add(Box.createHorizontalGlue());
        add(btnAppercue);
        add(btnModifier);
        add(btnSupprimer);
    }
}