//
//  ModifyDirectionView.swift
//  Cookcademy
//
//  Created by Brenna Pacheco on 28/02/24.
//

import SwiftUI

struct ModifyDirectionView: View {
    @Binding var direction: Direction
    @Environment(\.presentationMode) private var mode

    let createAction: (Direction) -> Void
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
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
                    mode.wrappedValue.dismiss() //closes the modal view
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
    return ModifyDirectionView(direction: $drctn) { _ in return }
}
