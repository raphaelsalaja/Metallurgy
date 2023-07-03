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
            name: "Blacklight",
            showcase: AnyView(Blacklight(
                name: .constant("Blacklight"),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Bloom",
            showcase: AnyView(Bloom(
                name: .constant("Bloom"),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Chromatic Aberration",
            showcase: AnyView(ChromaticAbberation(
                name: .constant("Chromatic Aberration"),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Color Channel Mixer",
            showcase: AnyView(ColorChannelMixer(
                name: .constant("Color Channel Mixer"),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Contrast",
            showcase: AnyView(Contrast(
                name: .constant("Contrast"),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Deepfry",
            showcase: AnyView(Deepfry(
                name: .constant("Deepfry"),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Distortion Waves",
            showcase: AnyView(Waves(
                name: .constant("Distortion"),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Dithering",
            showcase: AnyView(Dithering(
                name: .constant("Dithering"),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Edge Detection",
            showcase: AnyView(EdgeDetection(
                name: .constant("Edge Detection"),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Greyscale",
            showcase: AnyView(Greyscale(
                name: .constant("Greyscale"),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Halftone",
            showcase: AnyView(Halftone(
                name: .constant("Halftone"),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Infrared",
            showcase: AnyView(Infrared(
                name: .constant("Infrared"),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Intensity",
            showcase: AnyView(Intensity(
                name: .constant("Intensity"),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Invert",
            showcase: AnyView(Invert(
                name: .constant("Invert"),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Loupe",
            showcase: AnyView(Loupe(
                name: .constant("Loupe"),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Posterize",
            showcase: AnyView(Posterize(
                name: .constant("Posterize"),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Sepia",
            showcase: AnyView(Sepia(
                name: .constant("Sepia"),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Toon",
            showcase: AnyView(Toon(
                name: .constant("Toon"),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        )
    ]
}
