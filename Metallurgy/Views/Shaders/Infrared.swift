//
//  Infrared.swift
//  ShowcaseShowcases
//
//  Created by Raphael S on 01/07/2023.
//

import SwiftUI

struct Infrared: View {
    @Binding var name: String
    @Binding var author: String
    @Binding var category: Categories

    @State var strength: Float = 0
    @State var time = Date()

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
                        .layerEffect(
                            ShaderLibrary.infrared(
                                .float(time.timeIntervalSinceNow),
                                .float(strength)
                            ),
                            maxSampleOffset: .zero
                        )
                        .animation(.linear(duration: 1), value: strength)
                }

                ShowcaseParameter(
                    value: strength,
                    name: Binding.constant("Strength"),
                    editatble: Binding.constant(true),
                    range: Binding.constant(0 ... 10)
                )
            }
        }
    }
}

#Preview {
    Infrared(
        name: .constant("Infrared"),
        author: .constant("Raphael Salaja"),
        category: .constant(Categories.Layer)
    )
}