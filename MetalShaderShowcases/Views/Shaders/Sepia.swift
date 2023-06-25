//
//  Waves.swift
//  SwiftUIByExample
//
//  Created by Raphael S on 20/06/2023.
//

import SwiftUI

struct Sepia: View {
    @State var strength: Float = 0

    var body: some View {
        List {
            Section {
                HStack {
                    Text("Sepia")
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
                    .colorEffect(ShaderLibrary.sepia(.float(strength)))
                    .animation(.linear(duration: 1), value: strength)
            }

            Parameters(value: Binding.constant(strength),
                       name: Binding.constant("Strength"),
                       type: Binding.constant("Float"),
                       description: Binding.constant("Efffects the overall strength of the effect."))
        }
    }
}

#Preview {
    Sepia()
}
