//
//  ShaderViewModel.swift
//  MetalShaderShowcases
//
//  Created by Raphael S on 21/06/2023.
//

import Foundation
import SwiftUI

class ShaderViewModel: ObservableObject {
    @Published var shaders: [Shader] = []

    init() {
        load()
    }

  
}
