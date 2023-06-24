//
//  Waves.swift
//  SwiftUIByExample
//
//  Created by Raphael S on 20/06/2023.
//

import SwiftUI

struct Waves: View {
    @State private var speed: CGFloat = 3.0
    @State private var frequencey: CGFloat = 3.0
    @State private var amplitude: CGFloat = 3.0
    let startDate: Date = .init()

    var body: some View {
        NavigationView {
            List {
                TimelineView(.animation) {
                    let time = $0.date.timeIntervalSince1970 - startDate.timeIntervalSince1970
                    ShowcaseImage()
                        .distortionEffect(
                            .init(
                                function: .init(
                                    library: .default,
                                    name: "waves"
                                ),
                                arguments: [
                                    .float(time),
                                    .float(speed),
                                    .float(frequencey),
                                    .float(amplitude)
                                ]

                            ),
                            maxSampleOffset: .zero
                        )
                        .padding()
                }

                Section("Speed") {
                    Slider(
                        value: $speed,
                        in: 1 ... 100,
                        step: 5
                    ) {
                        Text("Speed")
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("100")
                    }
                }
                Section("Frequencey") {
                    Slider(value: $frequencey, in: 1 ... 100, step: 5)
                }
                Section("Amplitude") {
                    Slider(value: $amplitude, in: 1 ... 100, step: 5)
                }
            }.navigationTitle("Waves")
        }
    }
}

#Preview {
    Waves()
}
