package Jeu.Modeles;

import Jeu.Interfaces.Capacite;
import Jeu.Interfaces.Inventaire;
import Jeu.Utils;

import javax.swing.*;
import java.util.*;
/**
  * ModeleFichePersonnage est une réalisation de l'interface fiche de personnage 
  *
  * @author	Kamal Hammi
  * @version	$version: 1.0 $
  */

public class ModeleFichePersonnage  {

	private String nomPersonnage;
	private String rolePersonnage;
	private int viePersonnage;
	private List<Capacite> capacites;
	private Inventaire inventaire;
	private ImageIcon imagePersonnage;
	
	public ModeleFichePersonnage(String nom, String role) {
		nomPersonnage = nom;
		rolePersonnage = role;
		viePersonnage = 10;
		imagePersonnage = Utils.DEFAULT_ICON;
		inventaire = new InventaireSimple();
		capacites = new ArrayList<>();
	}

	public ImageIcon getImage() {
		return imagePersonnage;
	}

	public void setImage(ImageIcon icon) {
		imagePersonnage = icon;
	}

	public Inventaire getInventaire() {
		return inventaire;
	}

	public String getNom() {
		return nomPersonnage;
	}

	public void setNom(String nom) {
		this.nomPersonnage = nom;
	}

	public String getRole() {
		return rolePersonnage;
	}

	public void setRole(String role) {
		this.rolePersonnage = role;
	}
	
	public int getVie() {
		return viePersonnage;
	}

	public void setVie(int vie) {
		this.viePersonnage = vie;
	}

	public List<Capacite> getCapacites() {
		return capacites;
	}

	public Capacite ajouterCapacite(String capacite) {
		if (capacites.stream().anyMatch(x -> x.getNom().equals(capacite)))
			return null;

		Capacite c = new CapaciteSimple(capacite);
		capacites.add(c);
		return c;
	}

	public void reinitialiser() {
		nomPersonnage = "";
		rolePersonnage = "";
		imagePersonnage = Utils.DEFAULT_ICON;
		viePersonnage = 10;
		inventaire.clear();
		capacites.clear();
	}
	
}
