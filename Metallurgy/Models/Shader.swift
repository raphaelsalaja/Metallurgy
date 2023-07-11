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

struct Argument: Identifiable {
    var id = UUID()
    let name: String
    var value: Float
    let range: ClosedRange<Float>
    let editable: Bool

    init(name: String, range: ClosedRange<Float>) {
        self.name = name
        self.value = (range.lowerBound + range.upperBound) / 2
        self.range = range
        self.editable = true
    }
}

@Observable
struct MetalShader: Identifiable {
    var id = UUID()
    let name: String
    let author: String
    let isTimeBased: Bool
    let function: String
    let category: Categories
    var arguments: [Argument] = []

    init(name: String, author: String, function: String, category: Categories, arguments: [Argument]) {
        self.name = name
        self.author = author
        self.isTimeBased = false
        self.function = function
        self.category = category
        self.arguments = arguments
    }
}

final class ShaderShowcases {
    var shaders: [MetalShader] = [
        MetalShader(
            name: "Blacklight",
            author: "Raphael Salaja",
            function: "blacklight",
            category: .Layer,
            arguments: [Argument(name: "Strength", range: 0 ... 10)]
        ),
    ]
}
