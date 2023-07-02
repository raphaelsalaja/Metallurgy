//
//  Parameterss.swift
//  MetalShaderShowcases
//
//  Created by Raphael S on 25/06/2023.
//

import SwiftUI

struct ShowcaseParameter: View {
    @Binding var value: Float
    @Binding var name: String
    @Binding var parameter: Parameters
    @Binding var description: String
    @Binding var editatble: Bool
    @Binding var range: ClosedRange<Float>

    var body: some View {
        Section {
            HStack {
                Text(name).fontWeight(.medium)

                Spacer()

                ParameterButtton(parameter: parameter)
            }

            if editatble {
                Slider(value: $value, in: range, step: 0.5) {} minimumValueLabel: {
                    Text(range.lowerBound, format: .number.precision(.fractionLength(0)))
                } maximumValueLabel: {
                    Text(range.upperBound, format: .number.precision(.fractionLength(0)))
                }
            } else {}
        }
    }
}

#Preview {
    ShowcaseParameter(
        value: .constant(0.5),
        name: .constant("Name"),
        parameter: .constant(Parameters.Float),
        description: .constant("Description"),
        editatble: .constant(true),
        range: .constant(0.1 ... 10)
    )
}
