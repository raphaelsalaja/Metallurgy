//
//  Shader.swift
//  MetalShaderShowcases
//
//  Created by Raphael S on 23/06/2023.
//
import Foundation
import Observation
import SwiftUI

enum BadgeType {
    case Color
    case Distortion
    case Layer
    case Float
    case Bool
}

@Observable
struct MetalShader: Identifiable {
    var id = UUID()
    let name: String
    let showcase: AnyView

    public init(name: String, showcase: AnyView) {
        self.name = name
        self.showcase = showcase
    }
}

final class ShaderShowcases {
    var shaders: [MetalShader] = [
        MetalShader(
            name: "Sepia",
            showcase: AnyView(Sepia(
                name: .constant("Sepia"),
                description: .constant("Sepia makes photos appear hazy, warm, and a bit sentimental. Inverting it makes the photo appear cooler."),
                author: .constant("Raphael Salaja"),
                category: .constant(BadgeType.Color)
            ))
        ),

        MetalShader(
            name: "Chromatic Aberration",
            showcase: AnyView(ChromaticAbberation(
                name: .constant("Chromatic Aberration"),
                description: .constant("Chromatic aberration is a failure of a lens to focus all colors to the same point. It is caused by dispersion: the refractive index of the lens elements varies with the wavelength of light."),
                author: .constant("Raphael Salaja"),
                category: .constant(BadgeType.Layer)
            ))
        ),

        MetalShader(
            name: "Blur",
            showcase: AnyView(Blur(
                name: .constant("Blur"),
                description: .constant("Blur is a common effect used to hide details or to make details less visible. It can also be used to create a sense of motion."),
                author: .constant("Raphael Salaja"),
                category: .constant(BadgeType.Layer)
            ))
        )
    ]
}
