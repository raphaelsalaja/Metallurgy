import SwiftUI

struct RandomColors: View {
    @Binding var name: String
    @Binding var author: String
    @Binding var category: Categories

    @State var amount: Float = 10.0
    @State var strength: Float = 1.0

    var body: some View {
        TimelineView(.animation) { _ in
            List {
                Section {
                    ShowcaseHeading(
                        name: .constant(name),
                        category: .constant(category),
                        author: .constant(author)
                    )
           
                    Image(.car)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .layerEffect(
                            ShaderLibrary.random(
                                .float(amount),
                                .float(strength)
                            ),
                            maxSampleOffset: .zero
                        )
                        .animation(.linear(duration: 1), value: amount)
                        .animation(.linear(duration: 1), value: strength)
                        .listRowInsets(EdgeInsets())
                }

                ShowcaseParameter(
                    value: $amount,
                    name: Binding.constant("Colors Amount"),
                    editatble: Binding.constant(true),
                    range: Binding.constant(0 ... 100)
                )
                ShowcaseParameter(
                    value: $strength,
                    name: Binding.constant("Strength"),
                    editatble: Binding.constant(true),
                    range: Binding.constant(0 ... 1)
                )
            }
        }
    }
}

#Preview {
    RandomColors(
        name: .constant("Random Colors"),
        author: .constant("Raphael Salaja"),
        category: .constant(Categories.Layer)
    ).preferredColorScheme(.dark)
}
