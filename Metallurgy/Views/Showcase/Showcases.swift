import Foundation

final class ShaderShowcases {
    var shaders: [MetalShader] = [
        MetalShader(
            name: "Blacklight",
            author: "Raphael Salaja",
            function: "blacklight",
            category: .Layer,
            arguments: [Argument(name: "Strength", range: 0 ... 10)]
        ),
        MetalShader(
            name: "Bloom",
            author: "Raphael Salaja",
            function: "bloom",
            category: .Layer,
            arguments: [Argument(name: "Strength", range: 0 ... 10)]
        ),
        MetalShader(
            name: "Chromatic Abberation (Static)",
            author: "Raphael Salaja",
            function: "chromatic_abberation_static",
            category: .Layer,
            arguments: [
                Argument(name: "Red", range: 0 ... 10),
                Argument(name: "Green", range: 0 ... 10),
                Argument(name: "Blue", range: 0 ... 10),
            ]
        ),
    ]
}
