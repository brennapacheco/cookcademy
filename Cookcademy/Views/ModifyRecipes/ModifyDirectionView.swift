//
//  ModifyDirectionView.swift
//  Cookcademy
//
//  Created by Brenna Pacheco on 28/02/24.
//

import SwiftUI

struct ModifyDirectionView: View, ModifyComponentView {
    @Binding var direction: Direction
    @Environment(\.presentationMode) private var mode

    let createAction: (Direction) -> Void
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    init(component: Binding<Direction>, createAction: @escaping (Direction) -> Void) {
        self._direction = component
        self.createAction = createAction
    }
    
    var body: some View {
        Form {
            TextField("Direction Description", text: $direction.description)
                .listRowBackground(listBackgroundColor)
            Toggle("Optional", isOn: $direction.isOptional)
                .listRowBackground(listBackgroundColor)
            HStack {
                Spacer()
                Button("Save") {
                    createAction(direction)
                    mode.wrappedValue.dismiss() 
                }
                Spacer()
            }
            .listRowBackground(listBackgroundColor)
        }
        .foregroundStyle(listTextColor)
    }
}

#Preview {
    @State var drctn = Direction(description: "", isOptional: false)
    return ModifyDirectionView(component: $drctn) { _ in return }
}
