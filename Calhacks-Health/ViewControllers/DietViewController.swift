//
//  DietViewController.swift
//  Calhacks-Health
//
//  Created by Charlie Wang on 2019/10/26.
//  Copyright © 2019 wcz. All rights reserved.
//

import UIKit

class DietViewController: UIViewController {
    
    @IBOutlet weak var recipeTableView: UITableView!
    
    var isLoggedIn: Bool = false;
    let recipeCol = RecipeCollection()
    let stt = Speech2Text()
    
    override func viewDidLoad() {
        recipeTableView.dataSource = self
        if !isLoggedIn {
            let vc = storyboard?.instantiateViewController(identifier: "LoginViewController")
            present(vc!, animated: true, completion: nil)
        }
        print(stt.getDocumentsDirectory())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let index = recipeTableView.indexPathForSelectedRow {
            recipeTableView.deselectRow(at: index, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Recipe") {
            let vc = segue.destination as! RecipeViewController
            vc.delegate = self
        }
    }
    
}

extension DietViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeCol.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeTableView.dequeueReusableCell(withIdentifier: "recipe")!
        
        let image = cell.viewWithTag(1000) as! UIImageView
        let name = cell.viewWithTag(1001) as! UILabel
        
        let aRecipe = recipeCol.recipes[indexPath.row]
        image.image = aRecipe.image
        name.text = aRecipe.name
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let cell = recipeTableView.cellForRow(at: indexPath) {
//            let recipe = recipeCol.recipes[indexPath.row]
//        }
//    }
    
}

extension DietViewController: RecipeViewControllerDelegate {
    
    func getRecipe() -> Recipe {
        let index = recipeTableView.indexPathForSelectedRow
        return recipeCol.recipes[index!.row]
    }
    
}
