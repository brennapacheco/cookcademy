//
//  RecipeData.swift
//  Cookcademy
//
//  Created by Brenna Pacheco on 31/01/24.
//

import Foundation

class RecipeData: ObservableObject {
    @Published var recipes = Recipe.testRecipes
    
    var favoriteRecipes: [Recipe] {
        recipes.filter { $0.isFavorite }
    }
    
    private var recipesFileURL: URL {
        do {
            let documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            return documentsDirectory.appending(path: "recipeData")
        } catch {
            fatalError("An error occurred while getting the url: \(error)")
        }
    }
    
    func recipes(for category: MainInformation.Category) -> [Recipe] {
        var filteredRecipes = [Recipe]()
        for recipe in recipes {
            if recipe.mainInformation.category == category {
                filteredRecipes.append(recipe)
            }
        }
        return filteredRecipes
    }
    
    func add(recipe: Recipe) {
        if recipe.isValid {
            recipes.append(recipe)
        }
    }
    
    func index(of recipe: Recipe) -> Int? {
        for i in recipes.indices {
            if recipes[i].id == recipe.id {
                return i
            }
        }
        return nil
    }
    
    func saveRecipes() throws {
        do {
            let encodedData = try JSONEncoder().encode(recipes)
            try encodedData.write(to: recipesFileURL)
        } catch {
            fatalError("An error occurred while getting the url: \(error)")
        }
    }
    
    func loadRecipes() throws {
        guard let data = try? Data(contentsOf: recipesFileURL) else { return }

        do {
            let savedRecipes = try JSONDecoder().decode([Recipe].self, from: data)
            recipes = savedRecipes
        } catch {
            fatalError("An error occurred while getting the url: \(error)")
        }
    }
}
