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
        }
        
        pokemonNameLbl.text = pokemon.name
    }
    
 

    
    @IBAction func backBtnPressed(_ sender: UIButton) {
    
        dismiss(animated: true, completion: nil)
        
    }
 
    func updateUI(){
        
        
    }
    
    
   
}
