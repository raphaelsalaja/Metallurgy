//
//  Waves.swift
//  SwiftUIByExample
//
//  Created by Raphael S on 20/06/2023.
//

import SwiftUI

struct Sepia: View {
    @Binding var name: String
    @Binding var description: String
    @Binding var author: String
    @Binding var category: BadgeType

    @State var strength: Float = 0
    @State private var showingSheet = false

    var body: some View {
        List {
            Section {
                ShowcaseHeading(
                    name: .constant(name),
                    category: .constant(BadgeType.Color),
                    author: .constant(author)
                )

                ShowcaseImage()
                    .colorEffect(ShaderLibrary.sepia(.float(strength)))
                    .animation(.linear(duration: 1), value: strength)
            }

            ShowcaseParameters(
                value: $strength,
                name: Binding.constant("Strength"),
                type: Binding.constant(BadgeType.Float),
                description: Binding.constant("Effects the overall strength of the effect."),
                editatble: Binding.constant(true)
            )
        }
    }
}

#Preview {
    Sepia(
        name: .constant("Sepia"),
        description: .constant("A sepia tone effect."),
        author: .constant("Raphael Salaja"),
        category: .constant(BadgeType.Float)
    )
}
