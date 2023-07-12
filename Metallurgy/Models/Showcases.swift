import Foundation

final class ShaderShowcases {
    var shaders: [Showcase] = [
        Showcase(
            name: "Blacklight", function: "blacklight",
            arguments: [
                Argument(name: "Strength", range: 0 ... 10),
            ]
        ),
        Showcase(
            name: "Bloom", function: "bloom",
            arguments: [
                Argument(name: "Strength", range: 0 ... 10),
            ]
        ),
        Showcase(
            name: "Chromatic Abberation (Static)", function: "chromatic_abberation_static",
            arguments: [
                Argument(name: "Red", range: 0 ... 10),
                Argument(name: "Green", range: 0 ... 10),
                Argument(name: "Blue", range: 0 ... 10),
            ]
        ),
        Showcase(
            name: "Chromatic Abberation (Time)", function: "chromatic_abberation_shift", category: .Layer, time: true,
            arguments: [
                Argument(name: "Red", range: 0 ... 10),
                Argument(name: "Green", range: 0 ... 10),
                Argument(name: "Blue", range: 0 ... 10),
            ]
        ),
        Showcase(
            name: "Chromatic Channel Mixer", function: "color_channel_mixer",
            arguments: [
                Argument(name: "Red", range: 0 ... 10),
                Argument(name: "Green", range: 0 ... 10),
                Argument(name: "Blue", range: 0 ... 10),
            ]
        ),
        Showcase(
            name: "Contrast", function: "contrast",
            arguments: [
                Argument(name: "Strength", range: 0 ... 10),
            ]
        ),
        Showcase(
            name: "Deepfry", function: "deepfry",
            arguments: [
                Argument(name: "Strength", range: 0 ... 10),
            ]
        ),
        Showcase(
            name: "Dithering", function: "dithering",
            arguments: [
                Argument(name: "Strength", range: 0 ... 10),
            ]
        ),
        Showcase(
            name: "Edge Detection", function: "edge_detection",
            arguments: [
                Argument(name: "Strength", range: 0 ... 10),
            ]
        ),
        Showcase(
            name: "Greyscale", function: "greyscale",
            arguments: [
                Argument(name: "Strength", range: 0 ... 10),
            ]
        ),
        Showcase(
            name: "Halftone", function: "halftone",
            arguments: [
                Argument(name: "Strength", range: 0 ... 10),
            ]
        ),
        Showcase(
            name: "Infrared", function: "infrared",
            arguments: [
                Argument(name: "Strength", range: 0 ... 10),
            ]
        ),
        Showcase(
            name: "Intensity", function: "intensity",
            arguments: [
                Argument(name: "Strength", range: 0 ... 10),
            ]
        ),
        Showcase(
            name: "Invert", function: "invert",
            arguments: [
                Argument(name: "Strength", range: 0 ... 10),
            ]
        ),
        Showcase(
            name: "Posterize", function: "posterize",
            arguments: [
                Argument(name: "Strength", range: 0 ... 10),
            ]
        ),
        Showcase(
            name: "Random Colors", function: "random_colors",
            arguments: [
                Argument(name: "Strength", range: 0 ... 10),
            ]
        ),
        Showcase(
            name: "Sepia", function: "sepia", category: .Color,
            arguments: [
                Argument(name: "Strength", range: 0 ... 10),
            ]
        ),
        Showcase(
            name: "Static Noise", function: "static_noise",
            arguments: [
                Argument(name: "Strength", range: 0 ... 10),
            ]
        ),
        Showcase(
            name: "VHS", function: "vhs",
            arguments: [
                Argument(name: "Strength", range: 0 ... 10),
            ]
        ),
        Showcase(
            name: "Waves", function: "waves", category: .Distortion,
            arguments: [
                Argument(name: "Strength", range: 0 ... 10),
            ]
        ),
    ]
}
