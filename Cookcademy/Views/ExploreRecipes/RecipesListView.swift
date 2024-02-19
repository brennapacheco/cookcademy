//
//  ContentView.swift
//  Cookcademy
//
//  Created by Brenna Pacheco on 30/01/24.
//

import SwiftUI

struct RecipesListView: View {
    @EnvironmentObject private var recipeData: RecipeData
    let category: MainInformation.Category
    
    @State private var isPresenting = false
    @State private var newRecipe = Recipe()
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
            List {
                ForEach(recipes) { recipe in
                    NavigationLink(recipe.mainInformation.name,
                                   destination: RecipeDetailView(recipe: recipe))
                }
                .listRowBackground(listBackgroundColor)
                .foregroundColor(listTextColor)
            }
            .navigationTitle(navigationTitle)
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        newRecipe = Recipe()
                        newRecipe.mainInformation.category = recipes[0].mainInformation.category
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
    
    private var recipes: [Recipe] {
        recipeData.recipes(for: category)
    }
    
    private var navigationTitle: String {
        "\(category.rawValue) Recipes"
    }
}

#Preview {
    RecipesListView(category: .breakfast)
        .environmentObject(RecipeData())
}
