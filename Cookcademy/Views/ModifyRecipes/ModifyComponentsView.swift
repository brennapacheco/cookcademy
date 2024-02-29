//
//  ModifyIngredientsView.swift
//  Cookcademy
//
//  Created by Brenna Pacheco on 20/02/24.
//

import SwiftUI

protocol RecipeComponent {
    init()
}

protocol ModifyComponentView: View {
    associatedtype Component
    init(component: Binding<Component>, createAction: @escaping (Component) -> Void)
}

struct ModifyComponentsView: View {
    @Binding var ingredients: [Ingredient]
    @State private var newIngredient = Ingredient()
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        VStack {
            let addIngredientView = ModifyIngredientView(component: $newIngredient, createAction: { ingredient in
                ingredients.append(ingredient)
                newIngredient = Ingredient()
            }).navigationTitle("Add Ingredient")
            if ingredients.isEmpty {
                Spacer()
                NavigationLink("Add the first ingredient",
                               destination: ModifyIngredientView(component: $newIngredient) { ingredient in
                    ingredients.append(ingredient)
                    newIngredient = Ingredient()
                })
                .buttonStyle(.bordered)
                Spacer()
            } else {
                List {
                    ForEach(ingredients.indices, id: \.self) { index in
                        let ingredient = ingredients[index]
                        Text(ingredient.description)
                    }
                    .listRowBackground(listBackgroundColor)
                    NavigationLink("Add another ingredient",
                                   destination: ModifyIngredientView(component: $newIngredient)
                                   { ingredient in
                        ingredients.append(ingredient)
                        newIngredient = Ingredient()
                    })
                    .buttonStyle(PlainButtonStyle())
                    .listRowBackground(listBackgroundColor)
                }
                .foregroundStyle(listTextColor)
            }
        }
    }
}

#Preview {
    @State var emptyIngredients = [Ingredient]()
    @State var myIngredients = [Ingredient(name: "test",
                                           quantity: 7.0,
                                           unit: .cups)]
    return ModifyComponentsView(ingredients: $myIngredients)
}
