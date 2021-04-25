package Jeu;

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
	private String viePersonnage;
	private Map<String,String> listCapacites;
	private String inventaire;
	private ImageIcon imagePersonnage;
	
	public ModeleFichePersonnage(String nom, String role, ImageIcon image, String vie, String leInventaire) {
		nomPersonnage = nom;
		rolePersonnage = role;
		imagePersonnage = image;
		viePersonnage = vie;
		inventaire = leInventaire;
		listCapacites = new HashMap<String,String>();
		
	}


	public ImageIcon getImage() {
		return imagePersonnage;
	}

	public String getInventaire() {
		
		return inventaire;
	}

	public String getNom() {
		
		return nomPersonnage;
	}

	public String getRole() {
		
		return rolePersonnage;
	}
	
	public String getVie() {
		
		return viePersonnage;
	}

	
	public Map<String,String> getCapacites() {
		return listCapacites;
	}

	public void ajouterCapacite(String capacite, String valeur){
			listCapacites.put(capacite,valeur);
		
	}
	
	public boolean estEgale(ModeleFichePersonnage autre){
		return nomPersonnage.equals(autre.getNom()) & rolePersonnage.equals(autre.getRole()) & 
					viePersonnage.equals(autre.getVie()) &
				autre.getCapacites().equals(listCapacites) & autre.getInventaire().equals(inventaire);
	}
		
	
}
