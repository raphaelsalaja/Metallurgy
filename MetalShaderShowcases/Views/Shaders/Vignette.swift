//
//  Waves.swift
//  SwiftUIByExample
//
//  Created by Raphael S on 20/06/2023.
//

import SwiftUI

struct Vignette: View {
    @State var intensity: Float = 0
    @State var distance: Float = 0

    var body: some View {
        List {
            Section {
                HStack {
                    Text("Vignette")
                        .fontWeight(.medium)

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
                .listRowSeparator(.hidden)

                ShowcaseImage()
                    .layerEffect(
                        ShaderLibrary.vignette(
                            .float(intensity),
                            .float(distance)
                        ),
                        maxSampleOffset: .zero
                    )

//                    .animation(.linear(duration: 1), value: intensity)
//                    .animation(.linear(duration: 1), value: distance)
            }

            Parameters(value: $intensity,
                       name: Binding.constant("Intensity"),
                       type: Binding.constant("Float"),
                       description: Binding.constant("Effects the overall strength of the effect."),
                       editatble: Binding.constant(true))

            Parameters(value: $distance,
                       name: Binding.constant("Distance"),
                       type: Binding.constant("Float"),
                       description: Binding.constant("Effects the overall strength of the effect."),
                       editatble: Binding.constant(true))
        }
    }
}

#Preview {
    Vignette()
}
