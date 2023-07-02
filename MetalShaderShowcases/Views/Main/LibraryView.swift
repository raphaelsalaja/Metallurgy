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
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        shaders = ShaderShowcases().shaders
                    }) {
                        Image(systemName: "ellipsis")
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        shaders = ShaderShowcases().shaders
                    }) {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
            }
            .searchable(text: .constant(""),
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Search")
            .navigationTitle("Library")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

#Preview {
    LibraryView()
}
