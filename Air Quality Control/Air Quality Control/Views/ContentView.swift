//
//  ContentView.swift
//  Air Quality Control
//
//  Created by Shahzaib Fareed on 11/1/24.
//

import SwiftUI

struct ContentView: View {
    @State private var favorites = FavoriteStore()
    @State private var selectedTab = 0
    var body: some View {
        TabView {
            HomePageView()
                .tag(0)
                .tabItem {
                    Text("Home")
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                }
                
            SearchView()
                .tag(1)
                .tabItem {
                    Text("Search")
                    Image(systemName: selectedTab == 1 ? "magnifyingglass.circle.fill" : "magnifyingglass.circle")
                }
                
            FavoritesListView()
                .tag(2)
                .tabItem {
                    Text("Favorites")
                    Image(systemName: selectedTab == 2 ? "heart.fill" : "heart")
                }
                
        }
        .environment(favorites)
    }
}

#Preview {
    ContentView()
}
