//
//  Pixellate.swift
//  SwiftUIByExample
//
//  Created by Raphael S on 20/06/2023.
//

import SwiftUI

struct Pixellate: View {
    @State private var strength: CGFloat = 3.0

    var body: some View {
        NavigationView {
            Form {
                ShowcaseImage()
                    .distortionEffect(
                        .init(
                            function: .init(
                                library: .default,
                                name: "pixellate"
                            ),
                            arguments: [.float(strength)]
                        ),
                        maxSampleOffset: .zero
                    )
                    .padding()

                Slider(
                    value: $strength,
                    in: 1 ... 100,
                    step: 5
                )
            }
        }
    }
}

#Preview {
    Pixellate()
}
