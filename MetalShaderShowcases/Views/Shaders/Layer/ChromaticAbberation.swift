//
//  Waves.swift
//  SwiftUIByExample
//
//  Created by Raphael S on 20/06/2023.
//

import SwiftUI

struct ChromaticAbberation: View {
    @Binding var name: String
    @Binding var description: String
    @Binding var author: String
    @Binding var category: Categories

    @State var red: Float = 0
    @State var green: Float = 0
    @State var blue: Float = 0
    @State var state: Float = 0
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

                    if state == 0 {
                        ShowcaseImage()
                            .layerEffect(
                                ShaderLibrary.chromaticAbberation(
                                    .float(red),
                                    .float(green),
                                    .float(blue)
                                ),
                                maxSampleOffset: .zero
                            )
                            .animation(.linear(duration: 1), value: red)
                            .animation(.linear(duration: 1), value: green)
                            .animation(.linear(duration: 1), value: blue)
                    } else {
                        ShowcaseImage()
                            .layerEffect(
                                ShaderLibrary.chromaticAbberationShift(
                                    .float(startDate.timeIntervalSinceNow)
                                ),
                                maxSampleOffset: .zero
                            )
                            .animation(.linear(duration: 1), value: startDate)
                    }

                    Picker("Version", selection: $state) {
                        Text("Static").tag(Float(0))
                        Text("Shifty").tag(Float(1))
                    }
                    .pickerStyle(.menu)

                } footer: {}

                if state == 0 {
                    ShowcaseParameter(
                        value: $red,
                        name: Binding.constant("Red"),
                        // parameter: Binding.constant(Parameters.Float),
                        description: Binding.constant("Effects the red channel."),
                        editatble: Binding.constant(true)
                    )
                    ShowcaseParameter(
                        value: $green,
                        name: Binding.constant("Green"),
                        // parameter: Binding.constant(Parameters.Float),
                        description: Binding.constant("Effects the green channel."),
                        editatble: Binding.constant(true)
                    )
                    ShowcaseParameter(
                        value: $blue,
                        name: Binding.constant("Blue"),
                        // parameter: Binding.constant(Parameters.Float),
                        description: Binding.constant("Effects the blue channel."),
                        editatble: Binding.constant(true)
                    )
                } else {
                    ShowcaseParameter(
                        value: Binding.constant(0.5),
                        name: Binding.constant("Time"),
                        // parameter: Binding.constant(Parameters.Float),
                        description: Binding.constant("Shifts the effect over time."),
                        editatble: Binding.constant(false)
                    )
                }
            }
        }
    }
}

#Preview {
    ChromaticAbberation(
        name: .constant("Chromatic Abberation"),
        description: .constant("A chromatic abberation effect."),
        author: .constant("Raphael Salaja"),
        category: .constant(Categories.Layer)
    ).preferredColorScheme(/*@START_MENU_TOKEN@*/ .dark/*@END_MENU_TOKEN@*/)
}
