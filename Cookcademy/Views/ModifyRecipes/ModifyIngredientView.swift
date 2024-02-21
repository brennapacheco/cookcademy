//
//  ModifyIngredientView.swift
//  Cookcademy
//
//  Created by Brenna Pacheco on 20/02/24.
//

import SwiftUI
import Foundation

struct ModifyIngredientView: View {
    @Binding var ingredient: Ingredient
    let createAction: ((Ingredient)-> Void)
    @Environment(\.presentationMode) private var mode

    var body: some View {
        Form {
            TextField("Ingredient name", text: $ingredient.name)
            Stepper(value: $ingredient.quantity, in: 0...100, step: 0.5, label: {
                HStack {
                    Text("Quantity:")
                    TextField("Quantity",
                              value: $ingredient.quantity,
                              formatter: NumberFormatter.decimal)
                    .keyboardType(.numbersAndPunctuation)
                }
            })
            Picker("Unit", selection: $ingredient.unit, content: {
                ForEach(Ingredient.Unit.allCases, id: \.self) { unit in
                    Text(unit.rawValue)
                }
            })
            .pickerStyle(MenuPickerStyle())
            HStack {
                Spacer()
                Button("Save") {
                    createAction(ingredient)
                    mode.wrappedValue.dismiss()
                }
                Spacer()
            }
        }
    }
}

extension NumberFormatter {
  static var decimal: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter
  }
}

#Preview {
    @State var ing = Ingredient(name: "", quantity: 0, unit: .none)
    return ModifyIngredientView(ingredient: $ing) { ingredient in
        print(ingredient)
    }
}
