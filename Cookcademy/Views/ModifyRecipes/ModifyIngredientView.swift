//
//  ModifyIngredientView.swift
//  Cookcademy
//
//  Created by Brenna Pacheco on 20/02/24.
//

import SwiftUI

struct ModifyIngredientView: View {
    @State var ingredient: Ingredient
    
    var body: some View {
        Form {
            TextField("Ingredient name", text: $ingredient.name)
            Stepper(value: $ingredient.quantity, in: 0...100, step: 1.0, label: {
                HStack {
                    Text("Quantity:")
                    TextField("Quantity",
                              value: $ingredient.quantity,
                              formatter: NumberFormatter())
                    .keyboardType(.numbersAndPunctuation)
                }
            })
            Picker("Unit", selection: $ingredient.unit, content: {
                ForEach(Ingredient.Unit.allCases, id: \.self) { unit in
                    Text(unit.rawValue)
                }
            })
            .pickerStyle(MenuPickerStyle())
        }
    }
}

#Preview {
    var ing = Ingredient(name: "Test name", quantity: 0, unit: .cups)
    return ModifyIngredientView(ingredient: ing)
}
