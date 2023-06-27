//
//  Waves.swift
//  SwiftUIByExample
//
//  Created by Raphael S on 20/06/2023.
//

import SwiftUI

struct Blur: View {
    @Binding var name: String
    @Binding var description: String
    @Binding var author: String
    @Binding var category: BadgeType

    @State var red: Float = 0
    @State var green: Float = 0
    @State var blue: Float = 0
    @State var startDate = Date()

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
                        .visualEffect { content, proxy in
                            content
                                .layerEffect(
                                    ShaderLibrary.shockwave(
                                        .float(startDate.timeIntervalSinceNow),
                                        .float2(proxy.size)
                                    ),
                                    maxSampleOffset: .zero
                                )
                        }
                        .animation(.linear(duration: 1), value: red)
                        .animation(.linear(duration: 1), value: green)
                        .animation(.linear(duration: 1), value: blue)

                } footer: {}

                ShowcaseParameters(
                    value: $red,
                    name: Binding.constant("Red"),
                    type: Binding.constant(BadgeType.Float),
                    description: Binding.constant("Effects the overall strength of the effect."),
                    editatble: Binding.constant(true)
                )
                ShowcaseParameters(
                    value: $green,
                    name: Binding.constant("Green"),
                    type: Binding.constant(BadgeType.Float),
                    description: Binding.constant("Effects the overall strength of the effect."),
                    editatble: Binding.constant(true)
                )
                ShowcaseParameters(
                    value: $blue,
                    name: Binding.constant("Blue"),
                    type: Binding.constant(BadgeType.Float),
                    description: Binding.constant("Effects the overall strength of the effect."),
                    editatble: Binding.constant(true)
                )
            }
        }
    }
}

#Preview {
    Blur(
        name: .constant("Blur"),
        description: .constant("blah blaj blah."),
        author: .constant("Raphael Salaja"),
        category: .constant(BadgeType.Layer)
    )
}
