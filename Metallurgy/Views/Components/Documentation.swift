//
//  BadgeInformation.swift
//  MetalShaderShowcases
//
//  Created by Raphael S on 26/06/2023.
//

import SwiftUI

struct Documentation: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack(alignment: .leading,
                           spacing: 10)
                    {
                        Text("Structure").font(.subheadline)
                        Text("Float").font(.headline)
                        Text("A single-precision, floating-point value type.").font(.body)
                    }
                }
            }
            .searchable(text: .constant(""))
        }
    }
}

#Preview {
    Documentation()
}
