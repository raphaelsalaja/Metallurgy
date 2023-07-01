import SwiftUI

struct Scanlines: View {
    @Binding var name: String
    @Binding var description: String
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
                            ShaderLibrary.vhs_test(
                                .float(time.timeIntervalSinceNow)
                            ),
                            maxSampleOffset: .zero
                        )
                        .animation(.linear(duration: 1), value: strength)
                }

                ShowcaseParameter(
                    value: $strength,
                    name: Binding.constant("Strength"),
                    parameter: Binding.constant(Parameters.Float),
                    description: Binding.constant("Effects the strength of the effect."),
                    editatble: Binding.constant(true)
                )
            }
        }
    }
}

#Preview {
    Blacklight(
        name: .constant("Blacklight"),
        description: .constant("A blacklight effect."),
        author: .constant("Raphael Salaja"),
        category: .constant(Categories.Layer)
    )
}
