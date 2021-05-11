package Jeu;

import Jeu.Modeles.ModeleFichePersonnage;
import Jeu.Modeles.ModeleMaitreJeu;
import Jeu.Vues.TexteActionVue;

import javax.swing.*;
import javax.swing.border.Border;

import java.awt.*;
import java.awt.event.*;
import java.io.File;
import java.util.*;

/** Programmation de l'interface du maitre du jeu avec une interface graphique Swing.
  *
  *
  * @author    Kamal Hammi
  * @version    $Version: 1.0 $
  */

public class  MaitreJeuSwing {

// Choix de rÃ©alisation :
// ----------------------
//

    private final ModeleMaitreJeu modele;    // le modÃ¨le du maitre de jeu.

//  Les Ã©lÃ©ments de la vue (IHM)
//  ----------------------------

    /** FenÃªtre principale */
    private final JFrame fenetre;

    private final HashMap<ModeleFichePersonnage,FichePersonnageSwing> listModeleFichesSwing = new HashMap<>();
	
    /** Bouton pour Modifier l'image du joueur */
    private final JButton boutonModifierImage = new JButton("Modifier");

    private final JButton boutonCreerFiche = new JButton("Creer fiche");

    private final JButton boutonReset = new JButton("Réinitialiser");

    private final JTextField nomTexte = new JTextField(6);
    private final JTextField roleTexte = new JTextField(6);
    private final JProgressBar vieValeur = new JProgressBar(0, 100);
    /** Image du jouer */
    private final JLabel labelImage = new JLabel();
    private ImageIcon image;

    private TexteActionVue capacite;
    private TexteActionVue ajouterInventaire;
    private TexteActionVue supprimerInventaire;

    private final Container contenu21 = new Container();
    private final JLabel contenu22 = new JLabel();
// Le constructeur
// ---------------

    /** Construire l'interface du maitre du jeu */
    public MaitreJeuSwing() {
        this(new ModeleMaitreJeu());
    }

    /** Construire l'interface du maitre du jeu */
    public MaitreJeuSwing(ModeleMaitreJeu modele) {
        // Initialiser le modÃ¨le
        this.modele = modele;

        // Construire la vue (prÃ©sentation)
        //    DÃ©finir la fenÃªtre principale
        this.fenetre = new JFrame("Joueur");
        this.fenetre.setLocation(100, 200);

        configurerVues();

        configurerActions();

        // afficher la fenÃªtre
        this.fenetre.pack();
        this.fenetre.setVisible(true);
	}

	private void configurerVues() {
        final JLabel nom = new JLabel("Nom");
        final JLabel role = new JLabel("Role");
        final JLabel capacites = new JLabel("Capacités");
        final JLabel inventaire= new JLabel("Inventaire");

        JPanel contenuPrincipale = new JPanel();
        contenuPrincipale.setBorder(BorderFactory.createEmptyBorder(5, 5, 5, 5));
        this.fenetre.setContentPane(contenuPrincipale);


        Container contenuHaut = new Container();
        Container contenuBas = new Container();

        contenuPrincipale.setLayout (new BoxLayout(contenuPrincipale, BoxLayout.PAGE_AXIS));

        contenuPrincipale.add(contenuHaut);
        contenuPrincipale.add(Box.createRigidArea(new Dimension(1, 30)));
        contenuPrincipale.add(contenuBas);

        GridLayout gl = new GridLayout(1, 2);
        gl.setHgap(20);
        contenuHaut.setLayout (gl);

        Container contenu1 = new Container();
        Container contenu2 = new Container();

        contenuHaut.add(contenu1);
        contenuHaut.add(contenu2);

        contenu1.setLayout (new BoxLayout(contenu1, BoxLayout.PAGE_AXIS));
        contenu2.setLayout (new BoxLayout(contenu2, BoxLayout.PAGE_AXIS));

        Container contenuImage = new Container();
        contenuImage.setLayout(new FlowLayout());
        contenuImage.add(boutonModifierImage);

        // Afficher une image par défaut.
        image = Utils.loadImage(new File("ressources/dauphin-bebou.jpg"));
        labelImage.setIcon(image);
        labelImage.setAlignmentX(Component.CENTER_ALIGNMENT);
        contenu1.add(labelImage);
        contenu1.add(contenuImage);
        contenu1.add(Box.createVerticalStrut(10));

        Container contenu11 = new Container();
        Container contenu12 = new Container();

        contenu1.add(contenu11);
        contenu1.add(contenu12);

        contenu11.setLayout (new GridLayout(1,2));
        contenu12.setLayout (new GridLayout(1,2));

        contenu11.add(nom);
        contenu11.add(nomTexte);
        contenu12.add(role);
        contenu12.add(roleTexte);

        Container contenuFiche = new Container();
        contenuFiche.setLayout(new FlowLayout());
        //contenuFiche.add(boutonImprimerFiche);
        contenu1.add(contenuFiche);

        Container contenuVie = new Container();
        contenuVie.setLayout (new FlowLayout());

        //contenuVie.add(vie);
        vieValeur.setValue(10);
        vieValeur.setStringPainted(true);
        vieValeur.setString("Vie");
        //contenuVie.add(vieValeur);

        contenu2.add(Box.createVerticalStrut(10));
        contenu2.add(vieValeur);

        Border blackline = BorderFactory.createLineBorder(Color.black);
        JPanel panel = new JPanel();
        panel.setLayout(new FlowLayout());
        panel.setBorder(blackline);
        panel.add(contenu21);

        capacites.setAlignmentX(Component.CENTER_ALIGNMENT);
        contenu2.add(capacites);
        //contenu2.add(contenu21);
        contenu2.add(panel);

        panel = new JPanel();
        panel.setLayout(new FlowLayout());
        panel.setBorder(blackline);
        panel.add(contenu22);
        inventaire.setAlignmentX(Component.CENTER_ALIGNMENT);
        contenu2.add(inventaire);
        contenu2.add(panel);


        // ContenuBas
        Container contenuBas1 = new Container();

        contenuBas.setLayout(new BoxLayout(contenuBas, BoxLayout.PAGE_AXIS));
        contenuBas.add(contenuBas1);

        Container contenuBas2 = new Container ();
        contenuBas.add(contenuBas2);

        //contenuBas2.setLayout (new GridLayout(1,2));
        contenuBas2.setLayout(new FlowLayout());
        contenuBas2.add(boutonReset);
        contenuBas2.add(boutonCreerFiche);
        contenuBas1.setLayout (new BoxLayout(contenuBas1, BoxLayout.PAGE_AXIS));

        capacite = new TexteActionVue("Ajouter une capacité", e -> modifierCapacites());
        ajouterInventaire = new TexteActionVue("Ajouter à l'inventaire", e -> modifierInventaire(true));
        supprimerInventaire = new TexteActionVue("Supprimer de l'inventaire", e -> modifierInventaire(false));
        contenuBas1.add(capacite);
        contenuBas1.add(ajouterInventaire);
        contenuBas1.add(supprimerInventaire);
    }

