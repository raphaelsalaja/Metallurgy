//
//  ShowcaseImage.swift
//  ShowcaseShowcases
//
//  Created by Raphael S on 21/06/2023.
//

import SwiftUI

struct ShowcaseVideo: View {
    var body: some View {
        Image(.finder)
            .resizable()
            .background(.clear)
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
            .frame(height: 200)
    }
}

#Preview {
    ShowcaseVideo()
}
