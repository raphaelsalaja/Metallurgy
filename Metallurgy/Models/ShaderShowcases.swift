import Foundation

final class ShaderShowcases: ObservableObject {
    var shaders: [Showcase] = [
        // MARK: - LAYER

        Showcase(name: "Posterize", function: "posterize", category: .Layer),
        Showcase(name: "Edge Detection", time: true, function: "edge_detection", category: .Layer),
        Showcase(name: "Chromatic Abberation (Time)", time: true, function: "chromatic_abberation_time", category: .Layer,
                 arguments: [
                     Argument(name: "Strength", range: 0 ... 10),
                 ]),
        Showcase(name: "Chromatic Abberation (Static)", function: "chromatic_abberation_static", category: .Layer,
                 arguments: [
                     Argument(name: "Red Channel", range: 0 ... 10),
                     Argument(name: "Blue Channel", range: 0 ... 10),
                 ]),
        Showcase(name: "TV Static", time: true, function: "tv_static", category: .Layer,
                 arguments: [
                     Argument(name: "Strength", range: 0 ... 10),
                 ]),
        Showcase(name: "Dithering", function: "dithering", category: .Layer,
                 arguments: [
                     Argument(name: "Strength", range: 0 ... 10),
                     Argument(name: "Size", range: 0 ... 10),
                 ]),
        Showcase(
            name: "Random Colors", function: "random_colors", category: .Layer,
            arguments: [
                Argument(name: "Colors Amount", range: 0 ... 50),
                Argument(name: "Strength", range: 0 ... 1),
            ]),
        Showcase(
            name: "Video Home System", time: true, function: "vhs", category: .Layer,
            arguments: [
                Argument(name: "Noise Quality", range: 0 ... 1000),
                Argument(name: "Noise Intensity", range: 0 ... 20),
                Argument(name: "Offset Intensity", range: 0 ... 100),
                Argument(name: "Color Offset Intensity", range: 0 ... 100),
                Argument(name: "Strength", range: 0 ... 10),
            ]),

        // MARK: - COLOR

        Showcase(name: "Invert", function: "invert", category: .Color),
        Showcase(name: "Intensity", function: "intensity", category: .Color),
        Showcase(name: "Deepfry", function: "deepfry", category: .Color),
        Showcase(name: "Bloom", function: "bloom", category: .Color),
        Showcase(name: "Blacklight", function: "blacklight", category: .Color),
        Showcase(name: "Contrast", function: "contrast", category: .Color),
        Showcase(name: "Sepia", function: "sepia", category: .Color),
        Showcase(name: "Greyscale", function: "greyscale", category: .Color),
        Showcase(name: "Exposure", function: "exposure", category: .Color),
        Showcase(
            name: "Color Channel Mixer", function: "color_channel_mixer", category: .Color,
            arguments: [
                Argument(name: "Red", range: 0 ... 10),
                Argument(name: "Green", range: 0 ... 10),
                Argument(name: "Blue", range: 0 ... 10),
            ]),
        Showcase(
            name: "Infrared", function: "infrared", category: .Color,
            arguments: [
                Argument(name: "Multiplier", range: 0 ... 10),
                Argument(name: "Strength", range: 0 ... 10),
            ]),

        // MARK: - DISTORTION

        Showcase(name: "Simple Wave", time: true, size: false, function: "simple_wave", category: .Distortion),
        Showcase(name: "Complex Wave", time: true, size: true, function: "complex_wave", category: .Distortion,
                 arguments: [
                     Argument(name: "Speed", range: 0 ... 1000),
                     Argument(name: "Strength", range: 0 ... 20),
                     Argument(name: "Frequency", range: 0 ... 100),
                 ]),
    ]
}
