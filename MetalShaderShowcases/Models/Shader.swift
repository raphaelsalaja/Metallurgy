//
//  Shader.swift
//  MetalShaderShowcases
//
//  Created by Raphael S on 23/06/2023.
//
import Foundation
import Observation
import SwiftUI

@Observable
struct MetalShader: Identifiable {
    var id = UUID()
    let name: String
    let description: String
    let author: String
    let category: String
    let showcase: AnyView

    public init(name: String, description: String, author: String, category: String, showcase: AnyView) {
        self.name = name
        self.description = description
        self.author = author
        self.category = category
        self.showcase = showcase
    }
}

final class ShaderShowcases {
    var shaders: [MetalShader] = [
        MetalShader(
            name: "Sepia",
            description: "Sepia makes photos appear hazy, warm, and a bit sentimental. Inverting it makes the photo appear cooler.",
            author: "Raphael S",
            category: "Color",
            showcase: AnyView(Sepia())
        ),
        MetalShader(
            name: "Chromatic Abberation",
            description: "Chromatic Abberation is a distortion effect that makes the image appear as if it was viewed through a prism.",
            author: "Raphael S",
            category: "Color",
            showcase: AnyView(ChromaticAbberation())
        ),
    ]

    var categories: [String] = [
        "Color",
        "Layer",
        "Distortion",
    ]
}
