//
//  Emboss.swift
//  SwiftUIByExample
//
//  Created by Raphael S on 20/06/2023.
//

import SwiftUI

struct Emboss: View {
    @State private var strength = 3.0

    var body: some View {
        VStack {
            Image(.showcase)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 400)
                .foregroundStyle(.linearGradient(colors: [.orange, .red], startPoint: .top, endPoint: .bottom))
                .font(.system(size: 300))
                .layerEffect(ShaderLibrary.emboss(.float(strength)), maxSampleOffset: .zero)

            Slider(value: $strength, in: 0 ... 20)
        }
        .padding()
    }
}

#Preview {
    Emboss()
}
