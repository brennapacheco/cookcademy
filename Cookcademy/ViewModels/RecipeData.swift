//
//  RecipeData.swift
//  Cookcademy
//
//  Created by Brenna Pacheco on 31/01/24.
//

import Foundation

class RecipeData: ObservableObject {
  @Published var recipes = Recipe.testRecipes
}
