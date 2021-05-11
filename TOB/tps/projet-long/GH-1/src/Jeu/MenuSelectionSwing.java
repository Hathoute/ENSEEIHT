package Jeu;

import Jeu.Modeles.ModeleFichePersonnage;
import Jeu.Vues.MenuListVue;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.List;

public class MenuSelectionSwing {

    private JFrame fenetre;

    private MenuListVue menuListe;
    private JButton btnAjouter;
    private JButton btnSauvegarder;

    private List<ModeleFichePersonnage> listModel;

    public MenuSelectionSwing() {
        this.fenetre = new JFrame("Menu Principale");

        configurerVues();

        configurerActions();

        this.fenetre.pack();
        this.fenetre.setVisible(true);
    }

    private void configurerVues() {
        JPanel panel = new JPanel();
        panel.setLayout(new BoxLayout(panel, BoxLayout.PAGE_AXIS));

        listModel = new ArrayList<>();
        listModel.add(new ModeleFichePersonnage("nom", "role", null, "10", ""));
        listModel.add(new ModeleFichePersonnage("nom2", "role2", null, "10", ""));
        listModel.add(new ModeleFichePersonnage("nom3", "role3", null, "10", ""));
        listModel.add(new ModeleFichePersonnage("nom3", "role3", null, "10", ""));
        listModel.add(new ModeleFichePersonnage("nom3", "role3", null, "10", ""));
        listModel.add(new ModeleFichePersonnage("nom3", "role3", null, "10", ""));
        menuListe = new MenuListVue(listModel);

        panel.add(menuListe);
        panel.add(Box.createVerticalStrut(10));

        Container ctr = new Container();
        ctr.setLayout(new GridLayout(1, 2));

        btnAjouter = new JButton("Ajouter");
        btnSauvegarder = new JButton("Sauvegarder");
        ctr.add(btnAjouter);
        ctr.add(btnSauvegarder);
        panel.add(ctr);

        fenetre.setContentPane(panel);
    }

    private void configurerActions() {
        btnAjouter.addActionListener(e -> {
            listModel.add(new ModeleFichePersonnage("Nouveau joueur", "", null, "0", ""));
            menuListe.majElements();
        });

        btnSauvegarder.addActionListener(e -> System.out.println("Non implémentée"));
    }
}
