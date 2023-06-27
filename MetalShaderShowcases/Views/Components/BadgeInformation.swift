//
//  BadgeInformation.swift
//  MetalShaderShowcases
//
//  Created by Raphael S on 26/06/2023.
//

import MarkdownUI
import SwiftUI

struct BadgeInformation: View {
    var body: some View {
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
        .background(.clear)
        .scrollContentBackground(.hidden)
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
        .presentationBackground(.ultraThinMaterial)
    }
}

#Preview {
    BadgeInformation()
}
