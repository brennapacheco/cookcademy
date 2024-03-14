//
//  ContentView.swift
//  Cookcademy
//
//  Created by Brenna Pacheco on 30/01/24.
//

import SwiftUI

struct RecipesListView: View {
    @EnvironmentObject private var recipeData: RecipeData
    @State private var isPresenting = false
    @State private var newRecipe = Recipe()
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var viewStyle: ViewStyle

    var body: some View {
            List {
                ForEach(recipes) { recipe in
                    NavigationLink(recipe.mainInformation.name,
                                   destination: RecipeDetailView(recipe: binding(for: recipe)))
                }
                .listRowBackground(listBackgroundColor)
                .foregroundColor(listTextColor)
            }
            .navigationTitle(navigationTitle)
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        newRecipe = Recipe()
                        newRecipe.mainInformation.category = recipes.first?.mainInformation.category ?? .breakfast
                        isPresenting = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            })
            .sheet(isPresented: $isPresenting, content: {
                NavigationView {
                    ModifyRecipeView(recipe: $newRecipe)
                        .toolbar(content: {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    isPresenting = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                if newRecipe.isValid {
                                    Button("Add") {
                                        recipeData.add(recipe: newRecipe)
                                        isPresenting = false
                                    }
                                }
                            }
                        })
                        .navigationTitle("Add a New Recipe")
                }
            })
        
    }
}

extension RecipesListView {
    
    enum ViewStyle {
        case favorites
        case singleCategory(MainInformation.Category)
    }
    
    private var recipes: [Recipe] {
        switch viewStyle {
        case .favorites:
            return recipeData.favoriteRecipes
        case let .singleCategory(category):
            return recipeData.recipes(for: category)
        }
    }
    
    private var navigationTitle: String {
        switch viewStyle {
        case .favorites:
            return "Favorite Recipes"
        case let .singleCategory(category):
            return "\(category.rawValue) Recipes"
        }
    }
    
    func binding(for recipe: Recipe) -> Binding<Recipe> {
        guard let index = recipeData.index(of: recipe) else { fatalError("Recipe not found") }
        return $recipeData.recipes[index]
    }
}

#Preview {
    RecipesListView(viewStyle: .singleCategory(.breakfast))
        .environmentObject(RecipeData())
}
