//
//  ModifyRecipeView.swift
//  Cookcademy
//
//  Created by Brenna Pacheco on 02/02/24.
//

import SwiftUI

struct ModifyRecipeView: View {
    @Binding var recipe: Recipe
    
    @State private var selection = Selection.main
    
    var body: some View {
        VStack {
            Picker("Picker", selection: $selection, content: {
                Text("Main Info").tag(Selection.main)
                Text("Ingredients").tag(Selection.ingredients)
                Text("Directions").tag(Selection.directions)
            })
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            switch selection {
            case .main:
                ModifyMainInformationView(mainInformation: $recipe.mainInformation)
            case .ingredients:
                ModifyComponentsView<Ingredient, ModifyIngredientView>(ingredients: $recipe.ingredients)
            case .directions:
                Text("Directions Editor")
            }
            Spacer()
        }
    }
}

extension ModifyRecipeView {
    enum Selection {
        case main, ingredients, directions
    }
}

#Preview {
    @State var recipe = Recipe()
    return ModifyRecipeView(recipe: $recipe)
}
