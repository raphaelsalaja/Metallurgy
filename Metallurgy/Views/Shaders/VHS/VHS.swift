import SwiftUI

struct CanonEvent: View {
    @Binding var name: String
    @Binding var author: String
    @Binding var category: Categories

    @State var noiseQuality: Float = 250.0
    @State var noiseIntensity: Float = 0.0088
    @State var offsetIntensity: Float = 0.02
    @State var colorOffsetIntensity: Float = 5
    @State var strength: Float = 1

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
                            ShaderLibrary.vhs(
                                .float(time.timeIntervalSinceNow),
                                .float(noiseQuality),
                                .float(noiseIntensity),
                                .float(offsetIntensity),
                                .float(colorOffsetIntensity),
                                .float(strength)
                            ),
                            maxSampleOffset: .zero
                        )
                        .animation(.linear(duration: 1), value: noiseQuality)
                        .animation(.linear(duration: 1), value: noiseIntensity)
                        .animation(.linear(duration: 1), value: offsetIntensity)
                        .animation(.linear(duration: 1), value: colorOffsetIntensity)
                }

                ShowcaseParameter(
                    value: $noiseQuality,
                    name: Binding.constant("Noise Quality"),
                    editatble: Binding.constant(true),
                    range: Binding.constant(0 ... 1000)
                )
                ShowcaseParameter(
                    value: $noiseIntensity,
                    name: Binding.constant("Noise Intensity"),
                    editatble: Binding.constant(true),
                    range: Binding.constant(0 ... 20)
                )
                ShowcaseParameter(
                    value: $offsetIntensity,
                    name: Binding.constant("Offset Intensity"),
                    editatble: Binding.constant(true),
                    range: Binding.constant(0 ... 100)
                )
                ShowcaseParameter(
                    value: $colorOffsetIntensity,
                    name: Binding.constant("Color Offset Intensity"),
                    editatble: Binding.constant(true),
                    range: Binding.constant(0 ... 100)
                )
                ShowcaseParameter(
                    value: $strength,
                    name: Binding.constant("Strength"),
                    editatble: Binding.constant(true),
                    range: Binding.constant(0 ... 10)
                )
            }
        }
    }
}

#Preview {
    CanonEvent(
        name: .constant("Static Noise"),
        author: .constant("Raphael Salaja"),
        category: .constant(Categories.Layer)
    )
}
