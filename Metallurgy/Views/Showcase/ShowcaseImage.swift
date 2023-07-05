//
//  ShowcaseImage.swift
//  MetalShaderShowcases
//
//  Created by Raphael S on 21/06/2023.
//

import SwiftUI

struct ShowcaseImage: View {
    var body: some View {
        Image(.car)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
            .listRowInsets(EdgeInsets())
    }
}

#Preview {
    ShowcaseImage()
}
