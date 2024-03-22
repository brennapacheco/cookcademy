//
//  ModifyIngredientView.swift
//  Cookcademy
//
//  Created by Brenna Pacheco on 20/02/24.
//

import SwiftUI
import Foundation

struct ModifyIngredientView: View, ModifyComponentView {
    @Binding var ingredient: Ingredient
    let createAction: ((Ingredient)-> Void)
    
    init(component: Binding<Ingredient>, createAction: @escaping (Ingredient) -> Void) {
        self._ingredient = component
        self.createAction = createAction
    }
    
    @Environment(\.presentationMode) private var mode
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    var body: some View {
        Form {
            TextField("Ingredient name", text: $ingredient.name)
                .listRowBackground(listBackgroundColor)
            Stepper(value: $ingredient.quantity, in: 0...100, step: 0.5, label: {
                HStack {
                    Text("Quantity:")
                    TextField("Quantity",
                              value: $ingredient.quantity,
                              formatter: NumberFormatter.decimal)
                    .keyboardType(.numbersAndPunctuation)
                }
            })
            .listRowBackground(listBackgroundColor)
            Picker("Unit", selection: $ingredient.unit, content: {
                ForEach(Ingredient.Unit.allCases, id: \.self) { unit in
                    Text(unit.rawValue)
                }
            })
            .listRowBackground(listBackgroundColor)
            .pickerStyle(MenuPickerStyle())
            HStack {
                Spacer()
                Button("Save") {
                    createAction(ingredient)
                    mode.wrappedValue.dismiss()
                }
                Spacer()
            }
            .listRowBackground(listBackgroundColor)
        }
        .foregroundStyle(listTextColor)
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
    @State var ing = Recipe.testRecipes[0].ingredients[0]
    return ModifyIngredientView(component: $ing) { ingredient in
        print(ingredient)
    }
}
