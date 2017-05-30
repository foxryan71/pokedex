//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Ryan Fox on 5/29/17.
//  Copyright © 2017 Ryan Fox. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    //Outlets
    @IBOutlet weak var pokemonNameLbl: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    @IBOutlet weak var pokeIdLbl: UILabel!
    //End of outlets
    
    var pokemon : Pokemon!
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemon.downloadPokemonDetails { 
           
            self.updateUI()
           // print("we are here")
        }
        
        pokemonNameLbl.text = pokemon.name.capitalized
        let img = UIImage(named: "\(pokemon.pokedexId)")
        currentEvoImage.image = img
        mainImage.image = img
        pokeIdLbl.text = "\(pokemon.pokedexId)"
    }
    
 

    
    @IBAction func backBtnPressed(_ sender: UIButton) {
    
        dismiss(animated: true, completion: nil)
        
    }
 
    func updateUI(){
        
        baseAttackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        typeLbl.text = pokemon.type
        descriptionLbl.text = pokemon.description
        
        if pokemon.nextEvolutionId == ""{
            
            evoLbl.text = "No Evolution"
            nextEvoImage.isHidden = true
        }else{
            
            nextEvoImage.isHidden = false
            nextEvoImage.image = UIImage(named: pokemon.nextEvolutionId)
            let str = "Next Evolution: \(pokemon.nextEvolutionName) - LVL \(pokemon.nextEvolutionLevel)"
            evoLbl.text = str
        }
        
        
    }
    
    
   
}
