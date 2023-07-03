//
//  DocumentationView.swift
//  MetalShaderShowcases
//
//  Created by Raphael S on 27/06/2023.
//

import SwiftUI

struct DocumentationView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack(alignment: .leading,
                           spacing: 10)
                    {
                        Text("Coming Soon").font(.subheadline)
                    }
                }
            }
        }
    }
}

#Preview {
    DocumentationView()
}
