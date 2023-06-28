import Foundation
import Observation
import SwiftUI

enum Parameters {
    case Float
    case Integer
    case Bool
}

enum Categories {
    case Color
    case Distortion
    case Layer
    case Mixed
}

enum Complexity {
    case Low
    case Medium
    case High
}

enum Filters: String, CaseIterable, Identifiable {
    var id: Self { return self }

    case Color
    case Distortion
    case Layer
    case None

    var title: String {
        switch self {
        case .Color:
            return "Color"
        case .Distortion:
            return "Distortion"
        case .Layer:
            return "Layer"
        case .None:
            return "None"
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
    let author: String
    let category: Categories
    let complexity: Complexity
    let showcase: AnyView

    public init(name: String, showcase: AnyView) {
        self.name = name
        self.author = "Unknown"
        self.category = .Color
        self.complexity = .Low
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
