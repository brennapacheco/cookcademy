//
//  RecipeCategoryGridView.swift
//  Cookcademy
//
//  Created by Brenna Pacheco on 01/02/24.
//

import SwiftUI

struct RecipeCategoryGridView: View {
    
    private var recipeData = RecipeData()
    
    var body: some View {
        NavigationStack {
            LazyVGrid(columns: [GridItem()]) {
                ForEach(MainInformation.Category.allCases, id: \.self) { category in
                    Text(category.rawValue)
                        .font(.title)
                }
            }.navigationTitle("Categories")
        }
    }
}

extension RecipeCategoryGridView {
    
}

#Preview {
    RecipeCategoryGridView()
}
