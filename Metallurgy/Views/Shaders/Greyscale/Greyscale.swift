import SwiftUI

struct Greyscale: View {
    @Binding var name: String
    @Binding var author: String
    @Binding var category: Categories

    @State var strength: Float = 0

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
                            ShaderLibrary.greyscale(
                                .float(strength)
                            ),
                            maxSampleOffset: .zero
                        )
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
    Greyscale(
        name: .constant("Greyscale"),
        author: .constant("Raphael Salaja"),
        category: .constant(Categories.Layer)
    )
}
