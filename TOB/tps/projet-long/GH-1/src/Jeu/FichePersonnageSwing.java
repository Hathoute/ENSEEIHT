package Jeu;

import javax.swing.*;
import javax.swing.border.Border;

import java.awt.*;
import java.awt.event.*;
import java.io.File;
import java.util.*;

/** Programmation d’une fiche personnage de  avec une interface graphique Swing.
  *
  *
  * @author    Kamal Hammi
  * @version    $Version: 1.0 $
  */

public class  FichePersonnageSwing {

    
    

// Choix de rÃ©alisation :
// ----------------------
//
//  

    private ModeleFichePersonnage modele;    // le modÃ¨le de la fiche personnage.

//  Les Ã©lÃ©ments de la vue (IHM)
//  ----------------------------

    /** FenÃªtre principale */
    private JFrame fenetre;

    /** Bouton pour Modifier l'image du joueur*/
    private final JButton boutonModifierImage = new JButton("Modifier");

    /** Bouton pour Imprimer la fiche */
    private final JButton boutonImprimerFiche = new JButton("Imprimer fiche");

    

    /** Image du joueur */
    private final JLabel labelImage = new JLabel();


// Le constructeur
// ---------------

   

    /** Construire la fiche personnage */
    public FichePersonnageSwing(ModeleFichePersonnage modele) {
        // Initialiser le modÃ¨le
        this.modele = modele;

        final JLabel nom = new JLabel("Nom");
        final JLabel nomTexte = new JLabel(modele.getNom());
        final JLabel role = new JLabel("Role");
        final JLabel roleTexte = new JLabel(modele.getRole());
    
        final JLabel vie = new JLabel("Vie");
        final JLabel vieValeur = new JLabel(modele.getVie());
        
        final JLabel capacites = new JLabel("Capacités");
        final JLabel inventaire= new JLabel("Inventaire");
        
        // Construire la vue (prÃ©sentation)
        //    DÃ©finir la fenÃªtre principale
        this.fenetre = new JFrame("Joueur");
        this.fenetre.setLocation(500, 200);

        Container contenuPrincipale = this.fenetre.getContentPane();
        contenuPrincipale.setLayout (new BoxLayout(contenuPrincipale, BoxLayout.PAGE_AXIS));

        Container contenu1 = new Container();
        Container contenu2 = new Container();
        Container contenuHaut = new Container();
        Container contenuBas = new Container();
        
        contenuPrincipale.add(contenuHaut);
        contenuPrincipale.add(Box.createRigidArea(new Dimension(1, 30))); 
        contenuPrincipale.add(contenuBas);
        GridLayout gl = new GridLayout(1, 2);
        gl.setHgap(20);
        contenuHaut.setLayout (gl);
        
        contenuHaut.add(contenu1);
        contenuHaut.add(contenu2);

        contenu1.setLayout (new BoxLayout(contenu1, BoxLayout.PAGE_AXIS));    
        contenu2.setLayout (new BoxLayout(contenu2, BoxLayout.PAGE_AXIS));

        labelImage.setIcon(modele.getImage());
        labelImage.setAlignmentX(Component.CENTER_ALIGNMENT);
        contenu1.add(labelImage);
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

        Container contenuFiche = new Container ();
        contenu1.add(contenuFiche);
        contenuFiche.setLayout(new FlowLayout());
        contenuFiche.add(boutonImprimerFiche);
    	
        //contenu1.add(boutonImprimerFiche);

        Container contenuVie = new Container();
        contenuVie .setLayout (new GridLayout(1,2));
        
        JProgressBar barreVie = new JProgressBar();
        barreVie.setMinimum(0);
        barreVie.setMaximum(100);
        JPanel panelVieB = new JPanel();
        panelVieB.add(barreVie);
        barreVie.setValue(Integer.parseInt(modele.getVie()));
        
        JPanel pnlVie = new JPanel();
        pnlVie.setLayout(new FlowLayout());
        contenuVie.add(vie);
        contenuVie.add(barreVie);
        pnlVie.add(contenuVie);
        contenu2.add(pnlVie);
   
        capacites.setAlignmentX(Component.CENTER_ALIGNMENT);
        contenu2.add(capacites);

        Container contenu21 = new Container();
        contenu21.setLayout (new GridLayout(modele.getCapacites().size(),2));        
        JLabel contenu22 = new JLabel(modele.getInventaire());
        
        Border blackline = BorderFactory.createLineBorder(Color.black);
        JPanel panel = new JPanel();
        panel.setLayout(new FlowLayout());
        panel.setBorder(blackline);
        panel.add(contenu21);
        contenu2.add(panel);
        
        inventaire.setAlignmentX(Component.CENTER_ALIGNMENT);  
        contenu2.add(inventaire);
        panel = new JPanel();
        panel.setLayout(new FlowLayout());
        panel.setBorder(blackline);
        panel.add(contenu22);
        contenu2.add(panel);
        
        try { 
        for(Map.Entry<String,String> e : modele.getCapacites().entrySet()){
        	//try {
        		int valeur = Integer.parseInt(e.getValue());
        		contenu21.add(new JLabel(e.getKey()));
        		contenu21.add(new JLabel(e.getValue()));
        	//} catch (NumberFormatException n) {
            //    JOptionPane.showMessageDialog(fenetre, "Donnez un entier pour la valeur de la capacité.");
        	//}
        } 
        
        // Construire le contrÃ´leur (gestion des Ã©vÃ©nements)
        this.boutonModifierImage.addActionListener(new ActionModifierImage());
        this.boutonImprimerFiche.addActionListener(e -> imprimerFiche());
        this.fenetre.dispose();

        // afficher la fenÃªtre
        this.fenetre.pack();            // redimmensionner la fenÃªtre
        this.fenetre.setVisible(true);    // l'afficher
        
        } catch (NumberFormatException n) {
            JOptionPane.showMessageDialog(fenetre, "Donnez un entier pour la valeur de la capacité.");
        }        
    }

// Quelques rÃ©actions aux interactions de l'utilisateur
// ----------------------------------------------------
    public class ActionModifierImage implements ActionListener {
        public void actionPerformed(ActionEvent evt) {
            modifierImage();
        }
    }

    public void imprimerFiche() {
        boutonImprimerFiche.setVisible(false);
        boutonModifierImage.setVisible(false);
        Utils.sauvegarderCarte(this.fenetre, this.fenetre.getContentPane());
        boutonImprimerFiche.setVisible(true);
        boutonModifierImage.setVisible(true);
    }

    /** Modifier l’image du joueur. */
    public void modifierImage() {
        ImageIcon icon = Utils.telechargerImage(this.fenetre);
        if (icon == null)
            return;

        this.labelImage.setIcon(icon);
    }

    public JFrame getfenetre(){
		return fenetre;
    }
}


