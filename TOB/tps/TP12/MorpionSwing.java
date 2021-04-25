import javax.swing.*;
import java.awt.*;
import javax.swing.event.*;
import java.awt.event.*;
import java.util.*;

/** Programmation d'un jeu de Morpion avec une interface graphique Swing.
  *
  * REMARQUE : Dans cette solution, le patron MVC n'a pas été appliqué !
  * On a un modèle (?), une vue et un contrôleur qui sont fortement liés.
  *
  * @author	Xavier Crégut
  * @version	$Revision: 1.4 $
  */

public class MorpionSwing {

	// les images à utiliser en fonction de l'état du jeu.
	private static final Map<ModeleMorpion.Etat, ImageIcon> images
		= new HashMap<ModeleMorpion.Etat, ImageIcon>();
	static {
		images.put(ModeleMorpion.Etat.VIDE, new ImageIcon("blanc.jpg"));
		images.put(ModeleMorpion.Etat.CROIX, new ImageIcon("croix.jpg"));
		images.put(ModeleMorpion.Etat.ROND, new ImageIcon("rond.jpg"));
	}

// Choix de réalisation :
// ----------------------
//
//  Les attributs correspondant à la structure fixe de l'IHM sont définis
//	« final static » pour montrer que leur valeur ne pourra pas changer au
//	cours de l'exécution.  Ils sont donc initialisés sans attendre
//  l'exécution du constructeur !

	private ModeleMorpion modele;	// le modèle du jeu de Morpion

//  Les éléments de la vue (IHM)
//  ----------------------------

	/** Fenêtre principale */
	private JFrame fenetre;

	/** Bouton pour quitter */
	private final JButton boutonQuitter = new JButton("Q");

	/** Bouton pour commencer une nouvelle partie */
	private final JButton boutonNouvellePartie = new JButton("N");

	/** Cases du jeu */
	private final JLabel[][] cases = new JLabel[3][3];

	/** Zone qui indique le joueur qui doit jouer */
	private final JLabel joueur = new JLabel();


// Le constructeur
// ---------------

	/** Construire le jeu de morpion */
	public MorpionSwing() {
		this(new ModeleMorpionSimple());
	}

	/** Construire le jeu de morpion */
	public MorpionSwing(ModeleMorpion modele) {
		// Initialiser le modèle
		this.modele = modele;

		// Créer les cases du Morpion
		for (int i = 0; i < this.cases.length; i++) {
			for (int j = 0; j < this.cases[i].length; j++) {
				this.cases[i][j] = new JLabel();
			}
		}

		// Initialiser le jeu
		this.recommencer();

		// Construire la vue (présentation)
		//	Définir la fenêtre principale
		this.fenetre = new JFrame("Morpion");
		this.fenetre.setLocation(100, 200);

		// Construire le contrôleur (gestion des événements)
		this.fenetre.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

		initialiserInterface();

		// afficher la fenêtre
		this.fenetre.pack();			// redimmensionner la fenêtre
		this.fenetre.setVisible(true);	// l'afficher
	}

	private void initialiserInterface() {
		final JPanel gridPanel = new JPanel();
		final GridLayout layout = new GridLayout(3, 3);
		gridPanel.setLayout(layout);
		for (int i = 0; i < this.cases.length; i++) {
			for (int j = 0; j < this.cases[i].length; j++) {
				gridPanel.add(this.cases[i][j]);
				int finalI = i, finalJ = j;
				this.cases[i][j].addMouseListener(new MouseAdapter() {
					@Override
					public void mouseClicked(MouseEvent e) {
						try {
							ModeleMorpion.Etat joueur = modele.getJoueur();
							modele.cocher(finalI, finalJ);
							cases[finalI][finalJ].setIcon(images.get(joueur));
							if (modele.estTerminee()) {
								if (modele.estGagnee())
									JOptionPane.showMessageDialog(fenetre, joueur.toString() + " a Gagné!");
								else
									JOptionPane.showMessageDialog(fenetre, "Personne n'a gagné!");
							}
						} catch (CaseOccupeeException caseOccupeeException) {
						}
					}
				});
				this.cases[i][j].setIcon(images.get(ModeleMorpion.Etat.VIDE));
			}
		}

		// Menu
		JMenuBar mb = new JMenuBar();
		JMenu menu = new JMenu("Jeu");
		JMenuItem n, q;
		n = new JMenuItem("Nouvelle partie");
		q = new JMenuItem("Quitter");
		menu.add(n);
		menu.add(q);
		mb.add(menu);
		fenetre.setJMenuBar(mb);

		// Listeners
		n.addActionListener(new AbstractAction() {
			@Override
			public void actionPerformed(ActionEvent e) {
				recommencer();
			}
		});
		q.addActionListener(new AbstractAction() {
			@Override
			public void actionPerformed(ActionEvent e) {
				quitter();
			}
		});

		this.fenetre.getContentPane().add(gridPanel);
	}

// Quelques réactions aux interactions de l'utilisateur
// ----------------------------------------------------

	/** Recommencer une nouvelle partie. */
	public void recommencer() {
		this.modele.recommencer();

		// Vider les cases
		for (int i = 0; i < this.cases.length; i++) {
			for (int j = 0; j < this.cases[i].length; j++) {
				this.cases[i][j].setIcon(images.get(this.modele.getValeur(i, j)));
			}
		}

		// Mettre à jour le joueur
		joueur.setIcon(images.get(modele.getJoueur()));
	}

	public void quitter() {
		Utils.sauvegarderCarte(this.fenetre, (JPanel)this.fenetre.getContentPane().getComponent(0));
	}

// La méthode principale
// ---------------------

	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				new MorpionSwing();
			}
		});


	}

}
