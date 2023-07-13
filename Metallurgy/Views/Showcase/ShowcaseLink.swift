//
//  ShowcaseLink.swift
//  Metallurgy
//
//  Created by Raphael S on 06/07/2023.
//

import SwiftUI

struct ShowcaseLink: View {
    @State var showcase: Showcase

    func GetIcon() -> Image {
        switch showcase.category {
        case .Distortion:
            return Image(systemName: "scale.3d")
        case .Layer:
            return Image(systemName: "square.fill.on.square.fill")
        case .Color:
            return Image(systemName: "swatchpalette.fill")
        }
    }

    func color() -> Color {
        switch showcase.category {
        case .Distortion:
            return .blue
        case .Layer:
            return .green
        case .Color:
            return .purple
        }
    }

    var body: some View {
        NavigationLink(destination: ShowcaseModelView(showcase: showcase)) {
            HStack(spacing: 12) {
                Text(showcase.name)
            }
        }
    }
}

#Preview {
    ShowcaseLink(showcase: ShaderShowcases().shaders[0])
}
