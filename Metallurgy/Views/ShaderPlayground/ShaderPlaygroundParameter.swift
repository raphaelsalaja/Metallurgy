import SwiftUI

struct ShaderPlaygroundParameter: View {
    @Binding var value: Float
    @Binding var name: String
    @Binding var editatble: Bool
    @Binding var range: ClosedRange<Float>

    var body: some View {
        Section {
            VStack {
                HStack {
                    Text(name)
                        .fontWeight(.regular)
                        .foregroundStyle(.secondary)
                    Spacer()

                    if editatble {
                        Text("\(value, format: .number.precision(.fractionLength(2)))")
                            .fontWeight(.semibold)
                            .foregroundStyle(.primary)
                            .animation(.default, value: editatble)
                    }
                }
                if editatble {
                    Slider(value: $value, in: range, step: 0.01)
                }
            }
        }
    }
}

#Preview {
    ShaderPlaygroundParameter(
        value: Binding.constant(0.5),
        name: .constant("Name"),
        editatble: .constant(true),
        range: .constant(0.1 ... 10)
    )
}
