//
//  MainViewController.swift
//  Recipes
//
//  Created by Enayatullah Naseri on 6/5/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    var networkClient = RecipesNetworkClient()
    
    
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    
    // Moved down
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("There was an error loading recipes \(error)")
                return
            }
            DispatchQueue.main.async {
                self.allRecipes = recipes ?? []
            }
        }

        // Do any additional setup after loading the view.
    }
    
    
    func filterRecipes() {
        
        guard let search = searchTextField.text?.lowercased(), !search.isEmpty else {
            filteredRecipes = allRecipes
            return }
        
        let searchRec = allRecipes.filter ( { $0.name.lowercased().contains(search) || $0.instructions.lowercased().contains(search) } )
        filteredRecipes = searchRec
    }

    
    @IBAction func searchActionTextField(_ sender: UITextField) {
        
        resignFirstResponder()
        filterRecipes()
        
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "toTabelView" {
            let tableVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = tableVC
        }
    }


}
