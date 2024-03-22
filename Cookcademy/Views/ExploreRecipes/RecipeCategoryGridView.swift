//
//  RecipeCategoryGridView.swift
//  Cookcademy
//
//  Created by Brenna Pacheco on 01/02/24.
//

import SwiftUI

struct RecipeCategoryGridView: View {
    @EnvironmentObject private var recipeData: RecipeData
    
    var body: some View {
        
        let columnLayout = [GridItem(.adaptive(minimum: 170))]
        
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columnLayout, spacing: 16) {
                    ForEach(MainInformation.Category.allCases, id: \.self) { category in
                        NavigationLink(
                            destination: RecipesListView(viewStyle: .singleCategory(category))
                                .environmentObject(recipeData),
                            label: {
                                CategoryView(category: category)
                            })
                    }
                }
            }
            .padding()
            .navigationTitle("Categories")
        }
    }
}

struct CategoryView: View {
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    let category: MainInformation.Category
    
    var body: some View {
        VStack {
            Image(category.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 170, height: 170)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            Text(category.rawValue)
                .font(.title)
                .foregroundStyle(listTextColor)
        }
    }
}

#Preview {
    RecipeCategoryGridView()
        .environmentObject(RecipeData())
}
