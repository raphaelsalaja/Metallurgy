import SwiftUI

struct Sepia: View {
    @Binding var name: String
    
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
                value: strength,
                name: Binding.constant("Strength"),
                
                editatble: Binding.constant(true),
                    range: Binding.constant(0 ... 10)
            )
        }
    }
}

#Preview {
    Sepia(
        name: .constant("Sepia"),
        author: .constant("Raphael Salaja"),
        category: .constant(Categories.Color)
    )
}
