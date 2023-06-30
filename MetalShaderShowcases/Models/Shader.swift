import Foundation
import Observation
import SwiftUI

enum Parameters: String, CaseIterable, Identifiable {
    var id: Self { return self }

    case Float
    case Integer
    case Bool

    var title: String {
        switch self {
        case .Float:
            return "Float"
        case .Integer:
            return "Integer"
        case .Bool:
            return "Bool"
        }
    }
}

enum Complexity: String, CaseIterable, Identifiable {
    var id: Self { return self }

    case Low
    case Medium
    case High

    var title: String {
        switch self {
        case .Low:
            return "Low"
        case .Medium:
            return "Medium"
        case .High:
            return "High"
        }
    }
}

enum Categories: String, CaseIterable, Identifiable {
    var id: Self { return self }

    case Color
    case Distortion
    case Layer

    var title: String {
        switch self {
        case .Color:
            return "Color"
        case .Distortion:
            return "Distortion"
        case .Layer:
            return "Layer"
        }
    }
}

enum SortingOptions: String, CaseIterable, Identifiable {
    var id: Self { return self }

    case Name
    case Author
    case Category
    case Complexity

    var title: String {
        switch self {
        case .Name:
            return "Name"
        case .Author:
            return "Author"
        case .Category:
            return "Category"
        case .Complexity:
            return "Complexity"
        }
    }
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
                category: .constant(Categories.Color)
            ))
        ),

        MetalShader(
            name: "Chromatic Aberration",
            showcase: AnyView(ChromaticAbberation(
                name: .constant("Chromatic Aberration"),
                description: .constant("Chromatic aberration is a failure of a lens to focus all colors to the same point. It is caused by dispersion: the refractive index of the lens elements varies with the wavelength of light."),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),

        MetalShader(
            name: "Waves",
            showcase: AnyView(Waves(
                name: .constant("Waves"),
                description: .constant("Waves are a disturbance that transfers energy through matter or space, with little or no associated mass transport. They consist, instead, of oscillations or vibrations around almost fixed locations."),
                author: .constant("Paul Hudson, Raphael Salaja"),
                category: .constant(Categories.Distortion)
            ))
        )
    ]
}
