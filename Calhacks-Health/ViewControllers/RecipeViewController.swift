//
//  RecipeViewController.swift
//  Calhacks-Health
//
//  Created by Charlie Wang on 2019/10/26.
//  Copyright © 2019 wcz. All rights reserved.
//

import UIKit

protocol RecipeViewControllerDelegate: class {
    func getRecipe() -> Recipe
}

class RecipeViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UITextView!
    
    var recipe: Recipe?
    
    weak var delegate: RecipeViewControllerDelegate?
    
    override func viewDidLoad() {
        
        recipe = delegate?.getRecipe()
        print(recipe!.name)
        print(recipe!.desc)
        imageView.image = recipe?.image
        nameLabel.text = recipe?.name
        descLabel.text = recipe?.desc
    }
    
}
