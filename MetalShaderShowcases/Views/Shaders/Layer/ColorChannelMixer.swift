import SwiftUI

struct ColorChannelMixer: View {
    @Binding var name: String
    @Binding var description: String
    @Binding var author: String
    @Binding var category: Categories

    @State var red: Float = 0
    @State var green: Float = 0
    @State var blue: Float = 0

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
                    parameter: Binding.constant(Parameters.Float),
                    description: Binding.constant("Effects the red channel."),
                    editatble: Binding.constant(true)
                )

                ShowcaseParameter(
                    value: $green,
                    name: Binding.constant("Green"),
                    parameter: Binding.constant(Parameters.Float),
                    description: Binding.constant("Effects the green channel."),
                    editatble: Binding.constant(true)
                )

                ShowcaseParameter(
                    value: $blue,
                    name: Binding.constant("Blue"),
                    parameter: Binding.constant(Parameters.Float),
                    description: Binding.constant("Effects the blue channel."),
                    editatble: Binding.constant(true)
                )
            }
        }
    }
}

#Preview {
    ColorChannelMixer(
        name: .constant("Color Channel Mixer"),
        description: .constant("A color channel mixer effect."),
        author: .constant("Raphael Salaja"),
        category: .constant(Categories.Layer)
    )
}
