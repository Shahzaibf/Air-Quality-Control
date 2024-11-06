//
//  ContentView.swift
//  Air Quality Control
//
//  Created by Shahzaib Fareed on 11/1/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 9
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
