import SwiftUI

struct ColorChannelMixer: View {
    @Binding var name: String
    @Binding var author: String
    @Binding var category: Categories

    @State var red: Float = 1
    @State var green: Float = 1
    @State var blue: Float = 1

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
                            ShaderLibrary.multiply_color_channel(
                                .float(red),
                                .float(green),
                                .float(blue)
                            ),
                            maxSampleOffset: .zero
                        )
                        .animation(.linear(duration: 1), value: red)
                        .animation(.linear(duration: 1), value: green)
                        .animation(.linear(duration: 1), value: blue)
                }

                ShowcaseParameter(
                    value: $red,
                    name: Binding.constant("Red"),
                    
                    editatble: Binding.constant(true),
                    range: Binding.constant(1 ... 10)
                )

                ShowcaseParameter(
                    value: $green,
                    name: Binding.constant("Green"),
                    
                    editatble: Binding.constant(true),
                    range: Binding.constant(1 ... 10)
                )

                ShowcaseParameter(
                    value: $blue,
                    name: Binding.constant("Blue"),
                    
                    editatble: Binding.constant(true),
                    range: Binding.constant(1 ... 10)
                )
            }
        }
    }
}

#Preview {
    ColorChannelMixer(
        name: .constant("Color Channel Mixer"),
        author: .constant("Raphael Salaja"),
        category: .constant(Categories.Layer)
    )
}
