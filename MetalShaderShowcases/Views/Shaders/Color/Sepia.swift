import SwiftUI

struct Sepia: View {
    @Binding var name: String
    @Binding var description: String
    @Binding public var author: String
    @Binding var category: Categories
    @State var strength: Float = 0
    @State var showingSheet = false

    var body: some View {
        List {
            Section {
                ShowcaseHeading(
                    name: .constant(name),
                    category: .constant(Categories.Color),
                    author: .constant(author)
                )

                ShowcaseImage()
                    .colorEffect(ShaderLibrary.sepia(.float(strength)))
                    .animation(.linear(duration: 1), value: strength)
            }

            ShowcaseParameter(
                value: $strength,
                name: Binding.constant("Strength"),
                parameter: Binding.constant(Parameters.Float),
                description: Binding.constant("Effects the overall strength of the effect."),
                editatble: Binding.constant(true)
            )
        }
    }
}

#Preview {
    Sepia(
        name: .constant("Sepia"),
        description: .constant("A sepia tone effect."),
        author: .constant("Raphael Salaja"),
        category: .constant(Categories.Color)
    )
}
