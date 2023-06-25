//
//  ShowcaseImage.swift
//  MetalShaderShowcases
//
//  Created by Raphael S on 21/06/2023.
//

import SwiftUI

struct ShowcaseImage: View {
    

    
    var body: some View {
        Image(.finderBigSur)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
            .frame(height: 200)
    }
}

#Preview {
    ShowcaseImage()
}
