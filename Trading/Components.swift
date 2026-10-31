//
//  Components.swift
//  Trading
//
//  Created by Divya on 28/10/26.
//

import SwiftUI

extension View {
    func cardStyle() -> some View {
        modifier(CardStyleModifier())
    }
}

struct CardStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .backgroundStyle(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
