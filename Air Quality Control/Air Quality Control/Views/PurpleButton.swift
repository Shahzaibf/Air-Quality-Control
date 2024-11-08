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
