//
//  ShaderLink.swift
//  MetalShaderShowcases
//
//  Created by Raphael S on 22/06/2023.
//

import SwiftUI

struct ShaderNavigationLink: View {
    var body: some View {
        NavigationLink {
            SimpleWave()
        } label: {
            HStack {
                Label {
                    VStack(alignment: .leading) {
                        Text("Simple Wave").font(.headline)
                        Text("by @twostraws")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                } icon: {}
            }
        }
    }
}

#Preview {
    ShaderNavigationLink()
}
