//
//  RecipeCategoryGridView.swift
//  Cookcademy
//
//  Created by Brenna Pacheco on 01/02/24.
//

import SwiftUI

struct RecipeCategoryGridView: View {
    var body: some View {
        
        let columnLayout = [GridItem(), GridItem()]
        
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columnLayout) {
                    ForEach(MainInformation.Category.allCases, id: \.self) { category in
                        CategoryView(category: category)
                    }
                }.navigationTitle("Categories")
            }
        }
    }
}

struct CategoryView: View {
    
    let category: MainInformation.Category
    
    var body: some View {
        ZStack {
            Image(category.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.35)
            Text(category.rawValue)
                .font(.title)
        }
    }
}

#Preview {
    RecipeCategoryGridView()
}
