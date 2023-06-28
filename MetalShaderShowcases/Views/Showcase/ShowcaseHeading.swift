//
//  ShaderDemonstration.swift
//  MetalShaderShowcases
//
//  Created by Raphael S on 25/06/2023.
//

import SwiftUI

struct ShowcaseHeading: View {
    @Binding var name: String
    @Binding var category: Categories
    @Binding var author: String

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(name).fontWeight(.medium)

                Spacer()

                CategoryButton(category: category)
            }
            Text("\(author)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    ShowcaseHeading(
        name: .constant("Name"),
        category: .constant(Categories.Color),
        author: .constant("Author")
    )
}
