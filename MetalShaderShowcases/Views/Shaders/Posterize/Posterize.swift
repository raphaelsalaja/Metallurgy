//
//  Posterize.swift
//  MetalShaderShowcases
//
//  Created by Raphael S on 01/07/2023.
//

import SwiftUI

struct Posterize: View {
    @Binding var name: String
    @Binding var description: String
    @Binding var author: String
    @Binding var category: Categories
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    Posterize(       name: .constant("Blacklight"),
                     description: .constant("A blacklight effect."),
                     author: .constant("Raphael Salaja"),
                     category: .constant(Categories.Layer)
                 )
             }

