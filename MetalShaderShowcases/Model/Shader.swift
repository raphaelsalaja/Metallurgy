//
//  ShaderModel.swift
//  MetalShaderShowcases
//
//  Created by Raphael S on 21/06/2023.
//

import Foundation
import Observation

@Observable
final class Shaders {
    let shaders: [Shader] = [
        Shader(name: "Sepia", description: "A simple sepia filter", author: "Raphael", function: "sepia"),
    ]
}

struct Shader: Decodable, Identifiable {
    var id = UUID()
    var name, description, author, function: String
}
