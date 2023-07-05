import SwiftUI

struct StaticNoise: View {
    @Binding var name: String
    @Binding var author: String
    @Binding var category: Categories

    @State var strength: Float = 1
    @State var size: Float = 1

    @State var dummy1: Float = 1
    @State var dummy2: Float = 1
    @State var dummy3: Float = 1

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
                            ShaderLibrary.tape(
                                .float(time.timeIntervalSinceNow),
                                .float(strength)
                            ),
                            maxSampleOffset: .zero
                        )
                        .layerEffect(
                            ShaderLibrary.exposure(
                                .float(0.4)
                            ),
                            maxSampleOffset: .zero
                        )
                        .layerEffect(
                            ShaderLibrary.dithering(
                                .float(2.0),
                                .float(1.2)
                            ),
                            maxSampleOffset: .zero
                        )
                        .animation(.linear(duration: 1), value: strength)
                        .animation(.linear(duration: 1), value: size)
                }
            }
        }
    }
}

#Preview {
    StaticNoise(
        name: .constant("Static Noise"),
        author: .constant("Raphael Salaja"),
        category: .constant(Categories.Layer)
    )
}
