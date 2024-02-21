//
//  ModifyIngredientsView.swift
//  Cookcademy
//
//  Created by Brenna Pacheco on 20/02/24.
//

import SwiftUI

struct ModifyIngredientsView: View {
    @Binding var ingredients: [Ingredient]
    @State private var newIngredient = Ingredient()
    
    var body: some View {
        VStack {
            if ingredients.isEmpty {
                Spacer()
                NavigationLink("Add the first ingredient",
                               destination: ModifyIngredientView(ingredient: $newIngredient) { ingredient in
                    ingredients.append(ingredient)
                    newIngredient = Ingredient(name: "", quantity: 0.0, unit: .none)
                })
                .buttonStyle(.bordered)
                Spacer()
            } else {
                List {
                    ForEach(ingredients.indices, id: \.self) { index in
                        let ingredient = ingredients[index]
                        Text(ingredient.description)
                    }
                    NavigationLink("Add another ingredient",
                                   destination: ModifyIngredientView(ingredient: $newIngredient)
                                   { ingredient in
                        ingredients.append(ingredient)
                        newIngredient = Ingredient()
                    })
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

#Preview {
    @State var emptyIngredients = [Ingredient]()
    @State var myIngredients = [Ingredient(name: "test",
                                           quantity: 7.0,
                                           unit: .cups)]
    return ModifyIngredientsView(ingredients: $myIngredients)
}
