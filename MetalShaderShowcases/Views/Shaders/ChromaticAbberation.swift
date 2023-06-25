//
//  Waves.swift
//  SwiftUIByExample
//
//  Created by Raphael S on 20/06/2023.
//

import SwiftUI

struct ChromaticAbberation: View {
    @State var red: Float = 0
    @State var green: Float = 0
    @State var blue: Float = 0
    @State var state: Float = 0

    let startDate = Date()

    var body: some View {
        TimelineView(.animation) { _ in
            List {
                Section {
                    HStack {
                        Text("Chromatic Abberation").fontWeight(.medium)
                        Spacer()
                        HStack {
                            HStack {
                                Text("Color").font(Font.caption.bold())
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.blue.tertiary)
                        .cornerRadius(20)
                    }

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
                                ShaderLibrary.chromaticAbberationTime(
                                    .float(startDate.timeIntervalSinceNow)
                                ),
                                maxSampleOffset: .zero
                            )
                    }

                    Picker("Version", selection: $state) {
                        Text("Static").tag(Float(0))
                        Text("Shift").tag(Float(1))
                    }.pickerStyle(.menu)
                }

                if state == 0 {
                    Parameters(
                        value: $red,
                        name: Binding.constant("Red"),
                        type: Binding.constant("Float"),
                        description: Binding.constant("Effects the overall strength of the effect.")
                    )
                    Parameters(
                        value: $green,
                        name: Binding.constant("Green"),
                        type: Binding.constant("Float"),
                        description: Binding.constant("Effects the overall strength of the effect.")
                    )
                    Parameters(
                        value: $blue,
                        name: Binding.constant("Blue"),
                        type: Binding.constant("Float"),
                        description: Binding.constant("Effects the overall strength of the effect.")
                    )
                } else {
                    /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                }
            }
        }
    }
}

#Preview {
    ChromaticAbberation()
}
