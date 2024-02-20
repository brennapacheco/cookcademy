//
//  ModifyMainInformationView.swift
//  Cookcademy
//
//  Created by Brenna Pacheco on 20/02/24.
//

import SwiftUI

struct ModifyMainInformationView: View {
  @Binding var mainInformation: MainInformation
  
  var body: some View {
    Form {
      TextField("Recipe Name", text: $mainInformation.name)
      TextField("Author", text: $mainInformation.author)
      Section(header: Text("Description")) {
        TextEditor(text: $mainInformation.description)
      }
      Picker(selection: $mainInformation.category, label:
              HStack {
                Text("Category")
                Spacer()
              }) {
        ForEach(MainInformation.Category.allCases,
                id: \.self) { category in
          Text(category.rawValue)
        }
              }
      .pickerStyle(MenuPickerStyle())
    }
  }
}

#Preview {
    @State var mainInfo = MainInformation(name: "Test Name", 
                                          description: "Test description",
                                          author: "Test author",
                                          category: .lunch)
    return ModifyMainInformationView(mainInformation: $mainInfo)
}
