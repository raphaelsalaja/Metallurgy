import SwiftUI

struct ChromaticAbberation: View {
    @Binding var name: String
    @Binding var author: String
    @Binding var category: Categories

    @State var red: Float = 0
    @State var green: Float = 0
    @State var blue: Float = 0
    @State var state: Float = 0
    @State var startDate = Date()

    @State var time = Float(Date().timeIntervalSince1970)

    var body: some View {
        TimelineView(.animation) { _ in
            List {
                Section {
                    ShowcaseHeading(
                        name: .constant(name),
                        category: .constant(category),
                        author: .constant(author)
                    )

                    if state == 0 {
                        ShowcaseImage()
                            .layerEffect(
                                ShaderLibrary.chromatic_abberation(
                                    .float(red),
                                    .float(green),
                                    .float(blue)
                                ),
                                maxSampleOffset: .zero
                            )
                            .animation(.linear(duration: 1), value: red)
                            .animation(.linear(duration: 1), value: green)
                            .animation(.linear(duration: 1), value: blue)
                    } else {
                        ShowcaseImage()
                            .layerEffect(
                                ShaderLibrary.chromatic_abberation_shift(
                                    .float(startDate.timeIntervalSinceNow)
                                ),
                                maxSampleOffset: .zero
                            )
                            .animation(.linear(duration: 1), value: startDate)
                    }

                    Picker("Type", selection: $state) {
                        Text("Static").tag(Float(0))
                        Text("Shifty").tag(Float(1))
                    }
                }

                if state == 0 {
                    ShowcaseParameter(
                        value: $red,
                        name: Binding.constant("Red"),

                        editatble: Binding.constant(true),
                        range: Binding.constant(0 ... 10)
                    )
                    ShowcaseParameter(
                        value: $green,
                        name: Binding.constant("Green"),

                        editatble: Binding.constant(true),
                        range: Binding.constant(0 ... 10)
                    )
                    ShowcaseParameter(
                        value: $blue,
                        name: Binding.constant("Blue"),

                        editatble: Binding.constant(true),
                        range: Binding.constant(0 ... 10)
                    )
                } else {
                    ShowcaseParameter(
                        value: $time,
                        name: Binding.constant("Time"),

                        editatble: Binding.constant(false),
                        range: Binding.constant(0 ... 10)
                    )
                }
            }
        }
    }
}

#Preview {
    ChromaticAbberation(
        name: .constant("Chromatic Abberation"),
        author: .constant("Raphael Salaja"),
        category: .constant(Categories.Layer)
    )
}
