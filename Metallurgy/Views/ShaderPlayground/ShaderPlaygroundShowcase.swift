//
//  ShaderPlaygroundShowcase.swift
//  Metallurgy
//
//  Created by Raphael S on 19/07/2023.
//

import SwiftUI

struct ShaderPlaygroundShowcase: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 32)

                .overlay(OverlayImage, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 32))

            RoundedRectangle(cornerRadius: 32)
                .strokeBorder(Color(red: 1, green: 1, blue: 1, opacity: 0.5),
                              lineWidth: 6)
        }
        // .frame(width: 295, height: 360)
        // .frame(width: 295)
    }

    private var OverlayImage: some View {
        VStack {
            Image(.woman)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    ShaderPlaygroundShowcase()
}
