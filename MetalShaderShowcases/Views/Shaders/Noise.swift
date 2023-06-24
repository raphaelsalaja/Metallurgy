//
//  Noise.swift
//  SwiftUIByExample
//
//  Created by Raphael S on 20/06/2023.
//

import SwiftUI

struct Noise: View {
    let startDate = Date()

    var body: some View {
        TimelineView(.animation) { _ in
            Image(systemName: "figure.run.circle.fill")
                .font(.system(size: 300))
                .colorEffect(ShaderLibrary.noise(.float(startDate.timeIntervalSinceNow)))
        }
    }
}

#Preview {
    Noise()
}
