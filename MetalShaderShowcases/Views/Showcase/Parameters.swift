//
//  Parameters.swift
//  MetalShaderShowcases
//
//  Created by Raphael S on 25/06/2023.
//

import SwiftUI

struct Parameters: View {
    @Binding var value: Float
    @Binding var name: String
    @Binding var type: String
    @Binding var description: String

    var body: some View {
        Section {
            HStack {
                Text(name)
                    .fontWeight(.medium)

                Spacer()

                HStack {
                    HStack {
                        Text(type).font(Font.caption.bold())
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.green.tertiary)
                .cornerRadius(20)
            }

            Slider(value: $value, in: -10 ... 10, step: 0.5) {} minimumValueLabel: {
                Text("-10")
            } maximumValueLabel: {
                Text("10")
            }

        } header: {} footer: {
            Text(description)
        }
    }
}

#Preview {
    Parameters(
        value: .constant(0.5),
        name: .constant("Name"),
        type: .constant("Type"),
        description: .constant("Description")
    )
}
