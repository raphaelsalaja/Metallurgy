//
//  LibraryView.swift
//  MetalShaderShowcases
//
//  Created by Raphael S on 27/06/2023.
//

import SwiftUI

struct LibraryView: View {
    @State var shaders = ShaderShowcases().shaders

    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(shaders) { shader in
                        NavigationLink(destination: shader.showcase) {
                            Text(shader.name)
                        }
                    }
                }
            }
            .navigationTitle("Library")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    LibraryView()
}
