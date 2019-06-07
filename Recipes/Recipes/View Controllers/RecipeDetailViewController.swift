//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Enayatullah Naseri on 6/5/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var recipeLabelTitle: UILabel!
    @IBOutlet weak var recipeDetailTextField: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }

    
    func updateViews() {
        guard let recipe = recipe,
            isViewLoaded else {return}
        
        
        recipeLabelTitle.text = recipe.name
        recipeDetailTextField.text = recipe.instructions
    }
    


}
