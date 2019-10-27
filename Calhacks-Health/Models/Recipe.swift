//
//  Recipe.swift
//  Calhacks-Health
//
//  Created by Charlie Wang on 2019/10/26.
//  Copyright © 2019 wcz. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct Recipe {
    let name: String
    let image: UIImage
    let desc: String
}

class RecipeCollection {
    
    var recipes = [Recipe]()
    
    init() {
        recipes.append(Recipe(name: "Yakisoba Chicken", image: UIImage(named: "chicken.png")!, desc: """
Ingredients:
½ teaspoon sesame oil
1 tablespoon canola oil
2 tablespoons chile paste
2 cloves garlic, chopped
4 skinless, boneless chicken breast halves - cut into 1 inch cubes
½ cup soy sauce
1 onion, sliced lengthwise into eighths
½ medium head cabbage, coarsely chopped
2 carrots, coarsely chopped
8 ounces soba noodles, cooked and drained

Directions (prep 5m, cook 10m, Ready In 15m):
Step1:
In a large skillet combine sesame oil, canola oil and chili paste; stir-fry 30 seconds. Add garlic and stir fry an additional 30 seconds. Add chicken and 1/4 cup of the soy sauce and stir fry until chicken is no longer pink, about 5 minutes. Remove mixture from pan, set aside, and keep warm.
Step2
In the emptied pan combine the onion, cabbage, and carrots. Stir-fry until cabbage begins to wilt, 2 to 3 minutes. Stir in the remaining soy sauce, cooked noodles, and the chicken mixture to pan and mix to blend. Serve and enjoy!

Nutrition Facts:
Per Serving:
295 calories; 4.8 g total fat; 46 mg cholesterol; 1621 mg sodium. 40.7 g carbohydrates; 26.3 g protein

"""))
        recipes.append(Recipe(name: "Spicy Beef Curry Stew", image: UIImage(named: "beef.png")!, desc: """
Ingredients:
1 tablespoon olive oil
1-pound beef stew meat
salt and pepper to taste
2 cloves garlic, minced
1 teaspoon chopped fresh ginger
1 fresh jalapeno peppers, diced
1 tablespoon curry powder
1 (14.5 ounce) can diced tomatoes with juice
1 onion, sliced and quartered
1 cup beef broth

Directions (prep 15m, cook 8h10m, total 8h 25m):
Step1:
Heat the olive oil in a skillet over medium heat and brown the beef on all sides. Remove from skillet, reserving juices, and season with salt and pepper. Cook and stir the garlic, ginger, and jalapeno in the skillet for 2 minutes, until tender, and season with curry powder. Mix in the diced tomatoes and juice.
Step2:
Place the onion in the bottom of a slow cooker, and layer with the browned beef. Scoop the skillet mixture into the slow cooker and mix in the beef broth.
Step3:
Cover, and cook 6 to 8 hours on Low.

Nutrition Facts:
Per Serving: 291 calories; 19.1 g fat; 7.6 g carbohydrates; 20.6 g protein; 62 mg cholesterol; 442 mg sodium.

"""))
        recipes.append(Recipe(name: "Meyer Lemon Avocado Toast", image: UIImage(named: "toast.png")!, desc: """
Ingredients
2 slices whole grain bread
1/2 avocado
2 tablespoons chopped fresh cilantro, or more to taste
1 teaspoon Meyer lemon juice, or to taste
1/4 teaspoon Meyer lemon zest
1 pinch cayenne pepper
1 pinch fine sea salt
1/4 teaspoon chia seeds

Directions (Prep 10m, Cook 3m, Ready In 13m)
Step1:
Toast bread slices to desired doneness, 3 to 5 minutes.
Step2:
Mash avocado in a bowl; stir in cilantro, Meyer lemon juice, Meyer lemon zest, cayenne pepper, and sea salt. Spread avocado mixture onto toast and top with chia seeds.

Nutrition Facts

Per Serving: 72 calories; 1.2 g fat; 11.8 g carbohydrates; 3.6 g protein; 0 mg cholesterol; 271 mg sodium.

"""))
    }
    
    func fetchData() {
        AF.request("stub").responseJSON { response in
            if let data = response.value {
                let json = JSON(data)
                self.recipes = json["recipes<STUB>"].arrayObject as! [Recipe] // stub
            }
        }
    }
    
}
