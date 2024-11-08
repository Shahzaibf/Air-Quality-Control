//
//  PurpleButton.swift
//  Air Quality Control
//
//  Created by Shahzaib Fareed on 11/7/24.
//

import SwiftUI

struct PurpleButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 8)
            .padding(.horizontal, 20)
            .background(configuration.isPressed ? Color.purple.opacity(0.5) : Color.purple)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.05 : 1)
    }
}

struct CustomBackButtonModifier: ViewModifier {
    @Environment(\.presentationMode) private var presentationMode

    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
                }) {
                HStack {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.blue)
                    Text("Home")
                        .foregroundColor(.blue)
                }
            })
    }
}

extension View {
    func customBackButton() -> some View {
        self.modifier(CustomBackButtonModifier())
    }
}
