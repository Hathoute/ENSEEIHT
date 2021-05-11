package Jeu.Vues;

import Jeu.Modeles.ModeleFichePersonnage;

import javax.swing.*;
import java.awt.event.ActionListener;

public class MenuItemVue extends JPanel {
    private final ModeleFichePersonnage modele;

    private JLabel lblTitre;
    private JButton btnModifier;
    private JButton btnSupprimer;

    public MenuItemVue(ModeleFichePersonnage modele, ActionListener onModifier, ActionListener onSupprimer) {
        this.modele = modele;

        configurerVues();

        btnModifier.addActionListener(onModifier);
        btnSupprimer.addActionListener(onSupprimer);
    }

    private void configurerVues() {
        lblTitre = new JLabel(modele.getNom());
        btnModifier = new JButton("M");
        btnSupprimer = new JButton("S");

        setLayout(new BoxLayout(this, BoxLayout.LINE_AXIS));
        add(lblTitre);
        add(Box.createHorizontalGlue());
        add(btnModifier);
        add(btnSupprimer);
    }
}