import SwiftUI

struct EdgeDetection: View {
    @Binding var name: String
    @Binding var description: String
    @Binding var author: String
    @Binding var category: Categories

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
                            ShaderLibrary.edge_detection(
                                .float(time.timeIntervalSinceNow)
                            ),
                            maxSampleOffset: .zero
                        )
                        .animation(.linear(duration: 1), value: time)
                }

                ShowcaseParameter(
                    value: Binding.constant(0.5),
                    name: Binding.constant("Time"),
                    parameter: Binding.constant(Parameters.Float),
                    description: Binding.constant("Effects the strength of the effect."),
                    editatble: Binding.constant(false),
                    range: Binding.constant(0 ... 10)
                )
            }
        }
    }
}

#Preview {
    EdgeDetection(
        name: .constant("Dihtering"),
        description: .constant("A dithering effect."),
        author: .constant("Raphael Salaja"),
        category: .constant(Categories.Layer)
    )
}