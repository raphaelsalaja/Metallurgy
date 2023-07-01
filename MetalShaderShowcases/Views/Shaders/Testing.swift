//
//  Waves.swift
//  SwiftUIByExample
//
//  Created by Raphael S on 20/06/2023.
//

import SwiftUI

struct Retro: View {
    @Binding var name: String
    @Binding var description: String
    @Binding var author: String
    @Binding var category: Categories

    @State var time = Date()
    @State var strength: Float = 0

    var body: some View {
        TimelineView(.animation) { _ in
            List {
                Section {
                    ShowcaseHeading(
                        name: .constant(name),
                        category: .constant(category),
                        author: .constant(author)
                    )

                    ShowcaseImage()
                        .layerEffect(ShaderLibrary.deepfry(
                            .float(strength)
                        ), maxSampleOffset: .zero)
                        .animation(.linear(duration: 1), value: strength)
                }

                ShowcaseParameter(
                    value: $strength,
                    name: Binding.constant("Red"),
                    parameter: Binding.constant(Parameters.Float),
                    description: Binding.constant("Effects the red channel."),
                    editatble: Binding.constant(true)
                )
            }
        }
    }
}

#Preview {
    Retro(
        name: .constant("Chromatic Abberation"),
        description: .constant("A chromatic abberation effect."),
        author: .constant("Raphael Salaja"),
        category: .constant(Categories.Layer)
    ).preferredColorScheme(/*@START_MENU_TOKEN@*/ .dark/*@END_MENU_TOKEN@*/)
}
