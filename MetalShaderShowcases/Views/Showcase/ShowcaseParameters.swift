//
//  Parameters.swift
//  MetalShaderShowcases
//
//  Created by Raphael S on 25/06/2023.
//

import SwiftUI

struct ShowcaseParameters: View {
    @Binding var value: Float
    @Binding var name: String
    @Binding var type: BadgeType
    @Binding var description: String
    @Binding var editatble: Bool

    var body: some View {
        Section {
            HStack {
                Text(name).fontWeight(.medium)

                Spacer()

                BadgeButtton(type: .constant(type))
            }

            if editatble {
                Slider(value: $value, in: -10 ... 10, step: 0.5) {} minimumValueLabel: {
                    Text("-10")
                } maximumValueLabel: {
                    Text("10")
                }
            } else {}

        } header: {} footer: {
            Text(description)
        }
    }
}

#Preview {
    ShowcaseParameters(
        value: .constant(0.5),
        name: .constant("Name"),
        type: .constant(BadgeType.Float),
        description: .constant("Description"),
        editatble: .constant(true)
    )
}
