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
                description: .constant("Blacklight is a lamp that emits long-wave ultraviolet light and very little visible light."),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Bloom",
            showcase: AnyView(Bloom(
                name: .constant("Bloom"),
                description: .constant("Bloom is a graphics effect used to reproduce an imaging artifact of real-world cameras."),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
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
            name: "Color Channel Mixer",
            showcase: AnyView(ColorChannelMixer(
                name: .constant("Color Channel Mixer"),
                description: .constant("Color Channel Mixer is a filter that allows you to mix the red, green, and blue channels of an image."),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Contrast",
            showcase: AnyView(Contrast(
                name: .constant("Contrast"),
                description: .constant("Contrast is the difference in luminance or color that makes an object distinguishable."),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Deepfry",
            showcase: AnyView(Deepfry(
                name: .constant("Deepfry"),
                description: .constant("Deepfry is a filter that makes an image appear as if it was deep fried."),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Distortion Waves",
            showcase: AnyView(Waves(
                name: .constant("Distortion"),
                description: .constant("Distortion is a filter that distorts an image by moving the pixels in a direction and amount specified by a texture."),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Dithering",
            showcase: AnyView(Dithering(
                name: .constant("Dithering"),
                description: .constant("Dithering is a technique used in computer graphics to create the illusion of color depth in images with a limited color palette."),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Edge Detection",
            showcase: AnyView(EdgeDetection(
                name: .constant("Edge Detection"),
                description: .constant("Edge Detection is a filter that highlights the edges of an image."),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Glitch",
            showcase: AnyView(Glitch(
                name: .constant("Glitch"),
                description: .constant("Glitch is a filter that distorts an image by moving the pixels in a direction and amount specified by a texture."),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),

        MetalShader(
            name: "Greyscale",
            showcase: AnyView(Greyscale(
                name: .constant("Greyscale"),
                description: .constant("Greyscale is a filter that converts an image to greyscale."),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Halftone",
            showcase: AnyView(Halftone(
                name: .constant("Halftone"),
                description: .constant("Halftone is a filter that converts an image to halftone."),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Infrared",
            showcase: AnyView(Infrared(
                name: .constant("Infrared"),
                description: .constant("Infrared is a filter that converts an image to infrared."),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Intensity",
            showcase: AnyView(Intensity(
                name: .constant("Intensity"),
                description: .constant("Intensity is a filter that adjusts the intensity setting of an image."),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Invert",
            showcase: AnyView(Invert(
                name: .constant("Invert"),
                description: .constant("Invert is a filter that inverts the colors of an image."),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Lens Flare",
            showcase: AnyView(LensFlare(
                name: .constant("Lens Flare"),
                description: .constant("Lens Flare is a filter that creates a lens flare effect."),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Loupe",
            showcase: AnyView(Loupe(
                name: .constant("Loupe"),
                description: .constant("Loupe is a filter that creates a loupe effect."),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Posterize",
            showcase: AnyView(Posterize(
                name: .constant("Posterize"),
                description: .constant("Posterize is a filter that posterizes an image."),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Sepia",
            showcase: AnyView(Sepia(
                name: .constant("Sepia"),
                description: .constant("Sepia is a filter that converts an image to sepia."),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        ),
        MetalShader(
            name: "Toon",
            showcase: AnyView(Toon(
                name: .constant("Toon"),
                description: .constant("Toon is a filter that converts an image to toon."),
                author: .constant("Raphael Salaja"),
                category: .constant(Categories.Layer)
            ))
        )
    ]
}
