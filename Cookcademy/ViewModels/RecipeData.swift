//
//  RecipeData.swift
//  Cookcademy
//
//  Created by Brenna Pacheco on 31/01/24.
//

import Foundation

class RecipeData: ObservableObject {
  @Published var recipes = Recipe.testRecipes
    
    func recipes(for category: MainInformation.Category) -> [Recipe] {
        var filteredRecipes = [Recipe]()
        for recipe in recipes {
          if recipe.mainInformation.category == category {
            filteredRecipes.append(recipe)
          }
        }
        return filteredRecipes
      }
}
