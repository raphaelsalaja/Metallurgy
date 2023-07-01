//
//  ShowcaseImage.swift
//  MetalShaderShowcases
//
//  Created by Raphael S on 21/06/2023.
//

import SwiftUI

struct ShowcaseImage: View {
    var body: some View {
        Image(.showcase)
            .resizable()
            .background(.clear)
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
            .frame(height: 300)
    }
}

#Preview {
    ShowcaseImage()
}
