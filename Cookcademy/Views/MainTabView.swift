//
//  MainTabView.swift
//  Cookcademy
//
//  Created by Brenna Pacheco on 13/03/24.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var recipeData = RecipeData()
    
    var body: some View {
        TabView {
            RecipeCategoryGridView()
                .tabItem {
                    Label("Recipes", systemImage: "list.dash")
                }
            NavigationView {
                RecipesListView(category: .breakfast)
            }.tabItem {
                Label("Favorites", systemImage: "heart")
            }
        }
        .environmentObject(recipeData)
    }
}

#Preview {
    MainTabView()
}
