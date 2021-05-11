package Jeu.Vues;

import Jeu.Modeles.ModeleFichePersonnage;

import javax.swing.*;
import java.awt.*;
import java.util.List;

public class MenuListVue extends JScrollPane {
    private List<ModeleFichePersonnage> modeles;
    private JPanel panel;

    public MenuListVue(List<ModeleFichePersonnage> modeles) {
        this.modeles = modeles;

        configurerVues();
    }

    private void configurerVues() {
        panel = new JPanel();
        panel.setLayout(new BoxLayout(panel, BoxLayout.PAGE_AXIS));
        setViewportView(panel);

        majElements();
    }

    public void majElements() {
        panel.removeAll();
        for (ModeleFichePersonnage modele : modeles) {
            panel.add(new MenuItemVue(modele, e -> onModifyPressed(modele), e -> onDeletePressed(modele)));
        }

        if (getParent() != null) {
            getParent().revalidate();
        }
    }

    private void onModifyPressed(ModeleFichePersonnage modele) {
        System.out.println("Non implémentée...");
    }

    private void onDeletePressed(ModeleFichePersonnage modele) {
        modeles.remove(modele);
        majElements();
    }
}