    private void configurerActions() {
        // Construire le contrÃ´leur (gestion des Ã©vÃ©nements)
        this.boutonModifierImage.addActionListener(e -> modifierImage());
        this.boutonReset.addActionListener(e -> reinitialiser());
        this.boutonCreerFiche.addActionListener(e -> creerFiche());

        this.vieValeur.addMouseListener(new MouseAdapter() {
            @Override
            public void mousePressed(MouseEvent e) {
                double pourcentage = ((double)e.getX())/vieValeur.getWidth();
                vieValeur.setValue((int)(pourcentage*100));
            }
        });

        this.fenetre.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }

// Quelques rÃ©actions aux interactions de l'utilisateur
// ----------------------------------------------------

    public void creerFiche() {
        if (nomTexte.getText().length() > 0) {
            ModeleFichePersonnage modeleFiche = new ModeleFichePersonnage(
                    nomTexte.getText(),
                    roleTexte.getText(),
                    image,
                    String.valueOf(vieValeur.getValue()),
                    modele.getInventaire()
            );
            for(Map.Entry<String,JTextField> e : modele.getCapacites().entrySet()){
                modeleFiche.ajouterCapacite(e.getKey(),e.getValue().getText());
            }
            for(Map.Entry<ModeleFichePersonnage,FichePersonnageSwing> e : listModeleFichesSwing.entrySet()){
                if(e.getKey().estEgale(modeleFiche) | e.getKey().getNom().equals(nomTexte.getText())){
                    e.getValue().getfenetre().setVisible(false);
                    break;
                }
            }
            listModeleFichesSwing.put(modeleFiche,new FichePersonnageSwing(modeleFiche));
        }
    }

    public void reinitialiser() {
        modele.reinitialiser();
        contenu22.setText(modele.getInventaire());
        contenu21.removeAll();
        nomTexte.removeAll();
        image = Utils.loadImage(new File("ressources/dauphin-bebou.jpg"));
        labelImage.setIcon(image);

    }
	
    /** Modifier l’image du joueur. */
    public void modifierImage() {
        ImageIcon nouvelleImage = Utils.telechargerImage(this.fenetre);
        if (nouvelleImage == null)
            return;

        image = nouvelleImage;
        labelImage.setIcon(image);
    }

    public void modifierCapacites() {
        if(!capacite.getTexte().equals("")){
            modele.ajouterCapacite(capacite.getTexte());
            contenu21.removeAll(); 
            contenu21.setLayout (new GridLayout(modele.getCapacites().size(),2));
            for(Map.Entry<String,JTextField> e : modele.getCapacites().entrySet()){
                contenu21.add(new JLabel(e.getKey()));
                contenu21.add(e.getValue());
            }
            contenu21.revalidate();
        }
    }

	
    public void modifierInventaire(boolean ajouter){
        if(!ajouterInventaire.getTexte().equals("") && ajouter){
            modele.ajouterInventaire(ajouterInventaire.getTexte());
        }
        if (!supprimerInventaire.getTexte().equals("") && !ajouter){
            modele.supprimerInventaire(supprimerInventaire.getTexte());
        }
	    contenu22.setText(modele.getInventaire());
    }
}

