//
//  ViewController.swift
//  pokedex
//
//  Created by Ryan Fox on 5/27/17.
//  Copyright © 2017 Ryan Fox. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate {
    
    @IBOutlet weak var collection:UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var musicPlayer:AVAudioPlayer!
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var inSearchMode:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        parsePokemonCSV()
        initAudio()
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
       
    }
    
    func parsePokemonCSV(){
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        
        do{
            
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            //print(rows)
            
            for row in rows{
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = Pokemon(name: name, pokedexId: pokeId)
                self.pokemon.append(poke)
            
                
            }
        }catch let err as NSError{
            
            print(err.debugDescription)
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath)
            as? PokeCell{
            
            let poke:Pokemon!
            
            if inSearchMode{
                
                poke = filteredPokemon[indexPath.row]
                cell.configureCell(poke)
                
            }else{
                    poke = pokemon[indexPath.row]
                    cell.configureCell(poke)
            }
            
            return cell
        }else{
            
            return UICollectionViewCell()
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var poke:Pokemon!
        
        if inSearchMode{
            
            poke = filteredPokemon[indexPath.row]
            
        }else{
            
            poke = pokemon[indexPath.row]
            
        }
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode{
            
            return filteredPokemon.count
        }else{
        
        return pokemon.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 90);
    }
   
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        
        if musicPlayer.isPlaying{
            
            musicPlayer.pause()
            sender.alpha = 0.2
        }else{
            
            musicPlayer.play()
            sender.alpha = 1.0
        }
        
    }
    
    func initAudio(){
        
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")
        
        do{
            
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string:path!)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        }catch let err as NSError{
            
            print(err.debugDescription)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == "" || searchBar.text == nil{
            
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
            
        }else{
            
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil})
            
            collection.reloadData()
            
            
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "PokemonDetailVC"{
            
            if let detailsVC = segue.destination as? PokemonDetailVC{
                
                if let poke = sender as? Pokemon{
                    
                    detailsVC.pokemon = poke
                }
            }
    
        }
    }

}
