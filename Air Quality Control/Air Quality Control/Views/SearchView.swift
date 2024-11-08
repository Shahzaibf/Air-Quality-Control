//
//  SearchView.swift
//  Air Quality Control
//
//  Created by Shahzaib Fareed on 11/8/24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    var body: some View {
        NavigationStack {
            Text(searchText == "" ? "" : "Searching for \(searchText)...")
            .navigationTitle("Search for a city!")
        }
        .searchable(text: $searchText)
        .customBackButton()
    }
}

#Preview {
    SearchView()
}
