//
//  Waves.swift
//  SwiftUIByExample
//
//  Created by Raphael S on 20/06/2023.
//

import SwiftUI

struct Vignette: View {
    @State var strength: Float = 0

    var body: some View {
        List {
            ShowcaseImage()
                .layerEffect(ShaderLibrary.vignette(.float(strength)), maxSampleOffset: .zero)
                .animation(.linear(duration: 1), value: strength)

            Section("Strength") {
                Stepper(value: $strength.animation(.linear(duration: 1)), in: -10 ... 10) {
                    Text("\(strength, format: .number)").animation(nil, value: strength)
                }
            }
        }
    }
}

#Preview {
    Vignette()
}
