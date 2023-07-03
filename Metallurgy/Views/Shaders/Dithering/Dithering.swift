import SwiftUI

struct Dithering: View {
    @Binding var name: String
    @Binding var author: String
    @Binding var category: Categories

    @State var strength: Float = 0
    @State var size: Float = 4

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
                            ShaderLibrary.dithering(
                                .float(strength),
                                .float(size)
                            ),
                            maxSampleOffset: .zero
                        )
                        .animation(.linear(duration: 1), value: strength)
                        .animation(.linear(duration: 1), value: size)
                }

                ShowcaseParameter(
                    value: $strength,
                    name: Binding.constant("Strength"),
                    editatble: Binding.constant(true),
                    range: Binding.constant(-10 ... 10)
                )

                ShowcaseParameter(
                    value: $size,
                    name: Binding.constant("Pixel Size"),
                    editatble: Binding.constant(true),
                    range: Binding.constant(1 ... 5)
                )
            }
        }
    }
}

#Preview {
    Dithering(
        name: .constant("Dithering"),
        author: .constant("Raphael Salaja"),
        category: .constant(Categories.Layer)
    )
}
